import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shzzz/data/index.dart';
import 'package:shzzz/shared/index.dart';

/// [StorageService] provides methods to access and write into [SharedPreferences]
class StorageService extends GetxService {
  final SharedPreferences prefs;

  StorageService(this.prefs);

  /// Describes if the user has read the onboarding pages or not (onboarded)
  bool? get isOnboarded => prefs.getBool(keyOnboarded);

  /// Set the onboarding status
  void setOnboarded() => prefs.setBool(keyOnboarded, true);

  /// Describes if the user provides his/her info or not
  String? get userInfoString => prefs.getString(keyUserInfo);

  /// Saves the info to SharedPreferences
  void saveUserInfo(UserInfo userInfo) =>
      prefs.setString(keyUserInfo, jsonEncode(userInfo));

  /// Describes user's prefer app language
  String getLang() => prefs.getString(keyLanguageCode) ?? DEFAULT_LOCALE;

  /// Set user's prefer app language
  updateLang(String lang) async => await prefs.setString(keyLanguageCode, lang);

  /// Describes user's prefer light/dark theme
  bool getIsLightTheme() => prefs.getBool(keyLight) ?? true;

  /// Set user's prefer theme
  void changeTheme(bool value) => prefs.setBool(keyLight, value);

  void clear() => prefs.clear();

  /// Set available [SharedPreferences] keys to be accessed later
  final keyOnboarded = 'keyOnboarded';
  final keyUserInfo = 'keyUserInfo';
  final keyLanguageCode = 'keyLanguageCode';
  final keyLight = 'keyLight';
}
