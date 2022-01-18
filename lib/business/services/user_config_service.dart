import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/repository/repository.dart';

import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/data/model/user_info.dart';
import 'package:shzzz/main.dart';
import 'package:shzzz/shared/index.dart';

class UserConfigService extends GetxService {
  StorageService storage = Get.find();

  String get lang => storage.getLang();

  updateLocale() async {
    final _lang = lang == LOCALE_VI ? LOCALE_EN : LOCALE_VI;
    Get.updateLocale(Locale(_lang));
    await storage.updateLang(_lang);
  }

  bool get isLightTheme => storage.getIsLightTheme();

  setTheme() {
    Get.changeThemeMode(isLightTheme ? ThemeMode.dark : ThemeMode.light);
    storage.changeTheme(!isLightTheme);
  }

  UserInfo? get userInfo {
    final userInfoString = storage.userInfoString;
    if (userInfoString != null) {
      return UserInfo.fromJson(jsonDecode(userInfoString));
    }
    return null;
  }

  void setUserInfo(UserInfo? newInfo) async {
    if (newInfo != null) {
      storage.saveUserInfo(newInfo);
    }
  }

  bool get isOnboarded => storage.isOnboarded ?? false;

  setOnboarded() => storage.setOnboarded();

  logOut() {
    DialogUtil.confirm(Text(tr().logout), onSubmit: () async {
      storage.clear();
      Get.changeThemeMode(ThemeMode.light);
      await repository.clearDatabase();
      Get.offAllNamed(Routes.ONBOARDING_SCREEN);
    });
  }
}

final userConfigService = Get.find<UserConfigService>();
