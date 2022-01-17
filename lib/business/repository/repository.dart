import 'package:get/get.dart';
import 'package:shzzz/data/database/todo_table.dart';

class Repository extends GetxService {
  final MyDatabase _database = MyDatabase();
  MyDatabase get database => _database;

  Stream<List<Todo>> getTodos() => _database.getTodos();

  Future<int> addTodo(Todo entry) => _database.addTodo(entry.toCompanion(true));
}

final Repository repository = Get.find();
