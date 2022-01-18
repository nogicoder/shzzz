import 'package:get/get.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/data/index.dart';

class Repository extends GetxService {
  final MyDatabase _database = MyDatabase();
  MyDatabase get database => _database;

  Stream<List<Todo>> getTodosWithStatus({bool isCompleted = false}) =>
      _database.getTodosWithStatus(isCompleted: isCompleted);

  Future<int> addTodo(Todo entry) => _database.addTodo(entry.toCompanion(true));

  Future<int> updateTodo(Todo entry) => _database.updateTodo(entry);

  Future<int> updateCompletion(Todo entry) => _database.updateCompletion(entry);

  Future deleteTodo(Todo entry) => _database.deleteEntry(entry);

  Stream<List<TodoCount>> getCompletedCountByDate() =>
      _database.getCompletedCountByDate();

  Stream<List<TodoCount>> getCountByDueDate() => _database.getCountByDueDate();

  clearDatabase() => _database.clear();
}

final Repository repository = Get.find();
