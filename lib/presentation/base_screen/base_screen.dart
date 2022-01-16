import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:expandable/expandable.dart';

import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/shared/index.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Get.theme.primaryColor,
          activeColor: Get.theme.colorScheme.surface,
          iconSize: 24,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.check_mark_circled),
              label: 'Ongoing',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clear_circled),
              label: 'Completed',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
            default:
              return UITabLayout(child: _buildFirstTab());
          }
        },
      ),
    );
  }

  Widget _buildFirstTab() {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Constants.kHorizontalPaddingStandard,
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                List<Widget>.generate(
                  10,
                  (index) => Padding(
                    padding: index != 10
                        ? EdgeInsets.only(bottom: Constants.kSmallPadding)
                        : EdgeInsets.zero,
                    child: UITodoItem(),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ExpandableNotifier(
              child: Column(
                children: [
                  Expandable(
                    collapsed: ExpandableButton(
                      child: UISectionTitle(title: tr().completed),
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
                              10,
                              (index) => Padding(
                                padding: index != 10
                                    ? EdgeInsets.only(
                                        bottom: Constants.kSmallPadding)
                                    : EdgeInsets.zero,
                                child: UITodoItem(),
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

  Widget _buildItem(int index) {
    return Container();
  }
}
