import 'package:get/get.dart';

import 'package:shzzz/shared/index.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/business/repository/repository.dart';

/// Holds the logic for [UITodoItem]. Provides 2 methods:
/// - [updateStatus]: Update completion status of the item
/// - [deleteTodo]: Delete the todo item from Local Database, then displays a
/// Snackbar notifying the user
class UITodoItemController extends GetxController {
  Future<int> updateStatus(Todo todo) => repository.updateCompletion(todo);

  Future<int> deleteTodo(Todo todo) => repository.deleteTodo(todo);
}
