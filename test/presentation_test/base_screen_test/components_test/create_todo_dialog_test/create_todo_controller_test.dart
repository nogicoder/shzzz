import 'package:drift/native.dart';
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

void main() {
  late MyDatabase database;
  late CreateTodoController createController;
  late CreateTodoController updateController;

  setUpAll(() async {
    database = MyDatabase(NativeDatabase.memory());
    await database.addTodo(_todo);

    Get.put<Repository>(Repository(database));
    createController = Get.put<CreateTodoController>(
      CreateTodoController(),
      tag: CREATE_TAG,
    );
    updateController = Get.put<CreateTodoController>(
      CreateTodoController(todo: _todo),
      tag: UPDATE_TAG,
    );
  });

  tearDownAll(() {
    database.close();
  });

  group('Testing CreateTodoController when creating todo', () {
    test('Expect controller to be initialized', () {
      expect(createController.initialized, true);
    });

    test('Expect variables to have correct initial values', () {
      expect(createController.hasNote.value, false);
      expect(createController.hasError.value, false);
      expect(
        createController.dueTime.value.formatDMY == DateTime.now().formatDMY,
        true,
      );
    });

    test(
        'Expect hasError is true when call validate() and text length is not satisfy',
        () {
      createController.textController.text = generateString(5);
      createController.validate();
      expect(createController.hasError.value, true);

      createController.textController.text = generateString(35);
      createController.validate();
      expect(createController.hasError.value, true);

      createController.textController.text = generateString(30);
      createController.noteController.text = generateString(101);
      createController.validate();
      expect(createController.hasError.value, true);
    });

    test(
        'Expect hasError is false when call validate() and text length is satisfy',
        () {
      createController.textController.text = generateString(6);
      createController.noteController.text = generateString(100);
      createController.validate();
      expect(createController.hasError.value, false);
    });

    test(
        'ERROR: Expect todo item with title length < 6 not create when call addTodo() ',
        () async {
      createController.textController.text = generateString(4);
      final _result = await createController.addTodo();
      expect(_result, 0);
    });

    test(
        'ERROR: Expect todo item with title length > 32 not create when call addTodo() ',
        () async {
      createController.textController.text = generateString(35);
      final _result = await createController.addTodo();
      expect(_result, 0);
    });

    test(
        'SUCCESS: Expect todo item with title length <= 6 and >= 32 create successfully when call addTodo() ',
        () async {
      createController.textController.text = generateString(30);
      createController.noteController.text = generateString(100);
      final _result = await createController.addTodo();
      expect(_result, 1);
    });
  });

  group('Testing CreateTodoController when updating todo', () {
    test('Expect controller to be initialized', () {
      expect(updateController.initialized, true);
    });

    test('Expect variables to have correct initial values', () {
      expect(updateController.hasNote.value, false);
      expect(updateController.hasError.value, false);
      expect(
        updateController.dueTime.value.formatDMY == DateTime.now().formatDMY,
        true,
      );
    });

    test(
        'Expect hasError is true when call validate() and text length is not satisfy',
        () {
      updateController.textController.text = generateString(5);
      updateController.validate();
      expect(updateController.hasError.value, true);

      updateController.textController.text = generateString(35);
      updateController.validate();
      expect(updateController.hasError.value, true);

      updateController.textController.text = generateString(30);
      updateController.noteController.text = generateString(101);
      updateController.validate();
      expect(updateController.hasError.value, true);
    });

    test(
        'Expect hasError is false when call validate() and text length is satisfy',
        () {
      updateController.textController.text = generateString(6);
      updateController.noteController.text = generateString(100);
      updateController.validate();
      expect(updateController.hasError.value, false);
    });

    test(
        'ERROR: Expect todo item with title length < 6 not updated when call addTodo() ',
        () async {
      updateController.textController.text = generateString(4);
      final _result = await updateController.addTodo();
      expect(_result, 0);
    });

    test(
        'ERROR: Expect todo item with title length > 32 not updated when call addTodo() ',
        () async {
      updateController.textController.text = generateString(35);
      final _result = await updateController.addTodo();
      expect(_result, 0);
    });

    test(
        'SUCCESS: Expect todo item with title length <= 6 and >= 32 updated successfully when call addTodo() ',
        () async {
      updateController.textController.text = generateString(30);
      updateController.noteController.text = generateString(100);
      final _result = await updateController.addTodo();
      expect(_result, 1);
    });
  });
}
