import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/shared/index.dart';

class UIEmptyWidget extends StatelessWidget {
  final String? message;
  const UIEmptyWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageAssets.svgAssets(ImageAssets.ic_empty,
            color: Get.theme.colorScheme.secondaryVariant),
        SizedBox(height: Constants.kOuterPadding),
        Text(
          message ?? '',
          style: UITextStyle.bodyStyle(
            color: Get.theme.colorScheme.secondaryVariant,
          ),
        ),
      ],
    );
  }
}
