import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/shared/index.dart';

class ModalUtils {
  static Future<T?> showCustomModalBottomSheet<T>(String title, Widget body,
      {double? height = 250, bool showClose = true, bool enableDrag = true}) {
    return Get.bottomSheet<T>(
      Container(
        margin: EdgeInsets.only(top: 100),
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Constants.kBorderRadius),
              topRight: Radius.circular(Constants.kBorderRadius)),
          child: Container(
            height: height,
            color: Get.theme.cardColor,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    if (showClose)
                      Positioned(
                        left: 0,
                        child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: UITextStyle.bodyStyle().color,
                            ),
                            onPressed: () => Get.back()),
                      ),
                    Container(
                      alignment: Alignment.center,
                      padding: Constants.kInnerPaddingStandard,
                      child: Text(
                        title,
                        style: UITextStyle.buttonStyle(),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Expanded(child: SafeArea(child: body)),
              ],
            ),
          ),
        ),
      ),
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constants.kBorderRadius),
          topRight: Radius.circular(Constants.kBorderRadius),
        ),
      ),
    );
  }
}
