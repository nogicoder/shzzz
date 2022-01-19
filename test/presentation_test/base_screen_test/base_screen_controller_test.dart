import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get/get.dart';

import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/data/index.dart';
import 'package:shzzz/shared/index.dart';
import 'package:shzzz/presentation/base_screen/base_screen_controller.dart';

final _todo = Todo(
  id: 0,
  title: 'Testing',
  dueTime: DateTime.now(),
);

final _todoCount = TodoCount(
  count: 1,
  dateTime: DateTime.now(),
);

class MockRepository extends GetxService with Fake implements Repository {
  @override
  Stream<List<Todo>> getTodosWithStatus({bool isCompleted = false}) =>
      isCompleted ? Stream.value([_todo]) : Stream.value([]);

  @override
  Stream<List<TodoCount>> getCompletedCountByCompletionTime() =>
      Stream.value([_todoCount]);

  @override
  Stream<List<TodoCount>> getCountByDueTime() => Stream.value([]);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final binding = BindingsBuilder(() {
    Get.put<Repository>(MockRepository());
    Get.put<BaseScreenController>(BaseScreenController());
  });

  group('Testing initialization of BaseScreenController', () {
    binding.builder();
    final BaseScreenController controller = Get.find();

    test('Expect controller status to be initialized', () {
      expect(controller.initialized, true);
    });

    test('Expect completedTodos contains a single item', () {
      expect(controller.completedTodos.isNotEmpty, true);
      expect(controller.completedTodos.first.equals(_todo), true);
    });

    test('Expect ongoingTodos is empty', () {
      expect(controller.ongoingTodos.isEmpty, true);
    });

    test('Expect completedCounts contains a single item', () {
      expect(controller.completedCounts.isNotEmpty, true);
      expect(controller.completedCounts.first == _todoCount, true);
    });

    test('Expect ongoingCounts is empty', () {
      expect(controller.ongoingCounts.isEmpty, true);
    });
  });
}
