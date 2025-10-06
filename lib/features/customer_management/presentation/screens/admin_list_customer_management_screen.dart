import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/customer_management/presentation/widgets/customer_table_widget.dart';
import 'package:tires/features/customer_management/presentation/widgets/customer_filter_search.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_providers.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_state.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_statistics_state.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

@RoutePage()
class AdminListCustomerManagementScreen extends ConsumerStatefulWidget {
  const AdminListCustomerManagementScreen({super.key});

  @override
  ConsumerState<AdminListCustomerManagementScreen> createState() =>
      _AdminListCustomerManagementScreenState();
}

class _AdminListCustomerManagementScreenState
    extends ConsumerState<AdminListCustomerManagementScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isFilterVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(customersNotifierProvider.notifier).refresh();
      ref.read(customerStatisticsNotifierProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _formKey.currentState?.fields.forEach((key, field) {
      field.dispose();
    });
    super.dispose();
  }

  Future<void> _refreshCustomers() async {
    await Future.wait([
      ref.read(customersNotifierProvider.notifier).refresh(),
      ref.read(customerStatisticsNotifierProvider.notifier).refresh(),
    ]);
  }

  Future<void> _applyFilters() async {
    final formValues = _formKey.currentState?.value ?? {};

    final searchQuery = formValues['search'] as String?;
    final selectedStatus = formValues['status'] as String?;

    await ref
        .read(customersNotifierProvider.notifier)
        .getInitialCustomers(
          search: searchQuery?.isNotEmpty == true ? searchQuery : null,
          status: selectedStatus != 'all' ? selectedStatus : null,
        );
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    _applyFilters();
  }

  void _toggleFilterVisibility() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final customersState = ref.watch(customersNotifierProvider);
    final statisticsState = ref.watch(customerStatisticsNotifierProvider);

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshCustomers,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: _buildStatsCards(
                  context,
                  customersState,
                  statisticsState,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: _buildFilters(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: CustomerTableWidget(
                  customers: customersState.customers,
                  isLoading: customersState.status == CustomersStatus.loading,
                  isLoadingMore:
                      customersState.status == CustomersStatus.loadingMore,
                  hasNextPage: customersState.hasNextPage,
                  onRefresh: _refreshCustomers,
                  onLoadMore: () {
                    final formValues = _formKey.currentState?.value ?? {};
                    final searchQuery = formValues['search'] as String?;
                    final selectedStatus = formValues['status'] as String?;

                    ref
                        .read(customersNotifierProvider.notifier)
                        .loadMore(
                          search: searchQuery?.isNotEmpty == true
                              ? searchQuery
                              : null,
                          status: selectedStatus != 'all'
                              ? selectedStatus
                              : null,
                        );
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
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            context.l10n.adminListCustomerManagementTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.adminListCustomerManagementDescription,
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(
    BuildContext context,
    CustomersState customersState,
    CustomerStatisticsState statisticsState,
  ) {
    if (statisticsState.status == CustomerStatisticsStatus.loading) {
      return const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (statisticsState.status == CustomerStatisticsStatus.error) {
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
                      .read(customerStatisticsNotifierProvider.notifier)
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
          title: "Total Customers",
          value: statistics.totalCustomers.toString(),
          icon: Icons.people,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListCustomerManagementStatsFirstTime,
          value: statistics.statistics.firstTime.toString(),
          icon: Icons.person_add,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListCustomerManagementStatsRepeat,
          value: statistics.statistics.repeat.toString(),
          icon: Icons.repeat,
          color: Colors.orange.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListCustomerManagementStatsDormant,
          value: statistics.statistics.dormant.toString(),
          icon: Icons.person_off,
          color: Colors.red.shade100,
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context) {
    return CustomerFilterSearch(
      formKey: _formKey,
      isFilterVisible: _isFilterVisible,
      onToggleVisibility: _toggleFilterVisibility,
      onFilter: _applyFilters,
      onReset: _resetFilters,
    );
  }
}
