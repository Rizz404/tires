import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/customer_management/presentation/widgets/customer_table_widget.dart';
import 'package:tires/features/customer_management/presentation/widgets/customer_stats_card.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_search_field.dart';
import 'package:tires/shared/presentation/widgets/app_dropdown.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminListCustomerManagementScreen extends ConsumerStatefulWidget {
  const AdminListCustomerManagementScreen({super.key});

  @override
  ConsumerState<AdminListCustomerManagementScreen> createState() =>
      _AdminListCustomerManagementScreenState();
}

class _AdminListCustomerManagementScreenState
    extends ConsumerState<AdminListCustomerManagementScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  List<User> _customers = [];
  List<User> _filteredCustomers = [];
  String _searchQuery = '';
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadMockCustomers();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreCustomers();
    }
  }

  void _loadMockCustomers() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _customers = _generateMockCustomers();
          _applyFilters();
          _isLoading = false;
        });
      }
    });
  }

  void _refreshCustomers() {
    setState(() {
      _customers.clear();
      _filteredCustomers.clear();
    });
    _loadMockCustomers();
  }

  void _loadMoreCustomers() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate loading more customers
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _customers.addAll(_generateMockCustomers(offset: _customers.length));
          _applyFilters();
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async => _refreshCustomers(),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: CustomerStatsCard(customers: _filteredCustomers),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildFilters(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: CustomerTableWidget(
              customers: _filteredCustomers,
              isLoading: _isLoading,
              onRefresh: _refreshCustomers,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (_isLoading && _filteredCustomers.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
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

  Widget _buildFilters(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppSearchField(
                  name: 'search_query',
                  hintText: context
                      .l10n
                      .adminListCustomerManagementFiltersSearchPlaceholder,
                  initialValue: _searchQuery,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value ?? '';
                    });
                    _applyFilters();
                  },
                  onClear: () {
                    setState(() {
                      _searchQuery = '';
                    });
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  name: 'customer_filter',
                  initialValue: _selectedFilter,
                  hintText:
                      context.l10n.adminListCustomerManagementFiltersAllTypes,
                  items: [
                    AppDropdownItem(
                      value: 'all',
                      label: context
                          .l10n
                          .adminListCustomerManagementFiltersAllTypes,
                      icon: const Icon(Icons.list_alt, size: 18),
                    ),
                    AppDropdownItem(
                      value: 'first_time',
                      label: context
                          .l10n
                          .adminListCustomerManagementFiltersFirstTime,
                      icon: const Icon(Icons.fiber_new, size: 18),
                    ),
                    AppDropdownItem(
                      value: 'repeat',
                      label:
                          context.l10n.adminListCustomerManagementFiltersRepeat,
                      icon: const Icon(Icons.repeat, size: 18),
                    ),
                    AppDropdownItem(
                      value: 'dormant',
                      label: context
                          .l10n
                          .adminListCustomerManagementFiltersDormant,
                      icon: const Icon(Icons.schedule, size: 18),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value ?? 'all';
                    });
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
          if (_searchQuery.isNotEmpty || _selectedFilter != 'all') ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (_searchQuery.isNotEmpty)
                  Chip(
                    label: AppText('Search: $_searchQuery'),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      _formKey.currentState?.fields['search_query']?.didChange(
                        '',
                      );
                      setState(() {
                        _searchQuery = '';
                      });
                      _applyFilters();
                    },
                  ),
                if (_searchQuery.isNotEmpty && _selectedFilter != 'all')
                  const SizedBox(width: 8),
                if (_selectedFilter != 'all')
                  Chip(
                    label: AppText(
                      'Filter: ${_getFilterLabel(_selectedFilter)}',
                    ),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() {
                        _selectedFilter = 'all';
                      });
                      _applyFilters();
                    },
                  ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    setState(() {
                      _searchQuery = '';
                      _selectedFilter = 'all';
                    });
                    _applyFilters();
                  },
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: AppText(
                    context.l10n.adminListCustomerManagementFiltersReset,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _getFilterLabel(String filter) {
    switch (filter) {
      case 'first_time':
        return context.l10n.adminListCustomerManagementFiltersFirstTime;
      case 'repeat':
        return context.l10n.adminListCustomerManagementFiltersRepeat;
      case 'dormant':
        return context.l10n.adminListCustomerManagementFiltersDormant;
      default:
        return context.l10n.adminListCustomerManagementFiltersAllTypes;
    }
  }

  void _applyFilters() {
    List<User> filtered = List.from(_customers);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((customer) {
        return customer.fullName.toLowerCase().contains(query) ||
            customer.email.toLowerCase().contains(query) ||
            customer.phoneNumber.toLowerCase().contains(query) ||
            (customer.fullNameKana != null &&
                customer.fullNameKana!.toLowerCase().contains(query));
      }).toList();
    }

    // Apply type filter
    if (_selectedFilter != 'all') {
      filtered = filtered.where((customer) {
        switch (_selectedFilter) {
          case 'first_time':
            return _getMockReservationCount(customer) == 0;
          case 'repeat':
            return _getMockReservationCount(customer) >= 2;
          case 'dormant':
            return _isDormantCustomer(customer);
          default:
            return true;
        }
      }).toList();
    }

    setState(() {
      _filteredCustomers = filtered;
    });
  }

  // Mock helper methods for filtering
  int _getMockReservationCount(User customer) {
    final id = customer.id;
    if (id % 5 == 0) return 0; // First time customers
    if (id % 3 == 0) return (id % 10) + 1;
    return (id % 7) + 1;
  }

  bool _isDormantCustomer(User customer) {
    final id = customer.id;
    return id % 8 == 0;
  }

  List<User> _generateMockCustomers({int offset = 0}) {
    final mockUsers = <User>[];
    const userNames = [
      (
        'Prof. Malachi Hodkiewicz',
        'マラチ ホドキエビッツ',
        'wuckert.corregan@yahoo.com',
        '+1.919.366.',
      ),
      ('test', 'テスト', 'test@gmail.com', '087758492'),
      (
        'Marcus Aufderhar',
        'マルクス アウフデルハル',
        'april91@hotmail.com',
        '435-524-738',
      ),
      ('Nia Medhurst', 'ニア メドハースト', 'zackary.green@gmail.com', '+14788671349'),
      ('Omer Mueller', 'オメル ミュラー', 'celia83@hintz.biz', '1-215-854-1'),
      (
        'Prof. Edwina Swaniawski',
        'エドウィナ スワニアウスキ',
        'arnaldo06@gmail.com',
        '484-915-316',
      ),
      (
        'Esta Effertz',
        'エスタ エッファーツ',
        'oreilly.lizzie@gmail.com',
        '+1 (423) 993',
      ),
      ('Allison Hills', 'アリソン ヒルズ', 'zboncak.tammy@yahoo.com', '1-929-670-6'),
      ('Tina Ruecker', 'ティナ ルエッカー', 'leila.denesik@gmail.com', '980.474.170'),
      (
        'Shania Rosenbaum',
        'シャニア ローゼンバウム',
        'kailey45@example.org',
        '1-520-626-8',
      ),
      (
        'Mrs. Glenna Schaefer MD',
        'グレナ シェーファー',
        'schmidt.amya@yahoo.com',
        '1-689-524-0',
      ),
      ('Peter Legros', 'ピーター レグロス', 'danika.hoppe@gmail.com', '984-476-786'),
      ('Ms. Kyra Mertz', 'キラ メルツ', 'anna51@example.net', '229.586.495'),
      ('Dr. Larissa Mayer', 'ラリッサ マイヤー', 'rdare@example.org', '+1-743-655-'),
    ];

    for (int i = 0; i < 10; i++) {
      final index = (i + offset) % userNames.length;
      final userData = userNames[index];
      final userId = i + offset + 1;

      mockUsers.add(
        User(
          id: userId,
          email: userData.$3,
          emailVerifiedAt: DateTime.now().subtract(Duration(days: userId % 30)),
          fullName: userData.$1,
          fullNameKana: userData.$2,
          phoneNumber: userData.$4,
          companyName: userId % 4 == 0 ? 'Tech Corp ${userId}' : null,
          department: userId % 5 == 0 ? 'IT Department' : null,
          companyAddress: userId % 4 == 0
              ? '123 Business St, City ${userId}'
              : null,
          homeAddress: '456 Home Ave, Town ${userId}',
          dateOfBirth: DateTime.now().subtract(
            Duration(days: (20 + userId % 40) * 365),
          ),
          role: UserRole.customer,
          gender: userId % 3 == 0
              ? UserGender.male
              : (userId % 3 == 1 ? UserGender.female : UserGender.other),
          createdAt: DateTime.now().subtract(Duration(days: userId % 100)),
          updatedAt: DateTime.now().subtract(Duration(days: userId % 10)),
        ),
      );
    }

    return mockUsers;
  }
}
