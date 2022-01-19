import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBinding.inject();
  runApp(TaskApp());
}

/// Inject services on app start.
/// [Repository] is for connecting the app's Presentation with Local Database
/// [StorageService] provides method to interact with `SharedPreferences`
/// [UserConfigService] holds the infos of app's theme, languageCode, etc
/// [EventService] provides a background layer a screen can use to notify
/// other screens.
class AppBinding {
  static inject() async {
    Get.put(Repository(MyDatabase(openConnection())));
    await Get.putAsync(
        () async => StorageService(await SharedPreferences.getInstance()));
    Get.put(UserConfigService());
    Get.put(EventService());
  }
}
