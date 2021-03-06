// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `What's up`
  String get hello {
    return Intl.message(
      'What\'s up',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Minimalism is key`
  String get onboarding_1_title {
    return Intl.message(
      'Minimalism is key',
      name: 'onboarding_1_title',
      desc: '',
      args: [],
    );
  }

  /// `Built-in tools to match your need`
  String get onboarding_2_title {
    return Intl.message(
      'Built-in tools to match your need',
      name: 'onboarding_2_title',
      desc: '',
      args: [],
    );
  }

  /// `Smart statistics for keeping track`
  String get onboarding_3_title {
    return Intl.message(
      'Smart statistics for keeping track',
      name: 'onboarding_3_title',
      desc: '',
      args: [],
    );
  }

  /// `Waste zero time getting your shzzz done`
  String get onboarding_1_desc {
    return Intl.message(
      'Waste zero time getting your shzzz done',
      name: 'onboarding_1_desc',
      desc: '',
      args: [],
    );
  }

  /// `All your productivity managed in Shzzz`
  String get onboarding_2_desc {
    return Intl.message(
      'All your productivity managed in Shzzz',
      name: 'onboarding_2_desc',
      desc: '',
      args: [],
    );
  }

  /// `Helps you find the balance you've long needed`
  String get onboarding_3_desc {
    return Intl.message(
      'Helps you find the balance you\'ve long needed',
      name: 'onboarding_3_desc',
      desc: '',
      args: [],
    );
  }

  /// `Start now`
  String get start_now {
    return Intl.message(
      'Start now',
      name: 'start_now',
      desc: '',
      args: [],
    );
  }

  /// `How can I call you?`
  String get how_to_call {
    return Intl.message(
      'How can I call you?',
      name: 'how_to_call',
      desc: '',
      args: [],
    );
  }

  /// `Let's go`
  String get lets_go {
    return Intl.message(
      'Let\'s go',
      name: 'lets_go',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Enter new task`
  String get enter_task {
    return Intl.message(
      'Enter new task',
      name: 'enter_task',
      desc: '',
      args: [],
    );
  }

  /// `Create task`
  String get create_task {
    return Intl.message(
      'Create task',
      name: 'create_task',
      desc: '',
      args: [],
    );
  }

  /// `Minimum title lenght must be 6`
  String get min_length_error {
    return Intl.message(
      'Minimum title lenght must be 6',
      name: 'min_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Add note`
  String get add_note {
    return Intl.message(
      'Add note',
      name: 'add_note',
      desc: '',
      args: [],
    );
  }

  /// `Enter note`
  String get enter_note {
    return Intl.message(
      'Enter note',
      name: 'enter_note',
      desc: '',
      args: [],
    );
  }

  /// `Remove note`
  String get remove_note {
    return Intl.message(
      'Remove note',
      name: 'remove_note',
      desc: '',
      args: [],
    );
  }

  /// `Please check your input again!`
  String get please_check_input {
    return Intl.message(
      'Please check your input again!',
      name: 'please_check_input',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get ok {
    return Intl.message(
      'Okay',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Feature is in development`
  String get developing_feature {
    return Intl.message(
      'Feature is in development',
      name: 'developing_feature',
      desc: '',
      args: [],
    );
  }

  /// `Add task successfully`
  String get success_adding_task {
    return Intl.message(
      'Add task successfully',
      name: 'success_adding_task',
      desc: '',
      args: [],
    );
  }

  /// `Update task successfully`
  String get success_updating_task {
    return Intl.message(
      'Update task successfully',
      name: 'success_updating_task',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Delete task successfully`
  String get success_deleting_task {
    return Intl.message(
      'Delete task successfully',
      name: 'success_deleting_task',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing`
  String get ongoing {
    return Intl.message(
      'Ongoing',
      name: 'ongoing',
      desc: '',
      args: [],
    );
  }

  /// `Change theme`
  String get change_theme {
    return Intl.message(
      'Change theme',
      name: 'change_theme',
      desc: '',
      args: [],
    );
  }

  /// `Contact support`
  String get contact_support {
    return Intl.message(
      'Contact support',
      name: 'contact_support',
      desc: '',
      args: [],
    );
  }

  /// `Field cannot be empty`
  String get empty_error {
    return Intl.message(
      'Field cannot be empty',
      name: 'empty_error',
      desc: '',
      args: [],
    );
  }

  /// `Woohoo! You are the shzzz!`
  String get empty_todos {
    return Intl.message(
      'Woohoo! You are the shzzz!',
      name: 'empty_todos',
      desc: '',
      args: [],
    );
  }

  /// `No shzzz in here.`
  String get no_task_inside {
    return Intl.message(
      'No shzzz in here.',
      name: 'no_task_inside',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `You sure want to logout?`
  String get logout_confirm {
    return Intl.message(
      'You sure want to logout?',
      name: 'logout_confirm',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
