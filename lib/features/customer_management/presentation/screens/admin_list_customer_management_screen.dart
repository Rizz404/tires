import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_provider.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_state.dart';
import 'package:tires/features/home/presentation/widgets/home_carousel.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
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

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
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
      ref.read(customerNotifierProvider.notifier).loadMoreCustomers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScreenWrapper(child: _buildBody()));
  }

  Widget _buildBody() {
    final state = ref.watch(customerNotifierProvider);

    if (state.status == CustomerStatus.loading && state.customers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == CustomerStatus.error && state.customers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              state.errorMessage ?? 'An unknown error occurred.',
              style: AppTextStyle.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(customerNotifierProvider.notifier)
                    .getInitialCustomers();
              },
              child: const AppText('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.customers.isEmpty) {
      return RefreshIndicator(
        onRefresh: () =>
            ref.read(customerNotifierProvider.notifier).refreshCustomers(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            Center(
              child: AppText(
                'No customers available',
                style: AppTextStyle.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(customerNotifierProvider.notifier).refreshCustomers(),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeCarousel(),
                SizedBox(height: 24),
                AppText('Our Services', style: AppTextStyle.headlineSmall),
                SizedBox(height: 16),
              ],
            ),
          ),
          SliverList.builder(
            itemCount: state.customers.length,
            itemBuilder: (context, index) {
              final customer = state.customers[index];
              return ListView();
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (state.status == CustomerStatus.loadingMore)
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
}
