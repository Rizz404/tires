import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/blocked/presentation/widgets/blocked_period_filter_search.dart';
import 'package:tires/features/blocked/presentation/widgets/blocked_period_table_widget.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/user/domain/entities/blocked_period.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'dart:math';

import 'package:tires/shared/presentation/widgets/stat_tile.dart';

// Todo: Nanti buat i18n juga dan benerin biar pake shared widget
@RoutePage()
class AdminListBlockedScreen extends StatefulWidget {
  const AdminListBlockedScreen({super.key});

  @override
  State<AdminListBlockedScreen> createState() => _AdminListBlockedScreenState();
}

class _AdminListBlockedScreenState extends State<AdminListBlockedScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _isFilterVisible = true;
  final int _pageSize = 10;
  int _currentPage = 1;

  List<BlockedPeriod> _allBlockedPeriods = [];
  List<BlockedPeriod> _filteredBlockedPeriods = [];
  List<BlockedPeriod> _paginatedPeriods = [];
  List<Menu> _allMenus = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        final mockData = _generateMockBlockedPeriods();
        setState(() {
          _allBlockedPeriods = mockData.periods;
          _allMenus = mockData.menus;
          _applyFiltersAndPagination();
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _refreshData() async {
    _resetFilters();
    setState(() {
      _allBlockedPeriods.clear();
      _filteredBlockedPeriods.clear();
      _paginatedPeriods.clear();
      _allMenus.clear();
      _currentPage = 1;
    });
    _loadMockData();
  }

  void _applyFiltersAndPagination() {
    final formValues = _formKey.currentState?.value;
    final now = DateTime.now();
    List<BlockedPeriod> filtered = List.from(_allBlockedPeriods);

    if (formValues != null) {
      final searchQuery = formValues['search'] as String? ?? '';
      final selectedMenuId = formValues['menu_id'] as int? ?? 0;
      final selectedStatus = formValues['status'] as String? ?? 'all';
      final startDate = formValues['start_date'] as DateTime?;
      final endDate = formValues['end_date'] as DateTime?;
      final allMenusOnly = formValues['all_menus_only'] as bool? ?? false;

      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        filtered = filtered
            .where((p) => p.reason.toLowerCase().contains(query))
            .toList();
      }

      if (selectedMenuId != 0) {
        filtered = filtered.where((p) => p.menu?.id == selectedMenuId).toList();
      }

      if (allMenusOnly) {
        filtered = filtered.where((p) => p.allMenus).toList();
      }

      if (selectedStatus != 'all') {
        filtered = filtered.where((p) {
          final isAfterStart = now.isAfter(p.startDatetime);
          final isBeforeEnd = now.isBefore(p.endDatetime);

          if (selectedStatus == 'active') {
            return isAfterStart && isBeforeEnd;
          } else if (selectedStatus == 'upcoming') {
            return now.isBefore(p.startDatetime);
          } else if (selectedStatus == 'expired') {
            return now.isAfter(p.endDatetime);
          }
          return false;
        }).toList();
      }

      if (startDate != null) {
        filtered = filtered
            .where((p) => !p.endDatetime.isBefore(startDate))
            .toList();
      }

      if (endDate != null) {
        final inclusiveEndDate = endDate
            .add(const Duration(days: 1))
            .subtract(const Duration(microseconds: 1));
        filtered = filtered
            .where((p) => !p.startDatetime.isAfter(inclusiveEndDate))
            .toList();
      }
    }

    // Pagination logic
    final totalItems = filtered.length;
    final startIndex = (_currentPage - 1) * _pageSize;
    final endIndex = min(startIndex + _pageSize, totalItems);

    setState(() {
      _filteredBlockedPeriods = filtered;
      _paginatedPeriods = totalItems > 0
          ? filtered.sublist(startIndex, endIndex)
          : [];
    });
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    setState(() => _currentPage = 1);
    _applyFiltersAndPagination();
  }

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
      _applyFiltersAndPagination();
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (_filteredBlockedPeriods.length / _pageSize).ceil();

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: _buildStatsCards()),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: BlockedPeriodFilterSearch(
                  formKey: _formKey,
                  isFilterVisible: _isFilterVisible,
                  menus: _allMenus,
                  onToggleVisibility: () =>
                      setState(() => _isFilterVisible = !_isFilterVisible),
                  onFilter: () {
                    setState(() => _currentPage = 1);
                    _applyFiltersAndPagination();
                  },
                  onReset: _resetFilters,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: BlockedPeriodTableWidget(
                  blockedPeriods: _paginatedPeriods,
                  isLoading: _isLoading,
                  onRefresh: _refreshData,
                  currentPage: _currentPage,
                  totalPages: totalPages > 0 ? totalPages : 1,
                  onPageChanged: _onPageChanged,
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
            'Blocked Period Management',
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            'Manage blocked time periods for reservations',
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: 'Add Period',
            leadingIcon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final now = DateTime.now();
    final total = _allBlockedPeriods.length;
    final active = _allBlockedPeriods
        .where(
          (p) => now.isAfter(p.startDatetime) && now.isBefore(p.endDatetime),
        )
        .length;
    final upcoming = _allBlockedPeriods
        .where((p) => now.isBefore(p.startDatetime))
        .length;
    final expired = total - active - upcoming;

    return Column(
      children: [
        StatTile(
          title: 'Total Periods',
          value: '$total',
          icon: Icons.calendar_today,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Currently Active',
          value: '$active',
          icon: Icons.play_circle_fill,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Upcoming',
          value: '$upcoming',
          icon: Icons.timelapse,
          color: Colors.yellow.shade200,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Expired',
          value: '$expired',
          icon: Icons.history,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }

  ({List<BlockedPeriod> periods, List<Menu> menus})
  _generateMockBlockedPeriods() {
    final now = DateTime.now();
    final random = Random();
    final List<Menu> mockMenus = const [
      Menu(
        id: 1,
        name: 'Installation of tires purchased at our store',
        description:
            'Professional tire installation service by our certified technicians.',
        requiredTime: 60,
        price: Price(
          amount: '150000',
          formatted: 'Rp 150.000',
          currency: 'IDR',
        ),
        displayOrder: 1,
        isActive: true,
        color: ColorInfo(
          hex: '#3498DB',
          rgbaLight: 'rgba(52, 152, 219, 0.1)',
          textColor: '#FFFFFF',
        ),
      ),
      Menu(
        id: 2,
        name: 'Change tires by bringing your own (removal and installation)',
        description: 'We can install tires that you provide.',
        requiredTime: 75,
        price: Price(
          amount: '200000',
          formatted: 'Rp 200.000',
          currency: 'IDR',
        ),
        displayOrder: 2,
        isActive: true,
        color: ColorInfo(
          hex: '#9B59B6',
          rgbaLight: 'rgba(155, 89, 182, 0.1)',
          textColor: '#FFFFFF',
        ),
      ),
      Menu(
        id: 3,
        name: 'Oil change',
        description: 'Regular oil change with high-quality synthetic oil.',
        requiredTime: 30,
        price: Price(
          amount: '350000',
          formatted: 'Rp 350.000',
          currency: 'IDR',
        ),
        displayOrder: 3,
        isActive: true,
        color: ColorInfo(
          hex: '#F39C12',
          rgbaLight: 'rgba(243, 156, 18, 0.1)',
          textColor: '#FFFFFF',
        ),
      ),
    ];

    final periods = List.generate(25, (index) {
      final id = index + 1;
      final isAllMenus = id % 5 == 0;
      final durationHours = random.nextInt(5) + 1;
      final startOffsetDays = random.nextInt(10) - 5; // -5 to +4 days from now

      final start = now.add(
        Duration(days: startOffsetDays, hours: random.nextInt(24)),
      );
      final end = start.add(
        Duration(hours: durationHours, minutes: random.nextBool() ? 30 : 0),
      );

      return BlockedPeriod(
        id: id,
        menu: isAllMenus ? null : mockMenus[random.nextInt(mockMenus.length)],
        startDatetime: start,
        endDatetime: end,
        reason: 'Blocked for maintenance schedule $id',
        allMenus: isAllMenus,
        createdAt: now.subtract(Duration(days: id)),
        updatedAt: now.subtract(Duration(days: id)),
      );
    });

    return (periods: periods, menus: mockMenus);
  }
}
