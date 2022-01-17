import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/shared/constants.dart';
import 'package:shzzz/shared/index.dart';

class DrawerLayerController extends GetxController {
  var packageInfo = ''.obs;

  var isLightTheme = userConfigService.isLightTheme.obs;

  void reflectTheme() => isLightTheme.value = !isLightTheme.value;

  @override
  void onInit() {
    PackageInfo.fromPlatform().then((value) {
      packageInfo.value = value.version;
    });
    super.onInit();
  }
}

class DrawerLayer extends StatelessWidget {
  DrawerLayer({Key? key}) : super(key: key);

  late DrawerLayerController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(DrawerLayerController());
    return Container(
      color: Get.theme.primaryColor,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 60),
          SizedBox(height: 30),
          Text(
            userConfigService.userInfo?.name ?? '',
            style: UITextStyle.headline4()?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          _buildThemeButton(),
          SizedBox(height: 30),
          _buildSupportButton(),
          SizedBox(height: 30),
          Divider(color: Get.theme.colorScheme.secondary),
          SizedBox(height: 30),
          Text(
            'Completed tasks: ',
            style: UITextStyle.bodyStyle(color: Colors.white),
          ),
          SizedBox(height: 30),
          Text('Ongoing tasks: ',
              style: UITextStyle.bodyStyle(color: Colors.white)),
          SizedBox(height: 30),
          Spacer(),
          Obx(
            () => Text(
              'Version: ${controller.packageInfo.value}',
              style: UITextStyle.bodyStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildThemeButton() {
    return InkWell(
      onTap: () {
        userConfigService.setTheme();
        controller.reflectTheme();
      },
      child: Row(
        children: [
          Obx(
            () => Icon(
              controller.isLightTheme.value
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
              color: Get.theme.colorScheme.secondaryVariant,
              size: 26,
            ),
          ),
          SizedBox(width: Constants.kOuterPadding),
          Text(
            'Change theme',
            style: UITextStyle.subtitle1()?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportButton() {
    return InkWell(
      onTap: () {
        userConfigService.setTheme();
        controller.reflectTheme();
      },
      child: Row(
        children: [
          Icon(
            CupertinoIcons.conversation_bubble,
            color: Get.theme.colorScheme.secondaryVariant,
            size: 25,
          ),
          SizedBox(width: Constants.kOuterPadding),
          Text(
            'Contact support',
            style: UITextStyle.subtitle1()?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
