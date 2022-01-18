import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';

import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/shared/index.dart';
import 'package:shzzz/presentation/base_screen/components/create_todo_dialog/create_todo_controller.dart';

/// Display the dialog to create new todo item, includes:
/// - A [TextField] ask for the todo item's title
/// - A [DateTimePicker] to ask for the todo item's due date
/// - A button allows user to add note for the todo item
//ignore: must_be_immutable
class CreateTodoDialog extends GetView<CreateTodoController> {
  final Todo? todo;
  CreateTodoDialog({Key? key, this.todo}) : super(key: key);

  late CreateTodoController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(CreateTodoController(todo: todo));
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: InkWell(
        onTap: () {
          controller.focusNode.unfocus();
          controller.noteFocusNode.unfocus();
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitleField(),
                  _buildNoteField(),
                  Row(
                    children: [
                      _buildDateSelection(),
                      _buildAddNote(),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 100,
              right: 100,
              child: UIButton(
                title: todo != null ? tr().update : tr().create_task,
                onTap: controller.addTodo,
                buttonColor: Get.theme.colorScheme.secondary,
              ),
            ),
            Positioned(
              top: 100,
              left: Constants.kSmallPadding,
              child: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.close,
                  color: Get.theme.colorScheme.surface,
                  size: 60,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Padding(
      padding: Constants.kHorizontalPaddingStandard,
      child: Obx(
        () => TextField(
          autofocus: true,
          controller: controller.textController,
          focusNode: controller.focusNode,
          onChanged: (value) {
            controller.hasError.value =
                value.trim().length < Constants.MIN_TITLE_LENGTH;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: tr().enter_task,
            errorText: controller.hasError.value ? tr().min_length_error : null,
            errorStyle: UITextStyle.bodyStyle(color: Colors.red),
            counterText: '',
          ),
          style: UITextStyle.headline4(),
          maxLength: Constants.MAX_TITLE_LENGTH,
        ),
      ),
    );
  }

  /// The Note field will only display if the [controller.hasNote] state is
  /// set to true.
  Widget _buildNoteField() {
    return Obx(() {
      if (controller.hasNote.value) {
        return Padding(
          padding: Constants.kHorizontalPaddingStandard,
          child: TextField(
            controller: controller.noteController,
            focusNode: controller.noteFocusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: tr().enter_note,
              counterText: '',
            ),
            style: UITextStyle.subtitle1(),
            maxLength: Constants.MAX_NOTE_LENGTH,
          ),
        );
      }

      return SizedBox();
    });
  }

  Widget _buildDateSelection() {
    return InkWell(
      onTap: () {
        DatePicker.showDateTimePicker(
          Get.context!,
          minTime: DateTime.now(),
          onConfirm: (date) => controller.dueTime.value = date,
          currentTime: DateTime.now(),
          locale: LocaleType.vi,
        );
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Get.theme.colorScheme.secondary,
            ),
          ),
          margin: Constants.kPaddingStandard,
          padding: Constants.kInnerPaddingStandard,
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: Get.theme.colorScheme.secondary,
              ),
              SizedBox(width: Constants.kInnerPadding),
              Text(
                controller.dueTime.value.formatDMY,
                style: UITextStyle.bodyStyle(
                  color: Get.theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddNote() {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.hasNote.value = !controller.hasNote.value;
          if (!controller.hasNote.value) controller.noteController.clear();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: controller.hasNote.value
                    ? Get.theme.colorScheme.secondary
                    : Get.theme.colorScheme.surface),
          ),
          margin: Constants.kPaddingStandard.copyWith(left: 0),
          padding: Constants.kInnerPaddingStandard,
          child: Row(
            children: [
              Icon(
                Icons.notes,
                color: controller.hasNote.value
                    ? Get.theme.colorScheme.secondary
                    : Get.theme.colorScheme.surface,
              ),
              SizedBox(width: Constants.kInnerPadding),
              Text(
                controller.hasNote.value ? tr().remove_note : tr().add_note,
                style: UITextStyle.bodyStyle(
                  color: controller.hasNote.value
                      ? Get.theme.colorScheme.secondary
                      : Get.theme.colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
