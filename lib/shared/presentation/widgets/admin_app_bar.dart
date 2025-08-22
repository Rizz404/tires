import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool automaticLeading;
  final Widget? leading;
  final Color? backgroundColor;
  final double? elevation;
  final bool centerTitle;

  const AdminAppBar({
    super.key,
    this.title,
    this.automaticLeading = true,
    this.leading,
    this.backgroundColor,
    this.elevation,
    this.centerTitle = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final titleWidget = AppText(
      title ?? context.l10n.appName,
      color: context.colorScheme.surface,
    );
    final actionButton = Builder(
      builder: (innerContext) => IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Open Menu',
        onPressed: () {
          Scaffold.of(innerContext).openEndDrawer();
        },
      ),
    );

    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: titleWidget,
        trailing: actionButton,
        automaticallyImplyLeading: automaticLeading,
        leading: leading,
        backgroundColor: backgroundColor,
      );
    }

    return AppBar(
      title: titleWidget,
      actions: [actionButton, const SizedBox(width: 4)],
      automaticallyImplyLeading: automaticLeading,
      leading: leading,
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
    );
  }
}
