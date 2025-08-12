import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/theme/theme_provider.dart';

class AppWrapper extends ConsumerWidget {
  final Widget home;
  final String title;

  const AppWrapper({super.key, required this.home, this.title = ""});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIOS = ref.watch(isIOSThemeProvider);

    if (isIOS) {
      return CupertinoApp(title: title, home: home);
    } else {
      return MaterialApp(title: title, home: home);
    }
  }
}
