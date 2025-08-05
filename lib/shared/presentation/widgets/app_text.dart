import 'package:flutter/material.dart';

enum AppTextStyle { titleLarge, title, headline, body, caption }

class AppText extends StatelessWidget {
  final String text;
  final AppTextStyle style;
  final TextAlign? textAlign;
  final Color? color;

  const AppText(
    this.text, {
    super.key,
    this.style = AppTextStyle.body,
    this.textAlign,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    TextStyle getTextStyle() {
      switch (style) {
        case AppTextStyle.titleLarge:
          return textTheme.titleLarge!;
        case AppTextStyle.title:
          return textTheme.titleMedium!;
        case AppTextStyle.headline:
          return textTheme.headlineSmall!;
        case AppTextStyle.body:
          return textTheme.bodyMedium!;
        case AppTextStyle.caption:
          return textTheme.bodySmall!;
      }
    }

    return Text(
      text,
      style: getTextStyle().copyWith(color: color),
      textAlign: textAlign,
    );
  }
}
