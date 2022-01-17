import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shzzz/data/index.dart';
import 'package:shzzz/shared/index.dart';

class StorageService extends GetxService {
  final SharedPreferences prefs;

  StorageService(this.prefs);

  void setOnboarded() => prefs.setBool(keyOnboarded, true);

  bool? get isOnboarded => prefs.getBool(keyOnboarded);

  String? get userInfoString => prefs.getString(keyUserInfo);

  void saveUserInfo(UserInfo userInfo) =>
      prefs.setString(keyUserInfo, jsonEncode(userInfo));

  String getLang() => prefs.getString(keyLanguageCode) ?? DEFAULT_LOCALE;

  void updateLang(String lang) => prefs.setString(keyLanguageCode, lang);

  bool? getIsLightTheme() => prefs.getBool(keyLight);

  void changeTheme(bool value) => prefs.setBool(keyLight, value);

  void clear() => prefs.clear();

  final keyOnboarded = 'keyOnboarded';
  final keyUserInfo = 'keyUserInfo';
  final keyLanguageCode = 'keyLanguageCode';
  final keyLight = 'keyLight';
}
