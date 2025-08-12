import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/l10n_generated/app_localizations.dart';

class UserEndDrawer extends ConsumerWidget {
  const UserEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context)!;

    final Map<String, dynamic> userData = {
      // 'username': 'Jamaludin',
      // 'email': 'jamal.keren@example.com',
      // 'profilePicture': 'https://i.pravatar.cc/150?u=a042581f4e29026704d',
    };
    final bool isAuthenticated = userData.isNotEmpty;

    // Safely check if AutoTabsRouter is available
    TabsRouter? tabsRouter;
    int currentTabIndex = -1;

    try {
      tabsRouter = AutoTabsRouter.of(context, watch: true);
      currentTabIndex = tabsRouter.activeIndex;
    } catch (e) {
      // AutoTabsRouter not found in context - we're not in a tab screen
      tabsRouter = null;
      currentTabIndex = -1;
    }

    final List<Map<String, dynamic>> userDrawerItems = [
      {
        'icon': Icons.home_outlined,
        'selectedIcon': Icons.home,
        'title': l10n.bottomNavHome,
        'isActive': currentTabIndex == 0,
        'type': 'tab',
        'tabIndex': 0,
      },
      {
        'icon': Icons.dinner_dining_outlined,
        'selectedIcon': Icons.dinner_dining,
        'title': l10n.bottomNavReservations,
        'isActive': currentTabIndex == 1,
        'type': 'tab',
        'tabIndex': 1,
      },
      {
        'icon': Icons.person_outlined,
        'selectedIcon': Icons.person,
        'title': l10n.bottomNavProfile,
        'isActive': currentTabIndex == 2,
        'type': 'tab',
        'tabIndex': 2,
      },
      {
        'icon': Icons.help_outline,
        'selectedIcon': Icons.help,
        'title': l10n.drawerItemInquiry,
        'isActive': false,
        'type': 'route',
        'route': const InquiryRoute(),
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
                      selectedIcon: item['selectedIcon'],
                      title: item['title'],
                      isActive: item['isActive'],
                      onTap: () {
                        Navigator.of(context).pop(); // Close drawer first

                        final itemType = item['type'] as String;

                        switch (itemType) {
                          case 'tab':
                            // Navigate to tab - only if tabsRouter is available
                            if (tabsRouter != null) {
                              final tabIndex = item['tabIndex'] as int;
                              tabsRouter.setActiveIndex(tabIndex);
                            } else {
                              // If not in tab context, navigate to UserTabScreen first
                              context.router.push(const UserTabRoute());
                              // Note: This will navigate to the first tab (index 0) by default
                            }
                            break;
                          case 'route':
                            // Navigate to external route
                            final route = item['route'];
                            if (route != null) {
                              context.router.push(route);
                            }
                            break;
                          default:
                            print('Unknown navigation type: $itemType');
                        }
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
    L10n l10n,
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
    L10n l10n,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).pop(); // Close drawer first
        if (isAuthenticated) {
          _showLogoutDialog(context, l10n);
        } else {
          context.router.push(LoginRoute());
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
        foregroundColor: isAuthenticated
            ? context.colorScheme.onError
            : context.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, L10n l10n) {
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
                // Implement actual logout logic here
                print('Logout action & navigate to login');
                // You might want to navigate to login after logout
                // context.router.pushAndClearStack(LoginRoute());
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
    IconData? selectedIcon,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final activeColor = context.colorScheme.primary;
    final inactiveColor = context.colorScheme.onSurface.withOpacity(0.7);
    final displayIcon = isActive && selectedIcon != null ? selectedIcon : icon;

    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: CupertinoListTile(
          backgroundColor: isActive ? activeColor.withOpacity(0.1) : null,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          leading: Icon(
            displayIcon,
            color: isActive ? activeColor : inactiveColor,
          ),
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
        leading: Icon(
          displayIcon,
          color: isActive ? activeColor : inactiveColor,
        ),
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
    L10n l10n,
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
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(l10n.dialogTitleSelectLanguage),
          children: [
            SimpleDialogOption(
              onPressed: () {
                ref
                    .read(localeProvider.notifier)
                    .changeLocale(const Locale('en'));
                Navigator.of(context).pop();
              },
              child: const Text('English'),
            ),
            SimpleDialogOption(
              onPressed: () {
                ref
                    .read(localeProvider.notifier)
                    .changeLocale(const Locale('ja'));
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
