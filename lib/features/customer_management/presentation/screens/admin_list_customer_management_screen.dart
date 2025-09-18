import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/customer_management/presentation/widgets/customer_table_widget.dart';
import 'package:tires/features/user/presentation/providers/users_providers.dart';
import 'package:tires/features/user/presentation/providers/users_state.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_providers.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_statistics_state.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_search_field.dart';
import 'package:tires/shared/presentation/widgets/app_dropdown.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersNotifierProvider.notifier).refresh();
      ref.read(customerStatisticsNotifierProvider.notifier).refresh();
    });
  }

  Future<void> _refreshUsers() async {
    await Future.wait([
      ref.read(usersNotifierProvider.notifier).refresh(),
      ref.read(customerStatisticsNotifierProvider.notifier).refresh(),
    ]);
  }

  void _applyFilters() {
    setState(() {});
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(usersNotifierProvider);
    final statisticsState = ref.watch(customerStatisticsNotifierProvider);

    final formValues = _formKey.currentState?.value;
    List<User> filteredUsers = usersState.users;

    if (formValues != null) {
      final searchQuery = formValues['search'] as String? ?? '';
      final selectedStatus = formValues['status'] as String? ?? 'all';

      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        filteredUsers = filteredUsers.where((user) {
          return user.fullName.toLowerCase().contains(query) ||
              user.email.toLowerCase().contains(query) ||
              user.phoneNumber.toLowerCase().contains(query);
        }).toList();
      }

      if (selectedStatus != 'all') {
        filteredUsers = filteredUsers.where((user) {
          switch (selectedStatus) {
            case 'first_time':
              return user.id % 5 == 0; // Mock: every 5th user is first time
            case 'repeat':
              return user.id % 3 == 0; // Mock: every 3rd user is repeat
            case 'dormant':
              return user.id % 8 == 0; // Mock: every 8th user is dormant
            default:
              return true;
          }
        }).toList();
      }
    }

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshUsers,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: _buildStatsCards(context, usersState, statisticsState),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: _buildFilters(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: CustomerTableWidget(
                  customers: filteredUsers,
                  isLoading: usersState.status == UsersStatus.loading,
                  onRefresh: _refreshUsers,
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
    UsersState usersState,
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          StatTile(
            title: "Total Customers",
            value: statistics.totalCustomers.toString(),
            icon: Icons.people,
            color: Colors.blue,
          ),
          const SizedBox(width: 16),
          StatTile(
            title: context.l10n.adminListCustomerManagementStatsFirstTime,
            value: statistics.firstTime.toString(),
            icon: Icons.person_add,
            color: Colors.green,
          ),
          const SizedBox(width: 16),
          StatTile(
            title: context.l10n.adminListCustomerManagementStatsRepeat,
            value: statistics.repeat.toString(),
            icon: Icons.repeat,
            color: Colors.orange,
          ),
          const SizedBox(width: 16),
          StatTile(
            title: context.l10n.adminListCustomerManagementStatsDormant,
            value: statistics.dormant.toString(),
            icon: Icons.person_off,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: AppSearchField(
                  name: 'search',
                  hintText: context
                      .l10n
                      .adminListCustomerManagementFiltersSearchPlaceholder,
                  onChanged: (value) => _applyFilters(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: AppDropdown<String>(
                  name: 'status',
                  hintText: 'Customer Status',
                  initialValue: 'all',
                  items: [
                    AppDropdownItem(
                      value: 'all',
                      label: context
                          .l10n
                          .adminListCustomerManagementFiltersAllTypes,
                    ),
                    AppDropdownItem(
                      value: 'first_time',
                      label: context
                          .l10n
                          .adminListCustomerManagementFiltersFirstTime,
                    ),
                    AppDropdownItem(
                      value: 'repeat',
                      label:
                          context.l10n.adminListCustomerManagementFiltersRepeat,
                    ),
                    AppDropdownItem(
                      value: 'dormant',
                      label: context
                          .l10n
                          .adminListCustomerManagementFiltersDormant,
                    ),
                  ],
                  onChanged: (value) => _applyFilters(),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _resetFilters,
                child: Text(
                  context.l10n.adminListCustomerManagementFiltersReset,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
