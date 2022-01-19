import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/data/index.dart';

class BaseScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 250));

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  var completedTodos = <Todo>[].obs;
  var ongoingTodos = <Todo>[].obs;
  var completedCounts = <TodoCount>[].obs;
  var todoCounts = <TodoCount>[].obs;

  @override
  void onInit() {
    repository.getTodosWithStatus().listen((event) {
      ongoingTodos.value = event;
    });
    repository.getTodosWithStatus(isCompleted: true).listen((event) {
      completedTodos.value = event;
    });
    repository.getCompletedCountByCompletionTime().listen((event) {
      completedCounts.value = event;
    });
    repository.getCountByDueTime().listen((event) {
      todoCounts.value = event;
    });

    super.onInit();
  }
}
