import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/data/index.dart';
import 'package:shzzz/shared/index.dart';

/// [RegisterScreen] ask users to provide his/her name to the app for better
/// interaction
/// Navigate to [BaseScreen] after completion
//ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController textController = TextEditingController();

  var hasError = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: _buildLogo(),
          ),
          Positioned(
            left: Constants.kOuterPadding,
            right: Constants.kOuterPadding,
            child: _buildNameField(),
          ),
          Positioned(
            bottom: Constants.kOuterPadding,
            left: Constants.kOuterPadding,
            right: Constants.kOuterPadding,
            child: _buildSubmitButton(),
          )
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 25,
      height: 25,
      child: ImageAssets.svgAssets(ImageAssets.ic_logo),
    );
  }

  /// 2 cases:
  /// - Error case: Empty state -> Display error text to notify users
  /// - Happy case: Inputted state
  Widget _buildNameField() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr().how_to_call,
              style: UITextStyle.headline4(FontWeight.bold)
                  ?.copyWith(color: Get.theme.primaryColor)),
          SizedBox(height: Constants.kOuterPadding),
          Obx(
            () => TextField(
              autofocus: true,
              controller: textController,
              maxLength: Constants.MAX_TITLE_LENGTH,
              onChanged: (value) => hasError.value = value.isEmpty,
              decoration: InputDecoration(
                hintText: 'Eg: Peter',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorText: hasError.value ? tr().empty_error : null,
                hintStyle: UITextStyle.headline5()
                    ?.copyWith(color: Get.theme.colorScheme.surface),
              ),
              style: UITextStyle.headline5()
                  ?.copyWith(color: Get.theme.primaryColor),
            ),
          )
        ],
      ),
    );
  }

  /// Save the user's info to [SharedPreferences] using [UserConfigService],
  /// then navigate to [BaseScreen]
  Widget _buildSubmitButton() {
    return UIButton(
      title: tr().lets_go,
      onTap: () {
        hasError.value = textController.text.isEmpty;
        if (!hasError.value) {
          userConfigService
              .setUserInfo(UserInfo(name: textController.text.trim()));
          Get.toNamed(Routes.BASE_SCREEN);
        }
      },
    );
  }
}
