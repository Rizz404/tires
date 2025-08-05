import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class UserTabScreen extends StatelessWidget {
  const UserTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return const UserAppBar();
      },
      endDrawer: const UserEndDrawer(),
      routes: const [HomeRoute(), ListReservationRoute(), ProfileRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: (index) {
            tabsRouter.setActiveIndex(index);
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: context.l10n.bottomNavHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.dinner_dining_outlined),
              selectedIcon: const Icon(Icons.dinner_dining),
              label: context.l10n.bottomNavReservations,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outlined),
              selectedIcon: const Icon(Icons.person),
              label: context.l10n.bottomNavProfile,
            ),
          ],
        );
      },
    );
  }
}
