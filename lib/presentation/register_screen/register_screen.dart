import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/data/index.dart';
import 'package:shzzz/shared/index.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            left: Constants.kOuterPadding,
            right: Constants.kOuterPadding,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr().how_to_call,
                      style: UITextStyle.headline5(FontWeight.bold)),
                  TextField(
                    decoration: InputDecoration(hintText: 'Eg: Peter'),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: Constants.kOuterPadding,
            left: Constants.kOuterPadding,
            right: Constants.kOuterPadding,
            child: UIButton(
              title: tr().lets_go,
              onTap: () {
                userConfigService.setUserInfo(UserInfo(name: 'Test'));
                Get.toNamed(Routes.BASE_SCREEN);
              },
            ),
          )
        ],
      ),
    );
  }
}
