import 'package:get/get.dart';
import 'package:shzzz/presentation/index.dart';

class Routes {
  static const ONBOARDING_SCREEN = '/';
  static const REGISTER_SCREEN = '/REGISTER_SCREEN';
  static const BASE_SCREEN = '/BASE_SCREEN';

  static List<GetPage> getPages = [
    GetPage(
      name: Routes.ONBOARDING_SCREEN,
      page: () => OnboardingScreen(),
      middlewares: [OnboardingMiddleware()],
    ),
    GetPage(
      name: Routes.REGISTER_SCREEN,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: Routes.BASE_SCREEN,
      page: () => BaseScreen(),
    ),
  ];
}

goCreateTaskScreen() => Get.dialog(CreateTaskScreen(), useSafeArea: false);
