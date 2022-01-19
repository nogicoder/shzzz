import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/presentation/base_screen/base_screen_controller.dart';
import 'package:shzzz/shared/index.dart';

final _incompleteTodo = Todo(
  id: 0,
  title: 'Testing',
  dueTime: DateTime.now(),
);

final _completedTodo = Todo(
  id: 1,
  title: 'Testing',
  dueTime: DateTime.now(),
  isCompleted: true,
  completedTime: DateTime.now(),
);

void main() async {
  late MyDatabase database;
  late BaseScreenController controller;

  setUpAll(() async {
    database = MyDatabase(NativeDatabase.memory());
    await database.addTodo(_incompleteTodo);
    await database.addTodo(_completedTodo);

    Get.put<Repository>(Repository(database));

    controller = Get.put(BaseScreenController());
  });

  tearDownAll(() {
    database.close();
  });

  group('Testing initialization of BaseScreenController', () {
    test('Expect controller status to be initialized', () {
      expect(controller.initialized, true);
    });

    test('Expect completedTodos contains a single item', () {
      expect(controller.completedTodos.isNotEmpty, true);
      expect(controller.completedTodos.first.equals(_completedTodo), true);
    });

    test('Expect ongoingTodos contains a single item', () {
      expect(controller.ongoingTodos.isNotEmpty, true);
      expect(controller.ongoingTodos.first.equals(_incompleteTodo), true);
    });

    test('Expect completedCounts return a single item', () {
      expect(controller.completedCounts.isNotEmpty, true);
      expect(controller.completedCounts.first.count == 1, true);
    });

    test('Expect todoCounts return 2 items', () {
      expect(controller.todoCounts.isNotEmpty, true);
      expect(controller.todoCounts.first.count == 2, true);
    });
  });
}
