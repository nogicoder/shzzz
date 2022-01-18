import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/presentation/base_screen/base_screen.dart';
import 'package:shzzz/shared/index.dart';
import 'package:url_launcher/url_launcher.dart';

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

//ignore: must_be_immutable
class DrawerLayer extends GetView<BaseScreenController> {
  DrawerLayer({Key? key}) : super(key: key);

  late DrawerLayerController drawerController;

  @override
  Widget build(BuildContext context) {
    drawerController = Get.put(DrawerLayerController());
    return Container(
      color: Get.theme.primaryColor,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(Constants.kTinyPadding),
              decoration: BoxDecoration(
                border: Border.all(color: Get.theme.highlightColor, width: 5),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(ImageAssets.getTestImage(512)),
              )),
          SizedBox(height: 40),
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
          Divider(color: Colors.blue.shade800),
          SizedBox(height: 30),
          Obx(() => _buildInfoRow(
              '${tr().completed}: ', '${controller.completedTodos.length}')),
          SizedBox(height: 30),
          Obx(() => _buildInfoRow(
              '${tr().ongoing}: ', '${controller.ongoingTodos.length}')),
          SizedBox(height: 40),
          TodoChart(),
          Spacer(),
          Obx(
            () => Text(
              'v${drawerController.packageInfo.value}',
              style: UITextStyle.bodyStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: userConfigService.logOut,
            child: Text(
              tr().logout,
              style: UITextStyle.bodyStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeButton() {
    return InkWell(
      onTap: () {
        userConfigService.setTheme();
        drawerController.reflectTheme();
      },
      child: Row(
        children: [
          Obx(
            () => Icon(
              drawerController.isLightTheme.value
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
              color: Get.theme.colorScheme.secondaryVariant,
            ),
          ),
          SizedBox(width: Constants.kOuterPadding),
          Text(
            tr().change_theme,
            style: UITextStyle.subtitle1()?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportButton() {
    return InkWell(
      onTap: () => launch('mailto:$EMAIL_SUPPORT'),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.conversation_bubble,
            color: Get.theme.colorScheme.secondaryVariant,
          ),
          SizedBox(width: Constants.kOuterPadding),
          Text(
            tr().contact_support,
            style: UITextStyle.subtitle1()?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return RichText(
      text: TextSpan(
        style: UITextStyle.bodyStyle(color: Colors.white),
        children: [
          TextSpan(text: title),
          TextSpan(
            text: value,
            style: UITextStyle.bodyStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
