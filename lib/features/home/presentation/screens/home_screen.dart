import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/home/presentation/providers/menu_provider.dart';
import 'package:tires/features/home/presentation/providers/menu_state.dart';
import 'package:tires/features/home/presentation/widgets/home_carousel.dart';
import 'package:tires/features/home/presentation/widgets/menu_tile.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
      ref.read(menuNotifierProvider.notifier).loadMoreMenus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScreenWrapper(child: _buildBody()));
  }

  Widget _buildBody() {
    final state = ref.watch(menuNotifierProvider);

    if (state.status == MenuStatus.loading && state.menus.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == MenuStatus.error && state.menus.isEmpty) {
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
                ref.read(menuNotifierProvider.notifier).getInitialMenus();
              },
              child: const AppText('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.menus.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => ref.read(menuNotifierProvider.notifier).refreshMenus(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            Center(
              child: AppText(
                'No menus available',
                style: AppTextStyle.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(menuNotifierProvider.notifier).refreshMenus(),
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
            itemCount: state.menus.length,
            itemBuilder: (context, index) {
              final menu = state.menus[index];
              return MenuTile(
                menu: menu,
                onBookPressed: () {
                  context.router.push(CreateReservationRoute(menu: menu));
                },
              );
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (state.status == MenuStatus.loadingMore)
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
