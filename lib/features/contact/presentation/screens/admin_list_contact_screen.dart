import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/contact/presentation/widgets/contact_filter_search.dart';
import 'package:tires/features/contact/presentation/widgets/contact_table_widget.dart';
import 'package:tires/features/contact/presentation/providers/contacts_state.dart';
import 'package:tires/features/contact/presentation/providers/contact_providers.dart';
import 'package:tires/features/contact/presentation/providers/contact_statistics_state.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

@RoutePage()
class AdminListContactScreen extends ConsumerStatefulWidget {
  const AdminListContactScreen({super.key});

  @override
  ConsumerState<AdminListContactScreen> createState() =>
      _AdminListContactScreenState();
}

class _AdminListContactScreenState
    extends ConsumerState<AdminListContactScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isFilterVisible = true;

  Future<void> _refreshContacts() async {
    // Save the form first to ensure all values are captured
    _formKey.currentState?.save();

    final formValues = _formKey.currentState?.value;
    final searchQuery = formValues?['search'] as String?;
    final selectedStatus = formValues?['status'] as String?;

    await ref
        .read(contactGetNotifierProvider.notifier)
        .refresh(search: searchQuery, status: selectedStatus);
    await ref.read(contactStatisticsNotifierProvider.notifier).refresh();
  }

  void _applyFilters() {
    // Save the form first to ensure all values are captured
    _formKey.currentState?.save();

    final formValues = _formKey.currentState?.value;
    final searchQuery = formValues?['search'] as String?;
    final selectedStatus = formValues?['status'] as String?;

    ref
        .read(contactGetNotifierProvider.notifier)
        .getContacts(search: searchQuery, status: selectedStatus);
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    ref.read(contactGetNotifierProvider.notifier).getContacts();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(contactGetNotifierProvider);
    final statisticsState = ref.watch(contactStatisticsNotifierProvider);

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshContacts,
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
                child: ContactFilterSearch(
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
                child: ContactTableWidget(
                  contacts: state.contacts,
                  isLoading: state.status == ContactsStatus.loading,
                  onRefresh: _refreshContacts,
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
            context.l10n.adminListContactScreenPageTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.adminListContactScreenPageSubtitle,
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: context.l10n.adminListContactScreenAddButton,
            leadingIcon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(AdminUpsertContactRoute());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(
    BuildContext context,
    ContactsState state,
    ContactStatisticsState statisticsState,
  ) {
    if (statisticsState.status == ContactStatisticsStatus.loading) {
      return const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (statisticsState.status == ContactStatisticsStatus.error) {
      debugPrint(statisticsState.errorMessage);
      return SizedBox(
        height: 120,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 32),
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
                      .read(contactStatisticsNotifierProvider.notifier)
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
          title: context.l10n.adminListContactScreenStatsTotal,
          value: '${statistics.statistics.total}',
          icon: Icons.contact_mail,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListContactScreenStatsPending,
          value: '${statistics.statistics.pending}',
          icon: Icons.pending,
          color: Colors.orange.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListContactScreenStatsReplied,
          value: '${statistics.statistics.replied}',
          icon: Icons.check_circle,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListContactScreenStatsToday,
          value: '${statistics.statistics.today}',
          icon: Icons.calendar_today,
          color: Colors.purple.shade100,
        ),
      ],
    );
  }
}
