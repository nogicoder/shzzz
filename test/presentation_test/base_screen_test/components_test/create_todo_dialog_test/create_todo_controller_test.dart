import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get/get.dart';

import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/presentation/base_screen/components/create_todo_dialog/create_todo_controller.dart';
import 'package:shzzz/shared/index.dart';

const CREATE_TAG = 'create';
const UPDATE_TAG = 'update';

final _todo = Todo(
  id: 0,
  title: 'Testing',
  dueTime: DateTime.now(),
);

class MockRepository extends GetxService with Fake implements Repository {
  @override
  Future<int> addTodo(Todo entry) => Future.value(1);

  @override
  Future<int> updateTodo(Todo entry) => Future.value(2);
}

void main() {
  final binding = BindingsBuilder(() {
    Get.put<Repository>(MockRepository());
    Get.put<CreateTodoController>(
      CreateTodoController(),
      tag: CREATE_TAG,
    );
    Get.put<CreateTodoController>(
      CreateTodoController(todo: _todo),
      tag: UPDATE_TAG,
    );
  });

  group('Testing CreateTodoController when creating todo', () {
    binding.builder();
    final CreateTodoController controller = Get.find(tag: CREATE_TAG);

    test('Expect controller to be initialized', () {
      expect(controller.initialized, true);
    });

    test('Expect variables to have correct initial values', () {
      expect(controller.hasNote.value, false);
      expect(controller.hasError.value, false);
      expect(
        controller.dueTime.value.formatDMY == DateTime.now().formatDMY,
        true,
      );
    });

    test(
        'Expect hasError is true when call validate() and text length is not satisfy',
        () {
      controller.textController.text = generateString(5);
      controller.validate();
      expect(controller.hasError.value, true);

      controller.textController.text = generateString(35);
      controller.validate();
      expect(controller.hasError.value, true);

      controller.textController.text = generateString(30);
      controller.noteController.text = generateString(101);
      controller.validate();
      expect(controller.hasError.value, true);
    });

    test(
        'Expect hasError is false when call validate() and text length is satisfy',
        () {
      controller.textController.text = generateString(6);
      controller.noteController.text = generateString(100);
      controller.validate();
      expect(controller.hasError.value, false);
    });

    test(
        'ERROR: Expect todo item with title length < 6 not create when call addTodo() ',
        () async {
      controller.textController.text = generateString(4);
      final _result = await controller.addTodo();
      expect(_result, 0);
    });

    test(
        'ERROR: Expect todo item with title length > 32 not create when call addTodo() ',
        () async {
      controller.textController.text = generateString(35);
      final _result = await controller.addTodo();
      expect(_result, 0);
    });

    test(
        'SUCCESS: Expect todo item with title length <= 6 and >= 32 create successfully when call addTodo() ',
        () async {
      controller.textController.text = generateString(30);
      controller.noteController.text = generateString(100);
      final _result = await controller.addTodo();
      expect(_result, 1);
    });
  });

  group('Testing CreateTodoController when updating todo', () {
    binding.builder();
    final CreateTodoController controller = Get.find(tag: UPDATE_TAG);

    test('Expect controller to be initialized', () {
      expect(controller.initialized, true);
    });

    test('Expect variables to have correct initial values', () {
      expect(controller.hasNote.value, false);
      expect(controller.hasError.value, false);
      expect(
        controller.dueTime.value.formatDMY == DateTime.now().formatDMY,
        true,
      );
    });

    test(
        'Expect hasError is true when call validate() and text length is not satisfy',
        () {
      controller.textController.text = generateString(5);
      controller.validate();
      expect(controller.hasError.value, true);

      controller.textController.text = generateString(35);
      controller.validate();
      expect(controller.hasError.value, true);

      controller.textController.text = generateString(30);
      controller.noteController.text = generateString(101);
      controller.validate();
      expect(controller.hasError.value, true);
    });

    test(
        'Expect hasError is false when call validate() and text length is satisfy',
        () {
      controller.textController.text = generateString(6);
      controller.noteController.text = generateString(100);
      controller.validate();
      expect(controller.hasError.value, false);
    });

    test(
        'ERROR: Expect todo item with title length < 6 not updated when call addTodo() ',
        () async {
      controller.textController.text = generateString(4);
      final _result = await controller.addTodo();
      expect(_result, 0);
    });

    test(
        'ERROR: Expect todo item with title length > 32 not updated when call addTodo() ',
        () async {
      controller.textController.text = generateString(35);
      final _result = await controller.addTodo();
      expect(_result, 0);
    });

    test(
        'SUCCESS: Expect todo item with title length <= 6 and >= 32 updated successfully when call addTodo() ',
        () async {
      controller.textController.text = generateString(30);
      controller.noteController.text = generateString(100);
      final _result = await controller.addTodo();
      expect(_result, 2);
    });
  });
}
