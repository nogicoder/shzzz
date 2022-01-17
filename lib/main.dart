import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBinding.inject();
  runApp(TaskApp());
}

class AppBinding {
  static inject() async {
    Get.put(Repository());
    await Get.putAsync(
        () async => StorageService(await SharedPreferences.getInstance()));
    Get.put(UserConfigService());
    Get.put(EventService());
  }
}
