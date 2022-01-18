import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import 'package:shzzz/shared/index.dart';
import 'package:shzzz/data/database/todo_table.dart';

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
    return Obx(
      () => CustomScrollView(
        slivers: [
          ongoingTodos.isEmpty && completedTodos.isEmpty
              ? SliverPadding(
                  padding: EdgeInsets.only(top: 100),
                  sliver: SliverToBoxAdapter(
                      child: UIEmptyWidget(message: tr().empty_todos)),
                )
              : SliverPadding(
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
          if (completedTodos.isNotEmpty)
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
                          Padding(
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
