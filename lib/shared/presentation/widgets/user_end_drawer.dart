import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/l10n_generated/app_localizations.dart';

class UserEndDrawer extends ConsumerWidget {
  const UserEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // GUNAKAN L10n GLOBAL, BUKAN SharedL10n
    final l10n = L10n.of(context)!;

    final Map<String, dynamic> userData = {
      'username': 'Jamaludin',
      'email': 'jamal.keren@example.com',
      'profilePicture': 'https://i.pravatar.cc/150?u=a042581f4e29026704d',
    };
    final bool isAuthenticated = userData.isNotEmpty;

    final List<Map<String, dynamic>> userDrawerItems = [
      {'icon': Icons.person, 'title': l10n.bottomNavProfile, 'isActive': true},
      {
        'icon': Icons.food_bank,
        'title': l10n.drawerItemFoods,
        'isActive': false,
      },
      {
        'icon': Icons.receipt_long,
        'title': l10n.drawerItemOrders,
        'isActive': false,
      },
    ];

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDrawerHeader(context, userData, l10n),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: [
                  ...userDrawerItems.map((item) {
                    return _buildDrawerItem(
                      context,
                      icon: item['icon'],
                      title: item['title'],
                      isActive: item['isActive'],
                      onTap: () {
                        Navigator.of(context).pop();
                        print('${item['title']} tapped');
                      },
                    );
                  }).toList(),
                  _buildLanguageSelector(context, ref, l10n),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildAuthButton(context, isAuthenticated, l10n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(
    BuildContext context,
    Map<String, dynamic>? userData,
    L10n l10n, // Ganti tipe parameter
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.drawerHeaderTitle,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: userData?['profilePicture'] ?? '',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircleAvatar(
                    backgroundColor: context.colorScheme.primary.withOpacity(
                      0.1,
                    ),
                    child: const CupertinoActivityIndicator(),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: context.colorScheme.primary.withOpacity(
                      0.3,
                    ),
                    child: Icon(
                      Icons.person,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData?['username'] ?? l10n.drawerGuestUser,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userData?['email'] ?? l10n.drawerGuestLoginPrompt,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.textTheme.bodyMedium?.color?.withOpacity(
                          0.7,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButton(
    BuildContext context,
    bool isAuthenticated,
    L10n l10n, // Ganti tipe parameter
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        if (isAuthenticated) {
          _showLogoutDialog(context, l10n);
        } else {
          Navigator.of(context).pop();
          print('Navigate to Login Screen');
        }
      },
      icon: Icon(isAuthenticated ? Icons.logout : Icons.login),
      label: Text(
        isAuthenticated ? l10n.drawerActionLogout : l10n.drawerActionLogin,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isAuthenticated
            ? context.colorScheme.error
            : context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, L10n l10n) {
    // Ganti tipe parameter
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog.adaptive(
          title: Text(
            l10n.drawerLogoutDialogTitle,
            style: context.textTheme.titleLarge,
          ),
          content: Text(
            l10n.drawerLogoutDialogContent,
            style: context.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.drawerActionCancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
                print('Logout action & navigate to login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.error,
                foregroundColor: context.colorScheme.onError,
              ),
              child: Text(l10n.drawerActionLogout),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    // ... implementasi widget ini tidak perlu diubah ...
    final activeColor = context.colorScheme.primary;
    final inactiveColor = context.colorScheme.onSurface.withOpacity(0.7);

    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: CupertinoListTile(
          backgroundColor: isActive ? activeColor.withOpacity(0.1) : null,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          leading: Icon(icon, color: isActive ? activeColor : inactiveColor),
          title: Text(
            title,
            style: context.textTheme.bodyLarge?.copyWith(
              color: isActive ? activeColor : null,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          trailing: const Icon(CupertinoIcons.right_chevron, size: 16),
          onTap: onTap,
        ),
      );
    }

    return Card(
      color: isActive ? activeColor.withOpacity(0.1) : context.theme.cardColor,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: ListTile(
        leading: Icon(icon, color: isActive ? activeColor : inactiveColor),
        title: Text(
          title,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isActive ? activeColor : null,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        dense: true,
      ),
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    WidgetRef ref,
    L10n l10n, // Ganti tipe parameter
  ) {
    return _buildDrawerItem(
      context,
      icon: Icons.translate,
      title: l10n.drawerItemLanguage,
      isActive: false,
      onTap: () {
        _showLanguageDialog(context, ref, l10n);
      },
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref, L10n l10n) {
    // Ganti tipe parameter
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(l10n.dialogTitleSelectLanguage),
          children: [
            SimpleDialogOption(
              onPressed: () {
                ref.read(localeProvider.notifier).state = const Locale('en');
                Navigator.of(context).pop();
              },
              child: const Text('English'),
            ),
            SimpleDialogOption(
              onPressed: () {
                ref.read(localeProvider.notifier).state = const Locale('ja');
                Navigator.of(context).pop();
              },
              child: const Text('日本語 (Japanese)'),
            ),
          ],
        );
      },
    );
  }
}
