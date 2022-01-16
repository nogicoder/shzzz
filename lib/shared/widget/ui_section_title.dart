import 'package:flutter/material.dart';
import 'package:shzzz/shared/index.dart';

class UISectionTitle extends StatelessWidget {
  final String? title;
  const UISectionTitle({
    Key? key,
    this.title,
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
          color: Colors.blueGrey,
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
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
