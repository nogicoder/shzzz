import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:shzzz/shared/index.dart';

import 'package:shzzz/data/index.dart';

part 'todo_table.g.dart';

class Todos extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().nullable()();
  IntColumn get category => integer().nullable()();
  DateTimeColumn get createdTime => dateTime().nullable()();
  DateTimeColumn get dueTime => dateTime()();
  DateTimeColumn get completedTime =>
      dateTime().named('completedTime').nullable()();
  BoolColumn get isCompleted =>
      boolean().nullable().withDefault(const Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Todos])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  clear() async => await delete(todos).go();

  Stream<List<Todo>> getTodosWithStatus({bool isCompleted = false}) =>
      (select(todos)..where((tbl) => tbl.isCompleted.equals(isCompleted)))
          .watch();

  Stream<List<TodoCount>> getCompletedCountByCompletionTime() {
    return customSelect(
        'SELECT COUNT(id) AS "itemCount", completedTime FROM todos WHERE is_completed IS TRUE GROUP BY completedTime ORDER BY completedTime',
        readsFrom: {todos}).watch().map((rows) {
      final _todoCounts = <TodoCount>[];
      for (final row in rows) {
        final _time = DateTime.fromMillisecondsSinceEpoch(
            (row.data['completedTime'] as int) * 1000);

        final _item = _todoCounts.firstWhere(
          (element) => checkEqualsDate(element.dateTime!, _time),
          orElse: () => TodoCount(),
        );

        if (_item.dateTime == null) {
          _todoCounts
              .add(TodoCount(count: row.read('itemCount'), dateTime: _time));
        } else {
          _item.count += 1;
        }
      }
      return _todoCounts;
    });
  }

  Stream<List<TodoCount>> getCountByDueTime() {
    return customSelect(
        'SELECT COUNT(id) AS "itemCount", due_time FROM todos GROUP BY due_time ORDER BY due_time',
        readsFrom: {todos}).watch().map((rows) {
      final _todoCounts = <TodoCount>[];
      for (final row in rows) {
        final _time = DateTime.fromMillisecondsSinceEpoch(
            (row.data['due_time'] as int) * 1000);
        final _item = _todoCounts.firstWhere(
          (element) => checkEqualsDate(element.dateTime!, _time),
          orElse: () => TodoCount(),
        );

        if (_item.dateTime == null) {
          _todoCounts
              .add(TodoCount(count: row.read('itemCount'), dateTime: _time));
        } else {
          _item.count += 1;
        }
      }
      return _todoCounts;
    });
  }

  checkEqualsDate(DateTime first, DateTime second) =>
      first.formatDMY == second.formatDMY;

  Future<int> addTodo(TodosCompanion entry) {
    return into(todos).insert(entry);
  }

  Future<int> updateTodo(Todo todo) {
    return (update(todos)..where((tbl) => tbl.id.equals(todo.id))).write(
      TodosCompanion(
        title: Value(todo.title),
        content: Value.ofNullable(todo.content),
        dueTime: Value.ofNullable(todo.dueTime),
        isCompleted: Value.ofNullable(
          !(todo.isCompleted ?? false),
        ),
      ),
    );
  }

  Future<int> updateCompletion(Todo todo) {
    return (update(todos)..where((tbl) => tbl.id.equals(todo.id))).write(
        TodosCompanion(
            isCompleted: Value.ofNullable(!(todo.isCompleted ?? false)),
            completedTime: Value(DateTime.now())));
  }

  Future deleteEntry(Todo entry) {
    return delete(todos).delete(entry);
  }
}
