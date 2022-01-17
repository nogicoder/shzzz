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

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get onboarding_1_title {
    return Intl.message(
      '',
      name: 'onboarding_1_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get onboarding_2_title {
    return Intl.message(
      '',
      name: 'onboarding_2_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get onboarding_3_title {
    return Intl.message(
      '',
      name: 'onboarding_3_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get onboarding_1_desc {
    return Intl.message(
      '',
      name: 'onboarding_1_desc',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get onboarding_2_desc {
    return Intl.message(
      '',
      name: 'onboarding_2_desc',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get onboarding_3_desc {
    return Intl.message(
      '',
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
