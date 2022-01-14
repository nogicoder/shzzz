import 'package:flutter/material.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/shared/constants.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: Constants.kOuterPadding,
                child: Text(
                  'Hi ${userConfigService.userInfo?.name ?? ''}, wish you a nice day!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
