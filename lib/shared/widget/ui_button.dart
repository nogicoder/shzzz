import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/shared/index.dart';

/// Common button widget with basic properties such as: [title], [width],
/// [height], [buttonColor], etc
class UIButton extends StatelessWidget {
  final String? title;
  final bool isDisable;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Widget? labelWidget;

  const UIButton({
    Key? key,
    @required this.title,
    this.isDisable = false,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.width,
    this.height,
    this.onTap,
    this.labelWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 45,
        child: ElevatedButton(
          onPressed: isDisable ? null : onTap,
          style: ElevatedButton.styleFrom(
            primary: isDisable
                ? Color(0xFF333333).withOpacity(0.2)
                : buttonColor ?? Get.theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: Constants.kBorderRadiusStandard,
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: 1)
                  : BorderSide.none,
            ),
          ),
          child: labelWidget ??
              Text(
                title ?? '',
                style: TextStyle(
                    fontSize: fontSize,
                    color: isDisable
                        ? Color(0xFF333333).withOpacity(0.6)
                        : textColor,
                    fontWeight: FontWeight.w700),
              ),
        ),
      ),
    );
  }
}
