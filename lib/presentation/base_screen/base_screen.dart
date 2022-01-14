import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/shared/constants.dart';
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
              return _buildFirstTab();
          }
        },
      ),
    );
  }

  Widget _buildFirstTab() {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: Constants.kHorizontalPaddingStandard,
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "What's up, ${userConfigService.userInfo?.name ?? ''}!",
                        style: UITextStyle.headline4(FontWeight.bold),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      List<Widget>.generate(
                        10,
                        (index) => _buildItem(index),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    return Container();
  }
}
