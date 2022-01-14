import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 2018 spec has thirteen text styles:
/// ```
/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25  => OVERRIDE TO 30
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
/// ```
///
class UITextStyle {
  //- Dùng cho tiêu đề in đậm (Semi-bold)
  static TextStyle titleBoldStyle({
    Color? color,
    double? fontSize,
  }) {
    return Get.textTheme.headline6!.copyWith(
      fontWeight: FontWeight.w600,
      color: color,
      fontSize: fontSize,
    );
  }

  //- Dùng cho tiêu đề kiểu Medium
  static TextStyle titleStyle({
    Color? color,
    FontWeight? weight,
  }) {
    return Get.textTheme.subtitle1!.copyWith(
      fontWeight: weight ?? FontWeight.w600,
      color: color,
    );
  }

  //- Dùng cho mô tả kiểu regular, màu giống title
  static TextStyle descStyle({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return UITextStyle.baseStyle(
      fontWeight: fontWeight,
      color: color ?? Get.theme.textTheme.caption?.color,
    );
  }

  //- Dùng cho mô tả kiểu regular, màu nhạt
  static TextStyle bodyStyle({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return UITextStyle.baseStyle(
      fontWeight: fontWeight,
      color: color ?? Get.theme.textTheme.bodyText2?.color,
    );
  }

  //- Dùng cho caption kiểu regular, màu nhạt
  static TextStyle captionStyle({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Get.textTheme.caption!.copyWith(
      fontWeight: fontWeight,
      color: color ?? Get.theme.textTheme.caption?.color,
    );
  }

  //- Dùng cho tiêu đề button
  static TextStyle buttonStyle({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Get.textTheme.subtitle1!.copyWith(
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle baseStyle({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Get.theme.textTheme.bodyText2!.copyWith(
      fontWeight: fontWeight,
      color: color,
    );
  }

  static Color? titleColor() {
    return Get.textTheme.subtitle1?.color;
  }

  static Color? captionColor() {
    return Get.textTheme.caption?.color;
  }

  //chữ thường mờ
  static TextStyle? bodyText1([bool? bold]) {
    var bodyText1 = Get.textTheme.bodyText1;
    if (bold == true) {
      return bodyText1?.copyWith(fontWeight: FontWeight.w500);
    }
    return bodyText1;
  }

  //chữ thường
  static TextStyle? bodyText2([bool? bold]) {
    var bodyText2 = Get.textTheme.bodyText2;
    if (bold == true) {
      return bodyText2?.copyWith(fontWeight: FontWeight.w500);
    }
    return bodyText2;
  }

  //chữ thường đậm
  static TextStyle? subtitle2([bool? strongBold]) {
    var subtitle2 = Get.textTheme.subtitle2;
    if (strongBold == true) {
      return subtitle2?.copyWith(fontWeight: FontWeight.w700);
    }
    return subtitle2;
  }

  //chữ thường lớn
  static TextStyle? subtitle1([bool? bold]) {
    var subtitle1 = Get.textTheme.subtitle1;
    if (bold == true) {
      return subtitle1?.copyWith(fontWeight: FontWeight.w500);
    }
    return subtitle1;
  }

  //caption chữ bé mờ
  static TextStyle? caption([bool? bold]) {
    var caption = Get.textTheme.caption;
    if (bold == true) {
      return caption?.copyWith(fontWeight: FontWeight.w500);
    }
    return caption;
  }

  //tiêu đề lớn
  static TextStyle? headline5([FontWeight? fontWeight]) {
    var headline5 = Get.textTheme.headline5;
    if (fontWeight != null) {
      return headline5?.copyWith(fontWeight: fontWeight);
    }
    return headline5;
  }

  //tiêu đề đậm
  static TextStyle? headline6([bool? strongBold]) {
    var headline6 = Get.textTheme.headline6;
    if (strongBold == true) {
      return headline6?.copyWith(fontWeight: FontWeight.w700);
    }
    return headline6;
  }

  //chữ siêu nhỏ
  static TextStyle? overline([FontWeight? fontWeight]) {
    var overline = Get.textTheme.overline;
    if (fontWeight != null) {
      return overline?.copyWith(fontWeight: fontWeight);
    }
    return overline;
  }

  //tiêu đề lớn 30
  static TextStyle? headline4([FontWeight? fontWeight]) {
    var headline4 = Get.textTheme.headline4;
    if (fontWeight != null) {
      return headline4?.copyWith(fontWeight: fontWeight);
    }
    return headline4;
  }
}
