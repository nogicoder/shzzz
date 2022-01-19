import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:shzzz/shared/index.dart';

import 'package:shzzz/data/index.dart';

part 'todo_table.g.dart';

/// Define the table schema
/// - id: Auto incremented integer
/// - title: Todo's tile
/// - content: Todo's note
/// - category: Todo's category (implemented in later phase)
/// - createdTime: Created date and time of a todo item
/// - dueTime: Due date and time of a todo item
/// - completedTime: Completed date and time of a todo item
/// - isCompleted: Whether the todo item is completed or not
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

/// Open the connection to the database by accessing the database file
LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

/// [MyDatabase] represents the Database that the app will fetch and write the
/// data into
/// This class provides several methods to perform CRUD on the database
@DriftDatabase(tables: [Todos])
class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

  /// Use for migrating schema
  @override
  int get schemaVersion => 1;

  /// Insert new todo item into the Database
  Future<int> addTodo(Todo entry) {
    return into(todos).insert(entry.toCompanion(true));
  }

  /// Get list of todo items based on completion status
  /// Take in [isCompleted] as param, default to false
  Stream<List<Todo>> getTodosWithStatus({bool isCompleted = false}) =>
      (select(todos)..where((tbl) => tbl.isCompleted.equals(isCompleted)))
          .watch();

  /// Delete the todo item from Database
  Future<int> deleteTodo(Todo entry) {
    return delete(todos).delete(entry);
  }

  /// Update existing todo item
  /// Currently allow updating title, content and dueTime
  /// Use [TodosCompanion] to mark the absent field instead of setting its
  /// value to null
  Future<int> updateTodo(Todo todo) async {
    final result =
        await (update(todos)..where((tbl) => tbl.id.equals(todo.id))).write(
      TodosCompanion(
        title: Value(todo.title),
        content: Value(todo.content),
        dueTime: Value(todo.dueTime),
      ),
    );
    print(result);
    return result;
  }

  /// Update completion status of a todo item
  Future<int> updateCompletion(Todo todo) {
    return (update(todos)..where((tbl) => tbl.id.equals(todo.id))).write(
        TodosCompanion(
            isCompleted: Value.ofNullable(!(todo.isCompleted ?? false)),
            completedTime: Value(DateTime.now())));
  }

  /// Get all counts of completed todo items group by their completion time to
  /// represents the user's productivity.
  /// This method uses direct SQL query to get the data
  /// Returns a list of [TodoCount]
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

  /// Get all counts of all todo items group by their due time to represent
  /// volume of the user's tasks from the get-go.
  /// This method uses direct SQL query to get the data
  /// Returns a list of [TodoCount]
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

  /// Clear all data from the table
  Future<int> clear() => delete(todos).go();
}
