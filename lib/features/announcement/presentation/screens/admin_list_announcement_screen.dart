import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/announcement/presentation/widgets/announcement_filter_search.dart';
import 'package:tires/features/announcement/presentation/widgets/announcement_table_widget.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_providers.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_statistics_state.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

@RoutePage()
class AdminListAnnouncementScreen extends ConsumerStatefulWidget {
  const AdminListAnnouncementScreen({super.key});

  @override
  ConsumerState<AdminListAnnouncementScreen> createState() =>
      _AdminListAnnouncementScreenState();
}

class _AdminListAnnouncementScreenState
    extends ConsumerState<AdminListAnnouncementScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isFilterVisible = true;

  Future<void> _refreshAnnouncements() async {
    await ref.read(announcementGetNotifierProvider.notifier).refresh();
    await ref.read(announcementStatisticsNotifierProvider.notifier).refresh();
  }

  void _applyFilters() {
    setState(() {}); // Just trigger rebuild, filtering is done in build
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(announcementGetNotifierProvider);
    final statisticsState = ref.watch(announcementStatisticsNotifierProvider);
    final formValues = _formKey.currentState?.value;
    List<Announcement> filteredAnnouncements = state.announcements;
    if (formValues != null) {
      final searchQuery = formValues['search'] as String? ?? '';
      final selectedStatus = formValues['status'] as String? ?? 'all';
      final publishedAtFilter = formValues['published_at'] as DateTime?;

      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        filteredAnnouncements = filteredAnnouncements.where((ann) {
          return ann.title.toLowerCase().contains(query) ||
              ann.content.toLowerCase().contains(query);
        }).toList();
      }
      if (selectedStatus != 'all') {
        final isActive = selectedStatus == 'active';
        filteredAnnouncements = filteredAnnouncements
            .where((ann) => ann.isActive == isActive)
            .toList();
      }
      if (publishedAtFilter != null) {
        filteredAnnouncements = filteredAnnouncements
            .where(
              (ann) =>
                  ann.publishedAt != null &&
                  !ann.publishedAt!.isBefore(publishedAtFilter),
            )
            .toList();
      }
    }
    return Scaffold(
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshAnnouncements,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: _buildStatsCards(context, state, statisticsState),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: AnnouncementFilterSearch(
                  formKey: _formKey,
                  isFilterVisible: _isFilterVisible,
                  onToggleVisibility: () =>
                      setState(() => _isFilterVisible = !_isFilterVisible),
                  onFilter: _applyFilters,
                  onReset: _resetFilters,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: AnnouncementTableWidget(
                  announcements: filteredAnnouncements,
                  isLoading: state.status == AnnouncementsStatus.loading,
                  onRefresh: _refreshAnnouncements,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            context.l10n.adminListAnnouncementScreenTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.adminListAnnouncementScreenSubtitle,
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: context.l10n.adminListAnnouncementScreenAddButton,
            leadingIcon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(AdminUpsertAnnouncementRoute());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(
    BuildContext context,
    AnnouncementsState state,
    AnnouncementStatisticsState statisticsState,
  ) {
    if (statisticsState.status == AnnouncementStatisticsStatus.loading) {
      return const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (statisticsState.status == AnnouncementStatisticsStatus.error) {
      debugPrint(statisticsState.errorMessage);
      return SizedBox(
        height: 120,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 32),
              const SizedBox(height: 8),
              Text(
                statisticsState.errorMessage ?? 'Failed to load statistics',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(announcementStatisticsNotifierProvider.notifier)
                      .refresh();
                },
                child: const Text('Retry', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      );
    }

    final statistics = statisticsState.statistics;
    if (statistics == null) {
      return const SizedBox(
        height: 80,
        child: Center(
          child: Text(
            'No statistics available',
            style: TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatTile(
          title: context.l10n.adminListAnnouncementScreenStatsTotal,
          value: '${statistics.totalAnnouncements}',
          icon: Icons.volume_up,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListAnnouncementScreenStatsActive,
          value: '${statistics.active}',
          icon: Icons.check_circle,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListAnnouncementScreenStatsInactive,
          value: '${statistics.inactive}',
          icon: Icons.cancel,
          color: Colors.red.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListAnnouncementScreenStatsToday,
          value: '${statistics.today}',
          icon: Icons.calendar_today,
          color: Colors.purple.shade100,
        ),
      ],
    );
  }
}
