import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/shared/index.dart';

/// [DialogUtil] helps display various types of dialog across screens.
class DialogUtil {
  static String defaultTitle = APP_TITLE;

  /// [confirm] is used to display dialog with 2 actions
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

  /// [alert] is used to display dialog with 1 action, usually to notify error
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

  /// Display message when user click on widget in development
  static comingSoonMessage(BuildContext context) {
    DialogUtil.alert(tr().developing_feature);
  }
}
