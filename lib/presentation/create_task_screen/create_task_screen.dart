import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/shared/constants.dart';
import 'package:shzzz/shared/index.dart';

class CreateTaskController extends GetxController {
  final FocusNode focusNode = FocusNode();
  final FocusNode noteFocusNode = FocusNode();
  final textController = TextEditingController();
  final noteController = TextEditingController();

  var hasError = false.obs;
  var hasErrorNote = false.obs;
  var hasNote = false.obs;

  @override
  void dispose() {
    textController.dispose();
    noteController.dispose();
    focusNode.dispose();
    noteFocusNode.dispose();
    super.dispose();
  }
}

class CreateTaskScreen extends GetView<CreateTaskController> {
  CreateTaskScreen({Key? key}) : super(key: key);

  late CreateTaskController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(CreateTaskController());
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
                  Padding(
                    padding: Constants.kHorizontalPaddingStandard,
                    child: Obx(
                      () => TextField(
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
                          errorText: controller.hasError.value
                              ? tr().min_length_error
                              : null,
                          errorStyle: UITextStyle.bodyStyle(color: Colors.red),
                          counterText: '',
                        ),
                        style: UITextStyle.headline4(),
                        maxLength: Constants.MAX_TITLE_LENGTH,
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.hasNote.value)
                      return Padding(
                        padding: Constants.kHorizontalPaddingStandard,
                        child: Obx(
                          () => TextField(
                            controller: controller.noteController,
                            focusNode: controller.noteFocusNode,
                            onChanged: (value) {
                              controller.hasErrorNote.value =
                                  value.trim().length <
                                      Constants.MIN_TITLE_LENGTH;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: tr().enter_note,
                              errorText: controller.hasErrorNote.value
                                  ? tr().min_length_error
                                  : null,
                              errorStyle:
                                  UITextStyle.bodyStyle(color: Colors.red),
                              counterText: '',
                            ),
                            style: UITextStyle.subtitle1(),
                            maxLength: Constants.MAX_NOTE_LENGTH,
                          ),
                        ),
                      );
                    return SizedBox();
                  }),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Get.theme.colorScheme.surface),
                        ),
                        margin: Constants.kPaddingStandard,
                        padding: Constants.kInnerPaddingStandard,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Get.theme.colorScheme.surface,
                            ),
                            SizedBox(width: Constants.kInnerPadding),
                            Text(tr().today),
                          ],
                        ),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            controller.hasNote.value =
                                !controller.hasNote.value;
                            if (!controller.hasNote.value)
                              controller.noteController.clear();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: controller.hasNote.value
                                      ? Get.theme.colorScheme.secondary
                                      : Get.theme.colorScheme.surface),
                            ),
                            margin:
                                Constants.kPaddingStandard.copyWith(left: 0),
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
                                Text(controller.hasNote.value
                                    ? tr().remove_note
                                    : tr().add_note),
                              ],
                            ),
                          ),
                        ),
                      )
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
                title: tr().create_task,
                onTap: () {},
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
}
