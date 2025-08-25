import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/authentication/presentation/providers/auth_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class UserTabScreen extends ConsumerStatefulWidget {
  const UserTabScreen({super.key});

  @override
  ConsumerState<UserTabScreen> createState() => _UserTabScreenState();
}

class _UserTabScreenState extends ConsumerState<UserTabScreen> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      final wasAuthenticated = previous?.status == AuthStatus.authenticated;
      final isNowUnauthenticated = next.status == AuthStatus.unauthenticated;

      if (wasAuthenticated && isNowUnauthenticated) {
        // This ensures we only navigate on actual logout.
        context.router.replaceAll([const LoginRoute()]);
      }
    });

    return AutoTabsRouter(
      routes: const [HomeRoute(), MyReservationsRoute(), ProfileRoute()],
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
            appBar: const UserAppBar(),
            endDrawer: const UserEndDrawer(),
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: tabsRouter.activeIndex,
              onDestinationSelected: (index) {
                if (index == 0) {
                  tabsRouter.setActiveIndex(index);
                  return;
                }

                if (index == 1 || index == 2) {
                  if (authState.status == AuthStatus.authenticated) {
                    tabsRouter.setActiveIndex(index);
                  } else {
                    AutoRouter.of(context).push(const LoginRoute());
                  }
                }
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: context.l10n.userBottomNavHome,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.dinner_dining_outlined),
                  selectedIcon: const Icon(Icons.dinner_dining),
                  label: context.l10n.userBottomNavReservations,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person_outlined),
                  selectedIcon: const Icon(Icons.person),
                  label: context.l10n.userBottomNavProfile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
