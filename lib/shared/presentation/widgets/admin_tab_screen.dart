import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/authentication/presentation/providers/auth_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';

@RoutePage()
class AdminTabScreen extends ConsumerStatefulWidget {
  const AdminTabScreen({super.key});

  @override
  ConsumerState<AdminTabScreen> createState() => _AdminTabScreenState();
}

class _AdminTabScreenState extends ConsumerState<AdminTabScreen> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated) {
        context.router.replaceAll([const LoginRoute()]);
      }
    });

    if (authState.status == AuthStatus.loading ||
        authState.status == AuthStatus.initial) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (authState.status == AuthStatus.authenticated) {
      return AutoTabsRouter(
        routes: const [
          AdminDashboardRoute(),
          AdminListCalendarRoute(),
          AdminListAnnouncementRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) return;

              if (tabsRouter.activeIndex != 0) {
                tabsRouter.setActiveIndex(0);
                return;
              }

              final now = DateTime.now();
              final backButtonHasNotBeenPressedOrWasLongAgo =
                  _lastPressedAt == null ||
                  now.difference(_lastPressedAt!) > const Duration(seconds: 2);

              if (backButtonHasNotBeenPressedOrWasLongAgo) {
                _lastPressedAt = now;
                AppToast.showInfo(
                  context,
                  message: context.l10n.pressAgainToExit,
                );
                return;
              }

              SystemNavigator.pop();
            },
            child: Scaffold(
              appBar: const AdminAppBar(),
              endDrawer: const AdminEndDrawer(),
              body: child,
              bottomNavigationBar: NavigationBar(
                selectedIndex: tabsRouter.activeIndex,
                onDestinationSelected: (index) {
                  tabsRouter.setActiveIndex(index);
                },
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.dashboard_outlined),
                    selectedIcon: const Icon(Icons.dashboard),
                    label: context.l10n.adminBottomNavDashboard,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.calendar_today_outlined),
                    selectedIcon: const Icon(Icons.calendar_today),
                    label: context.l10n.adminBottomNavCalendar,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.campaign_outlined),
                    selectedIcon: const Icon(Icons.campaign),
                    label: context.l10n.adminBottomNavAnnouncements,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return const Scaffold(body: Center(child: Text('Redirecting...')));
  }
}
