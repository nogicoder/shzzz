import 'package:get/get.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/data/index.dart';

/// [Repository] provides methods the presentation needs to do CRUD with Local
/// Database.
/// [MyDatabase] represents the SQLite database object that only has a getter.
class Repository extends GetxService {
  final MyDatabase _database;
  Repository(this._database);

  /// Get all todos based on completion status
  Stream<List<Todo>> getTodosWithStatus({bool isCompleted = false}) =>
      _database.getTodosWithStatus(isCompleted: isCompleted);

  Future<int> addTodo(Todo entry) => _database.addTodo(entry);

  Future<int> updateTodo(Todo entry) => _database.updateTodo(entry);

  /// Update only the completion status of each todo
  Future<int> updateCompletion(Todo entry) => _database.updateCompletion(entry);

  Future<int> deleteTodo(Todo entry) => _database.deleteTodo(entry);

  /// Get all completed todos by their completion time
  Stream<List<TodoCount>> getCompletedCountByCompletionTime() =>
      _database.getCompletedCountByCompletionTime();

  /// Get all todos by their due time
  Stream<List<TodoCount>> getCountByDueTime() => _database.getCountByDueTime();

  /// Clear all the table's data
  clearDatabase() => _database.clear();
}

/// Single access point for Repository
final Repository repository = Get.find();
