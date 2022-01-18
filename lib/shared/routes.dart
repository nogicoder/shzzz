import 'package:get/get.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/presentation/index.dart';

/// Holds the route names and list of [getPages] to navigate by routes names
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
        binding: BindingsBuilder.put(() => BaseScreenController())),
  ];
}

/// Display create todo dialog
/// Take in a [Todo] as input, if it's null then the dialog will create a new
/// todo item, otherwise it's an update of existing todo item
goCreateTodoDialog({Todo? todo}) =>
    Get.dialog(CreateTodoDialog(todo: todo), useSafeArea: false);
