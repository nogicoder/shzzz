import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shzzz/shared/index.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/presentation/base_screen/components/index.dart';

class HomeLayerController extends GetxController {
  var completedTodos = <Todo>[].obs;
  var ongoingTodos = <Todo>[].obs;

  @override
  void onInit() {
    repository.getTodosWithStatus().listen((event) {
      ongoingTodos.value = event;
    });
    repository.getTodosWithStatus(isCompleted: true).listen((event) {
      completedTodos.value = event;
    });
    super.onInit();
  }
}

class HomeLayer extends StatelessWidget {
  HomeLayer({Key? key}) : super(key: key);

  late HomeLayerController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(HomeLayerController());
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Get.theme.colorScheme.secondary,
          inactiveColor: Get.theme.colorScheme.surface,
          iconSize: 24,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: tr().home,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.check_mark_circled),
              label: tr().ongoing,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clear_circled),
              label: tr().completed,
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return UITabLayout(
                  child: HomeTab(
                ongoingTodos: controller.ongoingTodos,
                completedTodos: controller.completedTodos,
              ));
            case 1:
              return UITabLayout(
                  child: _buildItemList(controller.ongoingTodos));
            case 2:
            default:
              return UITabLayout(
                  child: _buildItemList(controller.completedTodos));
          }
        },
      ),
    );
  }

  Widget _buildItemList(List<Todo> todos) {
    return Material(
      child: Padding(
        padding: Constants.kHorizontalPaddingStandard,
        child: Column(
          children: List<Widget>.generate(
            todos.length,
            (index) => Padding(
              padding: index != todos.length
                  ? EdgeInsets.only(bottom: Constants.kSmallPadding)
                  : EdgeInsets.zero,
              child: UITodoItem(todo: todos[index]),
            ),
          ),
        ),
      ),
    );
  }
}
