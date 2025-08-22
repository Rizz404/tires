import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';

@RoutePage()
class AdminTabScreen extends StatelessWidget {
  const AdminTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return const AdminAppBar();
      },
      endDrawer: const AdminEndDrawer(),
      routes: const [
        AdminDashboardRoute(),
        AdminListCalendarRoute(),
        AdminListAnnouncementRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
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
        );
      },
    );
  }
}
