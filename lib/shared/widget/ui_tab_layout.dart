import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/presentation/base_screen/base_screen.dart';
import 'package:shzzz/shared/index.dart';

//ignore: must_be_immutable
class UITabLayout extends StatelessWidget {
  final Widget child;
  UITabLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  var _locale = userConfigService.lang.obs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.backgroundColor,
      child: Stack(
        children: [
          Positioned.fill(
            top: 185,
            child: child,
          ),
          Positioned(
            top: 50,
            left: Constants.kOuterPadding,
            right: Constants.kOuterPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.find<BaseScreenController>().toggle(),
                      child: Icon(
                        Icons.menu,
                        color: Get.theme.primaryColor,
                        size: 40,
                      ),
                    ),
                    Obx(
                      () {
                        return InkWell(
                          onTap: userConfigService.updateLocale,
                          child: _locale == LOCALE_VI
                              ? Image.asset(ImageAssets.flag_vi,
                                  width: 40, height: 40)
                              : Image.asset(ImageAssets.flag_en,
                                  width: 30, height: 30),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: Constants.kOuterPadding),
                Text(
                  "${tr().hello}, ${userConfigService.userInfo?.name?.split(' ').first ?? ''}!",
                  maxLines: 2,
                  overflow: TextOverflow.visible,
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
