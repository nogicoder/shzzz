import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/shared/index.dart';

class DialogUtil {
  static String defaultTitle = APP_TITLE;
  static Future<T?> confirm<T>(
    Widget content, {
    String? title,
    String? cancelText,
    String? submitText,
    Function? onCancel,
    Function? onSubmit,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: Get.context!,
          useRootNavigator: false,
          builder: (context) {
            return _alertConfirm(
              content,
              title: title,
              cancelText: cancelText,
              submitText: submitText,
              onCancel: onCancel,
              onSubmit: onSubmit,
            );
          });
    }
    return showDialog<T>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? defaultTitle),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          content: content,
          actions: <Widget>[
            TextButton(
                child: Text(cancelText ?? tr().cancel),
                onPressed: () {
                  Get.back();
                  if (onCancel != null) {
                    onCancel();
                  }
                }),
            TextButton(
              child: Text(submitText ?? tr().ok),
              onPressed: () {
                Get.back();
                if (onSubmit != null) {
                  onSubmit();
                }
              },
            )
          ],
        );
      },
    );
  }

  static Future<T?> options<T>({
    String? title,
    List<T>? options,
    Widget? creatorItem(T item)?,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: Get.context!,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return _simpleOptions<T>(
            title: title,
            options: options,
            creatorItem: creatorItem,
          );
        },
      );
    }
    return showDialog<T>(
      context: Get.context!,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: title != null ? Text(title) : null,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          children: options
              ?.map(
                (item) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, item),
                  child: creatorItem?.call(item),
                ),
              )
              .toList(),
        );
      },
    );
  }

  static Future<T?> alert<T>(
    dynamic content, {
    Function? onSubmit,
    String? title,
    String? submit,
    bool? barrierDismissible,
  }) {
    if (content == null || (content is String && content.trim().isEmpty)) {
      return Future.value();
    }

    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: Get.context!, useRootNavigator: false,
        barrierDismissible:
            barrierDismissible ?? false, // user must tap button!
        builder: (BuildContext context) {
          return _alert(
            content,
            onSubmit: onSubmit,
            title: title,
            submit: submit,
          );
        },
      );
    }
    return showDialog<T>(
      context: Get.context!,
      barrierDismissible: barrierDismissible ?? false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: title?.isNotEmpty == true ? Text(title!) : Text(defaultTitle),
          content: content is String && content.isNotEmpty == true
              ? Text(content)
              : content,
          actions: <Widget>[
            TextButton(
              child: Text(submit ?? tr().ok),
              onPressed: () {
                Get.back();
                if (onSubmit != null) {
                  onSubmit();
                }
              },
            )
          ],
        );
      },
    );
  }

  static _alertConfirm(
    Widget content, {
    String? title,
    String? cancelText,
    String? submitText,
    Function? onCancel,
    Function? onSubmit,
  }) {
    return CupertinoAlertDialog(
      title: Text(title ?? defaultTitle),
      content: content,
      actions: <Widget>[
        CupertinoDialogAction(
            child: Text(cancelText ?? tr().cancel),
            onPressed: () {
              Get.back();
              if (onCancel != null) {
                onCancel();
              }
            }),
        CupertinoDialogAction(
          child: Text(submitText ?? tr().ok),
          onPressed: () {
            Get.back();
            if (onSubmit != null) {
              onSubmit();
            }
          },
        )
      ],
    );
  }

  static _simpleOptions<T>({
    String? title,
    List<T>? options,
    Widget? creatorItem(T item)?,
  }) {
    return CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      actions: options
              ?.map(
                (item) => CupertinoDialogAction(
                  onPressed: () => Get.back(result: item),
                  child: creatorItem?.call(item) ?? Container(),
                ),
              )
              .toList() ??
          [],
    );
  }

  static _alert(
    dynamic content, {
    Function? onSubmit,
    String? title,
    String? submit,
  }) {
    return CupertinoAlertDialog(
      title: title?.isNotEmpty == true ? Text(title ?? '') : Text(defaultTitle),
      content: content is String && content.isNotEmpty == true
          ? Text(content)
          : content,
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(submit ?? tr().ok),
          onPressed: () {
            Get.back();
            if (onSubmit != null) {
              onSubmit();
            }
          },
        )
      ],
    );
  }

  static comingSoonMessage(BuildContext context) {
    DialogUtil.alert(tr().developing_feature);
  }

  static showFlushBar(String message,
      {Color? backgroundColor,
      Widget? iconFlushBar,
      Duration duration = const Duration(seconds: 2)}) {
    Flushbar(
      backgroundColor: backgroundColor ?? Colors.green,
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageColor: Colors.white,
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      icon: iconFlushBar ??
          Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
          ),
      message: message,
    )..show(Get.context!);
  }

  static Future<T?> confirmSheet<T>({
    String? title,
    String? content,
    String? cancelText,
    String? submitText,
    Color? submitColor,
    Color? cancelColor,
  }) {
    return showCupertinoModalPopup(
        context: Get.context!,
        useRootNavigator: false,
        builder: (popupContext) {
          return CupertinoActionSheet(
            title: Text(
              title ?? defaultTitle,
              style: Get.theme.textTheme.subtitle2!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            message: (content != null && content.length > 0)
                ? Container(
                    alignment: Alignment.center,
                    child: Text(content, style: Get.theme.textTheme.caption),
                  )
                : null,
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(popupContext).pop(true);
                },
                child: Text(
                  submitText ?? tr().confirm,
                  style: TextStyle(
                    color: submitColor ?? Color(0XFF007AFF),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(popupContext).pop();
              },
              child: Text(
                cancelText ?? tr().cancel,
                style: TextStyle(
                  color: cancelColor ?? Color(0XFF007AFF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        });
  }
}
