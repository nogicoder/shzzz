import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shzzz/business/services/user_config_service.dart';
import 'package:shzzz/generated/l10n.dart';
import 'package:shzzz/shared/index.dart';

class TaskApp extends GetView<UserConfigService> {
  const TaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => GetMaterialApp(
        title: APP_TITLE,
        locale: Locale(controller.lang),
        themeMode: controller.isLightTheme ? ThemeMode.light : ThemeMode.dark,
        theme: UITheme.getLightTheme(),
        darkTheme: UITheme.getDarkTheme(),
        getPages: Routes.getPages,
        initialRoute: '/',
        supportedLocales: List<Locale>.from(
            SUPPORTED_LOCALES.map((langCode) => Locale(langCode))),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
      ),
    );
  }
}
