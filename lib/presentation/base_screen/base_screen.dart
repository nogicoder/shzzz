import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/data/index.dart';
import 'package:shzzz/presentation/base_screen/components/index.dart';

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
  var ongoingCounts = <TodoCount>[].obs;

  @override
  void onInit() {
    repository.getTodosWithStatus().listen((event) {
      ongoingTodos.value = event;
    });
    repository.getTodosWithStatus(isCompleted: true).listen((event) {
      completedTodos.value = event;
    });
    repository.getCompletedCountByDate().listen((event) {
      completedCounts.value = event;
    });
    repository.getCountByDueDate().listen((event) {
      ongoingCounts.value = event;
    });

    super.onInit();
  }
}

class BaseScreen extends GetView<BaseScreenController> {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: Get.theme.backgroundColor,
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, _) {
            double slide =
                Get.width * 0.8 * controller.animationController.value;
            double scale = 1 - (controller.animationController.value * 0.15);
            return Stack(
              children: [
                DrawerLayer(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: HomeLayer(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
