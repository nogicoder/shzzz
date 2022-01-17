import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/shared/index.dart';

class CreateTaskController extends GetxController {
  final Todo? todo;
  CreateTaskController({this.todo});

  final FocusNode focusNode = FocusNode();
  final FocusNode noteFocusNode = FocusNode();
  late final textController = TextEditingController(text: todo?.title);
  late final noteController = TextEditingController(text: todo?.content);
  late var hasNote = (todo?.content?.isNotEmpty ?? false).obs;
  late var dueTime = (todo?.dueTime ?? DateTime.now()).obs;

  var hasError = false.obs;

  void addTodo(Todo entry) {
    if (todo != null) {
      repository.updateTodo(entry);
    } else {
      repository.addTodo(entry);
    }
    Get.back();
    Get.snackbar(APP_TITLE,
        todo != null ? tr().success_updating_task : tr().success_adding_task);
  }

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

//ignore: must_be_immutable
class CreateTaskScreen extends GetView<CreateTaskController> {
  final Todo? todo;
  CreateTaskScreen({Key? key, this.todo}) : super(key: key);

  late CreateTaskController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(CreateTaskController(todo: todo));
    return Scaffold(
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
                onTap: () {
                  if (controller.validate()) {
                    final Todo item = Todo(
                      title: controller.textController.text,
                      content: controller.noteController.text,
                      createdTime: DateTime.now(),
                      dueTime: controller.dueTime.value,
                    );
                    controller.addTodo(item);
                  }
                },
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
