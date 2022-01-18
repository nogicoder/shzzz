import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import 'package:shzzz/shared/index.dart';
import 'package:shzzz/data/database/todo_table.dart';

/// [HomeTab] displays both ongoing todo items and completed items
/// Displays an [UIEmptyWidget] if there is no todo items
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
          if (ongoingTodos.isEmpty && completedTodos.isEmpty)
            SliverPadding(
              padding: EdgeInsets.only(top: 100),
              sliver: SliverToBoxAdapter(
                  child: UIEmptyWidget(message: tr().empty_todos)),
            ),
          if (ongoingTodos.isNotEmpty) _buildOngoingTodos(),
          if (completedTodos.isNotEmpty) _buildCompletedTodos(),
          SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
    );
  }

  Widget _buildOngoingTodos() {
    return SliverPadding(
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
    );
  }

  /// The completed todo list can be expanded and shorten when the user clicks
  /// on the [UISectionTitle]
  Widget _buildCompletedTodos() {
    return SliverToBoxAdapter(
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
                              ? EdgeInsets.only(bottom: Constants.kSmallPadding)
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
    );
  }
}
