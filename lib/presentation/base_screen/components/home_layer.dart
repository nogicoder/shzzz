import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shzzz/presentation/base_screen/base_screen.dart';

import 'package:shzzz/shared/index.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/presentation/base_screen/components/index.dart';

class HomeLayer extends GetView<BaseScreenController> {
  HomeLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Get.theme.colorScheme.secondary,
          inactiveColor: Get.theme.backgroundColor,
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
    return todos.isEmpty
        ? Padding(
            padding: EdgeInsets.only(top: 100),
            child: UIEmptyWidget(
              message: tr().no_task_inside,
            ),
          )
        : Padding(
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
          );
  }
}
