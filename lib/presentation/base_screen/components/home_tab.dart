import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';

import 'package:shzzz/shared/index.dart';

class HomeTab extends StatelessWidget {
  final List<Todo> ongoingTodos;
  final List<Todo> completedTodos;

  HomeTab({
    Key? key,
    required this.ongoingTodos,
    required this.completedTodos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.backgroundColor,
      child: CustomScrollView(
        slivers: [
          Obx(
            () => SliverPadding(
              padding: Constants.kHorizontalPaddingStandard,
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  List<Widget>.generate(
                    ongoingTodos.length,
                    (index) => Padding(
                      padding: index != ongoingTodos.length
                          ? EdgeInsets.only(bottom: Constants.kSmallPadding)
                          : EdgeInsets.zero,
                      child: UITodoItem(
                        todo: ongoingTodos[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ExpandableNotifier(
              initialExpanded: true,
              child: Column(
                children: [
                  ExpandablePanel(
                    collapsed: ExpandableButton(
                      child: UISectionTitle(
                        title: tr().completed,
                        isExpanded: false,
                      ),
                    ),
                    expanded: Column(
                      children: [
                        ExpandableButton(
                          child: UISectionTitle(title: tr().completed),
                        ),
                        Obx(
                          () => Padding(
                            padding: Constants.kHorizontalPaddingStandard,
                            child: ListBody(
                              children: List<Widget>.generate(
                                completedTodos.length,
                                (index) => Padding(
                                  padding: index != completedTodos.length
                                      ? EdgeInsets.only(
                                          bottom: Constants.kSmallPadding)
                                      : EdgeInsets.zero,
                                  child: UITodoItem(
                                    todo: completedTodos[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
    );
  }
}
