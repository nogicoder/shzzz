import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/data/model/user_info.dart';
import 'package:shzzz/main.dart';
import 'package:shzzz/shared/index.dart';

class UserConfigService extends GetxService {
  StorageService storage = Get.find();

  String get lang => storage.getLang();

  setLang(String lang) {
    Get.updateLocale(Locale(lang));
    storage.updateLang(lang);
  }

  bool get isLightTheme => storage.getIsLightTheme() ?? false;

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

  logOut() async {
    storage.clear();
    await AppBinding.inject();
    Get.offAllNamed(Routes.ONBOARDING_SCREEN);
  }
}

final userConfigService = Get.find<UserConfigService>();
