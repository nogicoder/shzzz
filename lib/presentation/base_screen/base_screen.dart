import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shzzz/presentation/base_screen/components/index.dart';
import 'package:shzzz/presentation/base_screen/base_screen_controller.dart';

/// [BaseScreen] consists of 2 layers: [DrawerLayer] and [HomeLayer]
/// Each layer is displayed with animation when pressing the button on top of
/// page using an [AnimationController]
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
