import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/shared/index.dart';

class OnboardingMiddleware extends GetMiddleware {
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
