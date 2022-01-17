import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/shared/index.dart';

class UISectionTitle extends StatelessWidget {
  final String? title;
  final bool isExpanded;
  const UISectionTitle({
    Key? key,
    this.title,
    this.isExpanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Constants.kPaddingStandard,
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Constants.kInnerPadding,
            vertical: Constants.kTinyPadding),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.secondary,
          borderRadius: Constants.kBorderRadiusStandard,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? '',
              style: UITextStyle.subtitle1(true)?.copyWith(
                color: Colors.white,
              ),
            ),
            Icon(
                isExpanded
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                color: Colors.white),
          ],
        ),
      ),
    );
  }
}
