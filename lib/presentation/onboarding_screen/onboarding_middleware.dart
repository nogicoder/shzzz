import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/presentation/index.dart';
import 'package:shzzz/shared/index.dart';

/// [OnboardingMiddleware] handles redirections based on user's configs
class OnboardingMiddleware extends GetMiddleware {
  /// Three cases to consider:
  /// - User is not onboarded -> navigate to [OnboardingScreen]
  /// - User is onboarded without info -> navigate to [RegisterScreen]
  /// - User is onboarded with info -> navigate to [BaseScreen]
  @override
  RouteSettings? redirect(String? route) {
    if (userConfigService.isOnboarded) {
      if (userConfigService.userInfo != null) {
        return RouteSettings(name: Routes.BASE_SCREEN);
      }
      return RouteSettings(name: Routes.REGISTER_SCREEN);
    }
  }
}
