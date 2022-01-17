import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {
  static final kTinyPadding = 4.sp;
  static final kSmallPadding = 8.sp;
  static final kInnerPadding = 12.sp;
  static final kOuterPadding = 16.sp;
  static final kLargePadding = 24.sp;
  static final kPaddingStandard = EdgeInsets.all(16.sp);
  static final kInnerPaddingStandard = EdgeInsets.all(12.sp);
  static final kHorizontalPaddingStandard =
      EdgeInsets.symmetric(horizontal: 16.sp);
  static final kVerticalPaddingStandard = EdgeInsets.symmetric(vertical: 16.sp);
  static final kBorderRadius = 4.sp;
  static final kBorderRadiusStandard = BorderRadius.circular(8.sp);
  static final kStadiumBorderRadius = 100.sp;
  static const MIN_TITLE_LENGTH = 6;
  static const MAX_TITLE_LENGTH = 32;
  static const MAX_NOTE_LENGTH = 100;
}

enum AppEvent { NONE }
