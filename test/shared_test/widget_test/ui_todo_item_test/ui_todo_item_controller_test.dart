import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get/get.dart';

import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/data/index.dart';
import 'package:shzzz/presentation/base_screen/components/create_todo_dialog/create_todo_controller.dart';
import 'package:shzzz/shared/index.dart';
import 'package:shzzz/presentation/base_screen/base_screen_controller.dart';
import 'package:shzzz/shared/widget/ui_todo_item/ui_todo_item_controller.dart';

final _todo = Todo(
  id: 0,
  title: 'Testing',
  dueTime: DateTime.now(),
  completedTime: DateTime.now(),
);

class MockRepository extends GetxService with Fake implements Repository {
  @override
  Future<int> updateCompletion(Todo entry) => Future.value(1);

  @override
  Future<int> deleteTodo(Todo entry) => Future.value(1);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final binding = BindingsBuilder(() {
    Get.put<Repository>(MockRepository());
    Get.put<UITodoItemController>(
      UITodoItemController(),
    );
  });

  group('Testing UITodoItemController when updating todo', () {
    binding.builder();
    final UITodoItemController controller = Get.find();

    test('Expect controller to be initialized', () {
      expect(controller.initialized, true);
    });

    test('Expect status to be updated successfully', () async {
      final _result = await controller.updateStatus(_todo);
      expect(_result, 1);
    });

    test('Expect item to be deleted successfully', () async {
      final _result = await controller.deleteTodo(_todo);
      expect(_result, 1);
    });
  });
}
