import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/blocked_period/presentation/widgets/blocked_period_filter_search.dart';
import 'package:tires/features/blocked_period/presentation/widgets/blocked_period_table_widget.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_periods_state.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_providers.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_statistics_state.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

@RoutePage()
class AdminListBlockedPeriodScreen extends ConsumerStatefulWidget {
  const AdminListBlockedPeriodScreen({super.key});

  @override
  ConsumerState<AdminListBlockedPeriodScreen> createState() =>
      _AdminListBlockedPeriodScreenState();
}

class _AdminListBlockedPeriodScreenState
    extends ConsumerState<AdminListBlockedPeriodScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isFilterVisible = true;

  Future<void> _refreshBlockedPeriods() async {
    // Save the form first to ensure all values are captured
    _formKey.currentState?.save();

    final formValues = _formKey.currentState?.value;
    final searchQuery = formValues?['search'] as String?;
    final selectedStatus = formValues?['status'] as String?;
    final startDate = formValues?['start_date'] as DateTime?;
    final endDate = formValues?['end_date'] as DateTime?;
    final allMenus = formValues?['all_menus'] as bool?;

    await ref
        .read(blockedPeriodGetNotifierProvider.notifier)
        .getBlockedPeriods(
          search: searchQuery,
          status: selectedStatus,
          startDate: startDate,
          endDate: endDate,
          allMenus: allMenus,
        );
    await ref.read(blockedPeriodStatisticsNotifierProvider.notifier).refresh();
  }

  void _applyFilters() {
    // Save the form first to ensure all values are captured
    _formKey.currentState?.save();

    final formValues = _formKey.currentState?.value;
    final searchQuery = formValues?['search'] as String?;
    final selectedStatus = formValues?['status'] as String?;
    final startDate = formValues?['start_date'] as DateTime?;
    final endDate = formValues?['end_date'] as DateTime?;
    final allMenus = formValues?['all_menus'] as bool?;

    ref
        .read(blockedPeriodGetNotifierProvider.notifier)
        .getBlockedPeriods(
          search: searchQuery,
          status: selectedStatus,
          startDate: startDate,
          endDate: endDate,
          allMenus: allMenus,
        );
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    ref.read(blockedPeriodGetNotifierProvider.notifier).getBlockedPeriods();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(blockedPeriodGetNotifierProvider);
    final statisticsState = ref.watch(blockedPeriodStatisticsNotifierProvider);

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshBlockedPeriods,
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
                child: BlockedPeriodFilterSearch(
                  formKey: _formKey,
                  isFilterVisible: _isFilterVisible,
                  menus: const [], // TODO: Add menu provider
                  onToggleVisibility: () =>
                      setState(() => _isFilterVisible = !_isFilterVisible),
                  onFilter: _applyFilters,
                  onReset: _resetFilters,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: BlockedPeriodTableWidget(
                  blockedPeriods: state.blockedPeriods,
                  isLoading: state.status == BlockedPeriodsStatus.loading,
                  onRefresh: _refreshBlockedPeriods,
                  currentPage: 1, // TODO: Add pagination logic
                  totalPages: 1, // TODO: Add pagination logic
                  onPageChanged: (page) {
                    // TODO: Implement pagination
                  },
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
            context.l10n.adminListBlockedPeriodScreenPageTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.adminListBlockedPeriodScreenPageSubtitle,
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: context.l10n.adminListBlockedPeriodScreenAddButton,
            leadingIcon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(AdminUpsertBlockedPeriodRoute());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(
    BuildContext context,
    BlockedPeriodsState state,
    BlockedPeriodStatisticsState statisticsState,
  ) {
    if (statisticsState.status == BlockedPeriodStatisticsStatus.loading) {
      return const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (statisticsState.status == BlockedPeriodStatisticsStatus.error) {
      return SizedBox(
        height: 120,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 32),
              const SizedBox(height: 8),
              Text(
                statisticsState.errorMessage ??
                    context.l10n.adminListBlockedPeriodScreenStatsErrorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(blockedPeriodStatisticsNotifierProvider.notifier)
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
      return SizedBox(
        height: 80,
        child: Center(
          child: Text(
            context.l10n.adminListBlockedPeriodScreenStatsNoDataMessage,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatTile(
          title: context.l10n.adminListBlockedPeriodScreenStatsTotal,
          value: '${statistics.total}',
          icon: Icons.block,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListBlockedPeriodScreenStatsActive,
          value: '${statistics.active}',
          icon: Icons.schedule,
          color: Colors.orange.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListBlockedPeriodScreenStatsUpcoming,
          value: '${statistics.upcoming}',
          icon: Icons.upcoming,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListBlockedPeriodScreenStatsExpired,
          value: '${statistics.expired}',
          icon: Icons.history,
          color: Colors.grey.shade100,
        ),
      ],
    );
  }
}
