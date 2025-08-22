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

class AdminEndDrawer extends ConsumerWidget {
  const AdminEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      // Cek apakah user baru saja logout (dari ada user menjadi tidak ada user)
      final wasUserPresent = previous?.user != null;
      final isUserAbsent = next.user == null;

      // Tambahkan pengecekan agar tidak terpanggil saat inisialisasi awal
      final wasNotInitial = previous?.status != AuthStatus.initial;

      if (wasUserPresent && isUserAbsent && wasNotInitial) {
        // Pastikan context masih valid sebelum navigasi
        if (context.mounted) {
          // Gunakan WidgetsBinding untuk delay navigasi setelah frame selesai
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.router.pushAndPopUntil(
                const UserTabRoute(),
                predicate: (_) => false,
              );
              context.router.push(const LoginRoute());
            }
          });
        }
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

    final List<Map<String, dynamic>> adminDrawerItems = [
      {
        'icon': Icons.dashboard_outlined,
        'selectedIcon': Icons.dashboard,
        'title': l10n.adminBottomNavDashboard,
        'isActive': currentTabIndex == 0,
        'type': 'tab',
        'tabIndex': 0,
      },
      {
        'icon': Icons.calendar_today_outlined,
        'selectedIcon': Icons.calendar_today,
        'title': l10n.adminBottomNavCalendar,
        'isActive': currentTabIndex == 1,
        'type': 'tab',
        'tabIndex': 1,
      },
      {
        'icon': Icons.campaign_outlined,
        'selectedIcon': Icons.campaign,
        'title': l10n.adminBottomNavAnnouncements,
        'isActive': currentTabIndex == 2,
        'type': 'tab',
        'tabIndex': 2,
      },
      {
        'icon': Icons.event_available_outlined,
        'selectedIcon': Icons.event_available,
        'title': l10n.adminDrawerItemAvailability,
        'isActive': false,
        'type': 'route',
        'route': const AdminListAvailabilityRoute(),
      },
      {
        'icon': Icons.block_outlined,
        'selectedIcon': Icons.block,
        'title': l10n.adminDrawerItemBlocked,
        'isActive': false,
        'type': 'route',
        'route': const AdminListBlockedRoute(),
      },
      {
        'icon': Icons.business_outlined,
        'selectedIcon': Icons.business,
        'title': l10n.adminDrawerItemBusinessInformation,
        'isActive': false,
        'type': 'route',
        'route': const AdminListBussinessInformationRoute(),
      },
      {
        'icon': Icons.contact_page_outlined,
        'selectedIcon': Icons.contact_page,
        'title': l10n.adminDrawerItemContact,
        'isActive': false,
        'type': 'route',
        'route': const AdminListContactRoute(),
      },
      {
        'icon': Icons.people_alt_outlined,
        'selectedIcon': Icons.people_alt,
        'title': l10n.adminDrawerItemCustomerManagement,
        'isActive': false,
        'type': 'route',
        'route': const AdminListCustomerManagementRoute(),
      },
      {
        'icon': Icons.menu_book_outlined,
        'selectedIcon': Icons.menu_book,
        'title': l10n.adminDrawerItemMenu,
        'isActive': false,
        'type': 'route',
        'route': const AdminListMenuRoute(),
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
                  ...adminDrawerItems.map((item) {
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
                              context.router.push(const AdminTabRoute());
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
                  _buildLanguageSelector(context, ref, l10n),
                ],
              ),
            ),
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
                l10n.adminDrawerHeaderTitle,
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
                Navigator.of(context).pop();
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
      color: isActive
          ? activeColor.withValues(alpha: 0.1)
          : context.theme.cardColor,
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
