import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shzzz/presentation/base_screen/base_screen_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final binding = BindingsBuilder(() {
    // Get.put<Repository>(MockRepository());
    Get.put<BaseScreenController>(BaseScreenController());
  });
}
