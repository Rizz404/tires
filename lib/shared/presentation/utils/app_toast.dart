import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class AppToast {
  static void showSuccess(BuildContext context, {required String message}) {
    BotToast.showText(
      text: message,
      contentColor: Theme.of(context).colorScheme.primary,
      textStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  static void showError(BuildContext context, {required String message}) {
    BotToast.showText(
      text: message,
      contentColor: Theme.of(context).colorScheme.error,
      textStyle: TextStyle(color: Theme.of(context).colorScheme.onError),
    );
  }

  static CancelFunc showLoading() {
    return BotToast.showLoading();
  }
}
