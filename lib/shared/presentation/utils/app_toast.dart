import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/theme/app_theme.dart';

enum ToastType { success, error, warning, info }

class AppToast {
  static void _showToast(
    BuildContext context, {
    required String message,
    required ToastType type,
  }) {
    Color backgroundColor;
    Color textColor;

    switch (type) {
      case ToastType.success:
        backgroundColor = AppTheme.success;
        textColor = Colors.white;
        break;
      case ToastType.error:
        backgroundColor = context.colorScheme.error;
        textColor = context.colorScheme.onError;
        break;
      case ToastType.warning:
        backgroundColor = AppTheme.warning;
        textColor = AppTheme.mainText;
        break;
      case ToastType.info:
        backgroundColor = AppTheme.mainText; // Like the SnackBar theme
        textColor = Colors.white;
        break;
    }

    BotToast.showText(
      text: message,
      contentColor: backgroundColor,
      textStyle: TextStyle(color: textColor, fontSize: 14),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: const Duration(seconds: 2),
      align: const Alignment(0, 0.9),
    );
  }

  static void showSuccess(BuildContext context, {required String message}) {
    _showToast(context, message: message, type: ToastType.success);
  }

  static void showError(BuildContext context, {required String message}) {
    _showToast(context, message: message, type: ToastType.error);
  }

  static void showWarning(BuildContext context, {required String message}) {
    _showToast(context, message: message, type: ToastType.warning);
  }

  static void showInfo(BuildContext context, {required String message}) {
    _showToast(context, message: message, type: ToastType.info);
  }

  static CancelFunc showLoading() {
    return BotToast.showLoading(
      backgroundColor: Colors.black.withOpacity(0.5),
    );
  }
}