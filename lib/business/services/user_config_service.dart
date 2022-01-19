import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/data/model/user_info.dart';
import 'package:shzzz/generated/l10n.dart';
import 'package:shzzz/presentation/index.dart';
import 'package:shzzz/shared/index.dart';

/// [UserConfigService] holds the configs user can later change such as locale,
/// theme, user info, etc
class UserConfigService extends GetxService {
  StorageService storage = Get.find();

  String get lang => storage.getLang();

  /// Change locale using Getx, then update the value in [SharedPreferences]
  updateLocale() async {
    final _newLang = lang == LOCALE_VI ? LOCALE_EN : LOCALE_VI;
    await storage.updateLang(_newLang);
    S.load(Locale(_newLang));
    await Get.updateLocale(Locale(_newLang));
  }

  bool get isLightTheme => storage.getIsLightTheme();

  /// Set theme using Getx, then save the value to [SharedPreferences]
  setTheme() {
    Get.changeThemeMode(isLightTheme ? ThemeMode.dark : ThemeMode.light);
    storage.changeTheme(!isLightTheme);
  }

  /// Parse the user info from [SharedPreferences]
  UserInfo? get userInfo {
    final userInfoString = storage.userInfoString;
    if (userInfoString != null) {
      return UserInfo.fromJson(jsonDecode(userInfoString));
    }
    return null;
  }

  /// Save the user info to [SharedPreferences]
  void setUserInfo(UserInfo? newInfo) async {
    if (newInfo != null) {
      storage.saveUserInfo(newInfo);
    }
  }

  bool get isOnboarded => storage.isOnboarded ?? false;

  /// Save the onboarded value to [SharedPreferences]
  setOnboarded() => storage.setOnboarded();

  /// Log the user out of the app, this will clear the [SharedPreferences] and
  /// [MyDatabase]'s data, set the theme back to [ThemeMode.light] and navigate
  /// back to the [OnboardingScreen]
  logOut() {
    DialogUtil.confirm(Text(tr().logout_confirm), onSubmit: () async {
      storage.clear();
      Get.changeThemeMode(ThemeMode.light);
      await repository.clearDatabase();
      Get.offAllNamed(Routes.ONBOARDING_SCREEN);
    });
  }
}

/// Single access point for [UserConfigService]
final userConfigService = Get.find<UserConfigService>();
