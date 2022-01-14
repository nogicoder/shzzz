import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/shared/index.dart';

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
        height: height ?? 40,
        child: ElevatedButton(
          onPressed: isDisable ? null : onTap,
          style: Get.theme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: isDisable
                ? MaterialStateProperty.all(Color(0xFF333333).withOpacity(0.2))
                : MaterialStateProperty.all(
                    buttonColor ?? Get.theme.primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: Constants.kBorderRadiusStandard,
                side: borderColor != null
                    ? BorderSide(color: borderColor!, width: 1)
                    : BorderSide.none,
              ),
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
