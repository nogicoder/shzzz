import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/presentation/base_screen/base_screen.dart';
import 'package:shzzz/shared/index.dart';

class UITabLayout extends StatelessWidget {
  final Widget child;
  const UITabLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.backgroundColor,
      child: Stack(
        children: [
          Positioned.fill(
            top: 150,
            child: child,
          ),
          Positioned(
            top: 50,
            left: Constants.kOuterPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.find<BaseScreenController>().toggle(),
                  child: Icon(
                    Icons.menu,
                    color: Get.theme.primaryColor,
                    size: 30,
                  ),
                ),
                SizedBox(height: Constants.kOuterPadding),
                Text(
                  "What's up, ${userConfigService.userInfo?.name ?? ''}!",
                  style: UITextStyle.headline4(FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 30,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => goCreateTaskScreen(),
            ),
          )
        ],
      ),
    );
  }
}
