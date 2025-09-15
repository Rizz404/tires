import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/presentation/widgets/menu_filter_search.dart';
import 'package:tires/features/menu/presentation/widgets/menu_table_widget.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_state.dart';
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
    await ref.read(adminMenuGetNotifierProvider.notifier).refresh();
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
    final state = ref.watch(adminMenuGetNotifierProvider);
    final formValues = _formKey.currentState?.value;
    List<Menu> filteredMenus = state.menus;
    if (formValues != null) {
      final searchQuery = formValues['search'] as String? ?? '';
      final selectedStatus = formValues['status'] as String? ?? 'all';
      final minPriceStr = formValues['min_price'] as String?;
      final maxPriceStr = formValues['max_price'] as String?;

      final minPrice = minPriceStr != null
          ? double.tryParse(minPriceStr)
          : null;
      final maxPrice = maxPriceStr != null
          ? double.tryParse(maxPriceStr)
          : null;

      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        filteredMenus = filteredMenus.where((menu) {
          final nameMatch = menu.name.toLowerCase().contains(query);
          final descMatch =
              menu.description?.toLowerCase().contains(query) ?? false;
          return nameMatch || descMatch;
        }).toList();
      }
      if (selectedStatus != 'all') {
        final isActive = selectedStatus == 'active';
        filteredMenus = filteredMenus
            .where((menu) => menu.isActive == isActive)
            .toList();
      }
      if (minPrice != null) {
        filteredMenus = filteredMenus
            .where((menu) => double.parse(menu.price.amount) >= minPrice)
            .toList();
      }
      if (maxPrice != null) {
        filteredMenus = filteredMenus
            .where((menu) => double.parse(menu.price.amount) <= maxPrice)
            .toList();
      }
    }

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
              SliverToBoxAdapter(child: _buildStatsCards(context, state)),
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
                  menus: filteredMenus,
                  isLoading: state.status == AdminMenusStatus.loading,
                  onRefresh: _refreshMenus,
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

  Widget _buildStatsCards(BuildContext context, AdminMenusState state) {
    final total = state.menus.length;
    final active = state.menus.where((a) => a.isActive).length;
    final inactive = total - active;

    final double averagePrice = total > 0
        ? state.menus
                  .map((m) => double.tryParse(m.price.amount) ?? 0.0)
                  .reduce((a, b) => a + b) /
              total
        : 0.0;

    final formatCurrency = NumberFormat.currency(
      locale: 'ja_JP',
      symbol: '¥',
      decimalDigits: 0,
    );

    return Column(
      children: [
        StatTile(
          title: context.l10n.adminListMenuScreenTotalMenus,
          value: '$total',
          icon: Icons.restaurant_menu,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListMenuScreenActive,
          value: '$active',
          icon: Icons.check_circle,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListMenuScreenInactive,
          value: '$inactive',
          icon: Icons.cancel,
          color: Colors.red.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListMenuScreenAveragePrice,
          value: formatCurrency.format(averagePrice),
          icon: Icons.price_check,
          color: Colors.purple.shade100,
        ),
      ],
    );
  }
}
