import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/shared/index.dart';

/// Holds logics for [CreateTodoDialog]
class CreateTodoController extends GetxController {
  final Todo? todo;
  CreateTodoController({this.todo});

  final FocusNode focusNode = FocusNode();
  final FocusNode noteFocusNode = FocusNode();
  late final textController = TextEditingController(text: todo?.title);
  late final noteController = TextEditingController(text: todo?.content);
  late var hasNote = (todo?.content?.isNotEmpty ?? false).obs;
  late var dueTime = (todo?.dueTime ?? DateTime.now()).obs;

  var hasError = false.obs;

  /// Check the validation of user input using [validate]
  ///
  /// If validated, then a [Todo] object is created with the inputted info.
  /// This object will then be stored in Local Database
  ///
  /// If a [Todo] is passed as param, this item will be updated in the Local
  /// Database.
  ///
  /// The user will then be notified by a [Snackbar]
  void addTodo() {
    if (!validate()) {
      return;
    }
    final Todo entry = Todo(
      title: textController.text,
      content: noteController.text,
      createdTime: DateTime.now(),
      dueTime: dueTime.value,
    );
    if (todo != null) {
      repository.updateTodo(entry);
    } else {
      repository.addTodo(entry);
    }
    Get.back();
    Get.snackbar(APP_TITLE,
        todo != null ? tr().success_updating_task : tr().success_adding_task);
  }

  /// Validate the user input based on 3 conditions:
  /// - The title's length must be in between [Constants.MIN_TITLE_LENGTH]
  /// and [Constants.MAX_TITLE_LENGTH] characters
  /// - The note's length must be less than [Constants.MAX_NOTE_LENGTH]
  /// Else the user will receive an error alert
  bool validate() {
    if (textController.text.length >= Constants.MIN_TITLE_LENGTH &&
        textController.text.length <= Constants.MAX_TITLE_LENGTH &&
        noteController.text.length <= Constants.MAX_NOTE_LENGTH) {
      return true;
    }
    DialogUtil.alert(tr().please_check_input);
    return false;
  }

  @override
  void dispose() {
    textController.dispose();
    noteController.dispose();
    focusNode.dispose();
    noteFocusNode.dispose();
    super.dispose();
  }
}