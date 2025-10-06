import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:tires/features/dashboard/presentation/providers/dashboard_state.dart';
import 'package:tires/features/dashboard/presentation/widgets/announcements_section.dart';
import 'package:tires/features/dashboard/presentation/widgets/contact_section.dart';
import 'package:tires/features/dashboard/presentation/widgets/status_section.dart';
import 'package:tires/features/dashboard/presentation/widgets/today_reservations_section.dart';
import 'package:tires/features/dashboard/presentation/widgets/todo_section.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardNotifierProvider);

    return Scaffold(
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(child: _buildBody(context, dashboardState)),
    );
  }

  Widget _buildBody(BuildContext context, DashboardState dashboardState) {
    if (dashboardState.status == DashboardStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (dashboardState.status == DashboardStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              'Error: ${dashboardState.errorMessage}',
              style: AppTextStyle.bodyMedium,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(dashboardNotifierProvider.notifier).refreshDashboard();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (dashboardState.dashboard == null) {
      return const Center(child: Text('No data available'));
    }

    final dashboard = dashboardState.dashboard!;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(dashboardNotifierProvider.notifier).refreshDashboard();
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Announcements Section
          SliverToBoxAdapter(
            child: AnnouncementsSection(
              announcements: dashboard.announcements,
              onPressed: () {},
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // To Do Section
          SliverToBoxAdapter(child: ToDoSection(dashboard: dashboard)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Contact Section
          SliverToBoxAdapter(
            child: ContactSection(contacts: dashboard.pendingContacts),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Today's Reservations Section
          SliverToBoxAdapter(
            child: TodayReservationsSection(
              todayReservations: dashboard.todayReservations,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Status Section
          SliverToBoxAdapter(child: StatusSection(dashboard: dashboard)),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
