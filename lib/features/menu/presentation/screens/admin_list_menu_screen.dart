import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/presentation/widgets/menu_filter_search.dart';
import 'package:tires/features/menu/presentation/widgets/menu_table_widget.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

@RoutePage()
class AdminListMenuScreen extends StatefulWidget {
  const AdminListMenuScreen({super.key});

  @override
  State<AdminListMenuScreen> createState() => _AdminListMenuScreenState();
}

class _AdminListMenuScreenState extends State<AdminListMenuScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _isFilterVisible = true;

  List<Menu> _menus = [];
  List<Menu> _filteredMenus = [];

  @override
  void initState() {
    super.initState();
    _loadMockMenus();
  }

  void _loadMockMenus() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _menus = _generateMockMenus();
          _applyFilters();
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _refreshMenus() async {
    setState(() {
      _menus.clear();
      _filteredMenus.clear();
    });
    _loadMockMenus();
  }

  void _applyFilters() {
    final formValues = _formKey.currentState?.value;
    if (formValues == null) {
      if (mounted) {
        setState(() {
          _filteredMenus = List.from(_menus);
        });
      }
      return;
    }

    final searchQuery = formValues['search'] as String? ?? '';
    final selectedStatus = formValues['status'] as String? ?? 'all';
    final minPriceStr = formValues['min_price'] as String?;
    final maxPriceStr = formValues['max_price'] as String?;

    final minPrice = minPriceStr != null ? double.tryParse(minPriceStr) : null;
    final maxPrice = maxPriceStr != null ? double.tryParse(maxPriceStr) : null;

    List<Menu> filtered = List.from(_menus);

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((menu) {
        final nameMatch = menu.name.toLowerCase().contains(query);
        final descMatch =
            menu.description?.toLowerCase().contains(query) ?? false;
        return nameMatch || descMatch;
      }).toList();
    }

    if (selectedStatus != 'all') {
      final isActive = selectedStatus == 'active';
      filtered = filtered.where((menu) => menu.isActive == isActive).toList();
    }

    if (minPrice != null) {
      filtered = filtered
          .where((menu) => double.parse(menu.price.amount) >= minPrice)
          .toList();
    }

    if (maxPrice != null) {
      filtered = filtered
          .where((menu) => double.parse(menu.price.amount) <= maxPrice)
          .toList();
    }

    setState(() => _filteredMenus = filtered);
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
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
              SliverToBoxAdapter(child: _buildStatsCards()),
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
                  menus: _filteredMenus,
                  isLoading: _isLoading,
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
          const AppText(
            'Menu Management',
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            'Manage service menus for customers',
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: 'Add Menu',
            leadingIcon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final total = _menus.length;
    final active = _menus.where((a) => a.isActive).length;
    final inactive = total - active;

    final double averagePrice = total > 0
        ? _menus
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
          title: 'Total Menus',
          value: '$total',
          icon: Icons.restaurant_menu,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Active',
          value: '$active',
          icon: Icons.check_circle,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Inactive',
          value: '$inactive',
          icon: Icons.cancel,
          color: Colors.red.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Average Price',
          value: formatCurrency.format(averagePrice),
          icon: Icons.price_check,
          color: Colors.purple.shade100,
        ),
      ],
    );
  }

  List<Menu> _generateMockMenus() {
    final mockData = [
      {
        'id': 1,
        'name': 'Installation of tires purchased at our store',
        'desc': 'Professional installation of tires purchased here.',
        'price': 15000,
        'time': 60,
        'active': true,
        'color': '#4285F4',
      },
      {
        'id': 2,
        'name': 'Sushi Set',
        'desc': 'Enjoy our assorted sushi with fresh ingredients.',
        'price': 2500,
        'time': 20,
        'active': true,
        'color': '#DB4437',
      },
      {
        'id': 3,
        'name': 'Replacement and installation of tires brought in',
        'desc': 'Installation of tires shipped directly to our store.',
        'price': 20000,
        'time': 75,
        'active': true,
        'color': '#0F9D58',
      },
      {
        'id': 4,
        'name': 'Oil change',
        'desc': 'Complete oil change service for your vehicle.',
        'price': 5000,
        'time': 30,
        'active': false,
        'color': '#F4B400',
      },
      {
        'id': 5,
        'name': 'Tire storage and tire replacement at the store',
        'desc': 'Tire storage service and replacement.',
        'price': 8000,
        'time': 45,
        'active': true,
        'color': '#AB47BC',
      },
      {
        'id': 6,
        'name': 'Change tires by bringing your own',
        'desc': 'Tire changing service for customer-provided tires.',
        'price': 18000,
        'time': 70,
        'active': true,
        'color': '#00ACC1',
      },
    ];

    return mockData.map((data) {
      final priceAmount = (data['price'] as int).toString();
      final format = NumberFormat.currency(
        locale: 'ja_JP',
        symbol: '¥',
        decimalDigits: 0,
      );

      return Menu(
        id: data['id'] as int,
        name: data['name'] as String,
        description: data['desc'] as String,
        requiredTime: data['time'] as int,
        price: Price(
          amount: priceAmount,
          formatted: format.format(data['price']),
          currency: 'JPY',
        ),
        displayOrder: data['id'] as int,
        isActive: data['active'] as bool,
        color: ColorInfo(
          hex: data['color'] as String,
          rgbaLight: '',
          textColor: '',
        ),
      );
    }).toList();
  }
}
