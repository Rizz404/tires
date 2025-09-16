import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/l10n_generated/app_localizations.dart';

class UserEndDrawer extends ConsumerWidget {
  const UserEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated &&
          ModalRoute.of(context)?.isCurrent == true) {
        context.router.replaceAll([const LoginRoute()]);
      }
    });

    final l10n = L10n.of(context)!;
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;
    final isAuthenticated = authState.status == AuthStatus.authenticated;

    TabsRouter? tabsRouter;
    int currentTabIndex = -1;

    try {
      tabsRouter = AutoTabsRouter.of(context, watch: true);
      currentTabIndex = tabsRouter.activeIndex;
    } catch (e) {
      tabsRouter = null;
      currentTabIndex = -1;
    }

    final List<Map<String, dynamic>> userDrawerItems = [
      {
        'icon': Icons.home_outlined,
        'selectedIcon': Icons.home,
        'title': l10n.userBottomNavHome,
        'isActive': currentTabIndex == 0,
        'type': 'tab',
        'tabIndex': 0,
      },
      {
        'icon': Icons.dinner_dining_outlined,
        'selectedIcon': Icons.dinner_dining,
        'title': l10n.userBottomNavReservations,
        'isActive': currentTabIndex == 1,
        'type': 'tab',
        'tabIndex': 1,
      },
      {
        'icon': Icons.person_outlined,
        'selectedIcon': Icons.person,
        'title': l10n.userBottomNavProfile,
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
      {
        'icon': Icons.privacy_tip_outlined,
        'selectedIcon': Icons.privacy_tip,
        'title': l10n.drawerItemPrivacyPolicy,
        'isActive': false,
        'type': 'route',
        'route': const PrivacyPolicyRoute(),
      },
      {
        'icon': Icons.description_outlined,
        'selectedIcon': Icons.description,
        'title': l10n.drawerItemTermsOfService,
        'isActive': false,
        'type': 'route',
        'route': const TermsOfServiceRoute(),
      },
    ];

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDrawerHeader(context, user, l10n),
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
                        Navigator.of(context).pop();
                        final itemType = item['type'] as String;
                        switch (itemType) {
                          case 'tab':
                            if (tabsRouter != null) {
                              final tabIndex = item['tabIndex'] as int;
                              tabsRouter.setActiveIndex(tabIndex);
                            } else {
                              context.router.push(const UserTabRoute());
                            }
                            break;
                          case 'route':
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
                ],
              ),
            ),
            _buildStickyLanguageSelector(context, ref, l10n),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildAuthButton(context, ref, isAuthenticated, l10n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, User? user, L10n l10n) {
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
                  imageUrl:
                      'https://i.pinimg.com/1200x/02/fd/cf/02fdcf30afcfd72937d0cc7f14c34240.jpg',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircleAvatar(
                    backgroundColor: context.colorScheme.primary.withValues(
                      alpha: 0.1,
                    ),
                    child: const CupertinoActivityIndicator(),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: context.colorScheme.primary.withValues(
                      alpha: 0.3,
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
                      user?.fullName ?? l10n.drawerGuestUser,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user?.email ?? l10n.drawerGuestLoginPrompt,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.textTheme.bodyMedium?.color?.withValues(
                          alpha: 0.7,
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
    WidgetRef ref,
    bool isAuthenticated,
    L10n l10n,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        if (isAuthenticated) {
          _showLogoutDialog(context, ref, l10n);
        } else {
          Navigator.of(context).pop();
          context.router.push(const LoginRoute());
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

  void _showLogoutDialog(BuildContext context, WidgetRef ref, L10n l10n) {
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
                ref.read(authNotifierProvider.notifier).logout(NoParams());
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
    final inactiveColor = context.colorScheme.onSurface.withValues(alpha: 0.7);
    final displayIcon = isActive && selectedIcon != null ? selectedIcon : icon;

    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: CupertinoListTile(
          backgroundColor: isActive ? activeColor.withValues(alpha: 0.1) : null,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          leading: Icon(
            displayIcon,
            color: isActive ? activeColor : inactiveColor,
            size: 24,
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

    return Container(
      margin: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        top: 2.0,
        bottom: 2.0,
      ),
      child: Card(
        color: isActive
            ? activeColor.withValues(alpha: 0.1)
            : context.theme.cardColor,
        elevation: 0,
        child: ListTile(
          leading: Icon(
            displayIcon,
            color: isActive ? activeColor : inactiveColor,
            size: 24,
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
      ),
    );
  }

  Widget _buildStickyLanguageSelector(
    BuildContext context,
    WidgetRef ref,
    L10n l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.translate,
              color: context.colorScheme.primary,
              size: 20,
            ),
          ),
          title: Text(
            l10n.drawerItemLanguage,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          onTap: () {
            _showLanguageDialog(context, ref, l10n);
          },
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref, L10n l10n) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            l10n.dialogTitleSelectLanguage,
            style: context.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 16,
                  child: Text('🇺🇸', style: TextStyle(fontSize: 16)),
                ),
                title: const Text('English'),
                onTap: () {
                  ref
                      .read(localeProvider.notifier)
                      .changeLocale(const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  radius: 16,
                  child: Text('🇯🇵', style: TextStyle(fontSize: 16)),
                ),
                title: const Text('日本語 (Japanese)'),
                onTap: () {
                  ref
                      .read(localeProvider.notifier)
                      .changeLocale(const Locale('ja'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
