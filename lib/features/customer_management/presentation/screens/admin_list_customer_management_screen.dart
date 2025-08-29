import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/customer_management/presentation/widgets/customer_table_widget.dart';
import 'package:tires/features/customer_management/presentation/widgets/customer_stats_card.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/debug_section.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

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
  bool _isLoading = false;
  List<User> _customers = [];

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
          _isLoading = false;
        });
      }
    });
  }

  void _refreshCustomers() {
    setState(() {
      _customers.clear();
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
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
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
          SliverToBoxAdapter(child: CustomerStatsCard(customers: _customers)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          // Add debug section in development
          if (true) // Replace with kDebugMode for production
            SliverToBoxAdapter(child: _buildDebugSection(context)),
          SliverToBoxAdapter(
            child: CustomerTableWidget(
              customers: _customers,
              isLoading: _isLoading,
              onRefresh: _refreshCustomers,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (_isLoading && _customers.isNotEmpty)
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

  Widget _buildDebugSection(BuildContext context) {
    return DebugSection(
      title: '👥 Customer Management Debug',
      actions: [
        DebugAction.refresh(
          label: 'Refresh Customers',
          onPressed: _refreshCustomers,
          debugEndpoint: 'Customer Management Refresh',
        ),
        DebugAction.clear(
          label: 'Clear Data',
          onPressed: () {
            setState(() {
              _customers.clear();
            });
          },
        ),
        DebugAction.testApi(label: 'Load More', onPressed: _loadMoreCustomers),
        DebugAction.viewLogs(
          label: 'Show Logs',
          context: context,
          message: 'Check console for customer management logs',
        ),
        DebugAction.inspect(
          label: 'Inspect Data',
          onPressed: () {
            DebugHelper.logApiResponse({
              'total_customers': _customers.length,
              'is_loading': _isLoading,
              'registered_count': _customers
                  .where((c) => c.companyName != null || c.department != null)
                  .length,
              'guest_count': _customers
                  .where((c) => c.companyName == null && c.department == null)
                  .length,
            }, endpoint: 'Customer Management State');
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Customer Management',
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            'Manage customer data and their reservation history.',
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
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
