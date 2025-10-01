import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/menu/presentation/widgets/menu_filter_search.dart';
import 'package:tires/features/menu/presentation/widgets/menu_table_widget.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_statistics_state.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

@RoutePage()
class AdminListMenuScreen extends ConsumerStatefulWidget {
  const AdminListMenuScreen({super.key});

  @override
  ConsumerState<AdminListMenuScreen> createState() =>
      _AdminListMenuScreenState();
}

class _AdminListMenuScreenState extends ConsumerState<AdminListMenuScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isFilterVisible = true;

  Future<void> _refreshMenus() async {
    final formValues = _formKey.currentState?.value;
    if (formValues != null) {
      await _applyFilters();
    } else {
      await ref.read(adminMenuGetNotifierProvider.notifier).refresh();
    }
    await ref.read(menuStatisticsNotifierProvider.notifier).refresh();
  }

  Future<void> _loadMoreMenus() async {
    final formValues = _formKey.currentState?.value ?? {};

    final searchQuery = formValues['search'] as String?;
    final selectedStatus = formValues['status'] as String?;
    final minPriceStr = formValues['min_price'] as String?;
    final maxPriceStr = formValues['max_price'] as String?;

    final minPrice = minPriceStr != null && minPriceStr.isNotEmpty
        ? double.tryParse(minPriceStr)
        : null;
    final maxPrice = maxPriceStr != null && maxPriceStr.isNotEmpty
        ? double.tryParse(maxPriceStr)
        : null;

    await ref
        .read(adminMenuGetNotifierProvider.notifier)
        .loadMore(
          search: searchQuery?.isNotEmpty == true ? searchQuery : null,
          status: selectedStatus != 'all' ? selectedStatus : null,
          minPrice: minPrice,
          maxPrice: maxPrice,
        );
  }

  Future<void> _applyFilters() async {
    final formValues = _formKey.currentState?.value ?? {};

    final searchQuery = formValues['search'] as String?;
    final selectedStatus = formValues['status'] as String?;
    final minPriceStr = formValues['min_price'] as String?;
    final maxPriceStr = formValues['max_price'] as String?;

    final minPrice = minPriceStr != null && minPriceStr.isNotEmpty
        ? double.tryParse(minPriceStr)
        : null;
    final maxPrice = maxPriceStr != null && maxPriceStr.isNotEmpty
        ? double.tryParse(maxPriceStr)
        : null;

    await ref
        .read(adminMenuGetNotifierProvider.notifier)
        .getInitialAdminMenus(
          search: searchQuery?.isNotEmpty == true ? searchQuery : null,
          status: selectedStatus != 'all' ? selectedStatus : null,
          minPrice: minPrice,
          maxPrice: maxPrice,
        );
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    _applyFilters(); // Apply filters after reset to fetch all data
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminMenuGetNotifierProvider);
    final statisticsState = ref.watch(menuStatisticsNotifierProvider);

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshMenus,
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
                child: MenuFilterSearch(
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
                child: MenuTableWidget(
                  menus: state.menus,
                  isLoading: state.status == AdminMenusStatus.loading,
                  isLoadingMore: state.status == AdminMenusStatus.loadingMore,
                  hasNextPage: state.hasNextPage,
                  onRefresh: _refreshMenus,
                  onLoadMore: _loadMoreMenus,
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
            context.l10n.adminListMenuScreenTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.adminListMenuScreenSubtitle,
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: context.l10n.adminListMenuScreenAddMenu,
            leadingIcon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(AdminUpsertMenuRoute());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(
    BuildContext context,
    AdminMenusState state,
    MenuStatisticsState statisticsState,
  ) {
    if (statisticsState.status == MenuStatisticsStatus.loading) {
      return const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (statisticsState.status == MenuStatisticsStatus.error) {
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
                  ref.read(menuStatisticsNotifierProvider.notifier).refresh();
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

    final formatCurrency = NumberFormat.currency(
      locale: 'ja_JP',
      symbol: '¥',
      decimalDigits: 0,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatTile(
          title: context.l10n.adminListMenuScreenTotalMenus,
          value: '${statistics.statistics.totalMenus}',
          icon: Icons.restaurant_menu,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListMenuScreenActive,
          value: '${statistics.statistics.activeMenus}',
          icon: Icons.check_circle,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListMenuScreenInactive,
          value: '${statistics.statistics.inactiveMenus}',
          icon: Icons.cancel,
          color: Colors.red.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListMenuScreenAveragePrice,
          value: formatCurrency.format(statistics.statistics.averagePrice),
          icon: Icons.price_check,
          color: Colors.purple.shade100,
        ),
      ],
    );
  }
}
