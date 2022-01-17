import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'todo_table.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
  DateTimeColumn get createdTime => dateTime().nullable()();
  DateTimeColumn get dueTime => dateTime().nullable()();
}

@DataClassName("Category")
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Todos, Categories])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // loads all todo entries
  Stream<List<Todo>> getTodos() => select(todos).watch();

  Stream<List<Todo>> watchEntriesInCategory(Category c) {
    return (select(todos)..where((t) => t.category.equals(c.id))).watch();
  }

  Future<int> addTodo(TodosCompanion entry) {
    return into(todos).insert(entry);
  }

  Future<void> insertMultipleTodos(List<TodosCompanion> entries) async {
    await batch((batch) {
      batch.insertAll(todos, entries);
    });
  }

  Future moveTaskToCategory(Category target, TodosCompanion entry) {
    return update(todos).replace(entry);
  }

  Future deleteEntry(Todo entry) {
    return delete(todos).delete(entry);
  }
}
