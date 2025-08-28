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
import 'package:tires/shared/presentation/widgets/debug_section.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

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
          // Debug section example (remove kDebugMode check for demo)
          if (true) // Change to kDebugMode for production
            // SliverToBoxAdapter(child: _buildHomeDebugSection()),
            _buildMenuSection(state),
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

  // Widget _buildHomeDebugSection() {
  //   return DebugSection.createApiTestSection(
  //     context: context,
  //     title: '🏠 Home Screen Debug',
  //     apiActions: [
  //       DebugAction.testApi(
  //         label: 'Test Menu API',
  //         onPressed: () {
  //           final state = ref.read(menuNotifierProvider);
  //           DebugHelper.logApiResponse({
  //             'menu_count': state.menus.length,
  //             'status': state.status.toString(),
  //             'has_next_page': state.hasNextPage,
  //             'error': state.errorMessage,
  //           }, endpoint: 'Home Menu State Test');
  //         },
  //       ),
  //       DebugAction.refresh(
  //         label: 'Force Refresh Menus',
  //         onPressed: () {
  //           ref.read(menuNotifierProvider.notifier).refreshMenus();
  //         },
  //         debugEndpoint: 'Home Menu Refresh',
  //       ),
  //       DebugAction.inspect(
  //         label: 'Inspect First Menu',
  //         onPressed: () {
  //           final state = ref.read(menuNotifierProvider);
  //           if (state.menus.isNotEmpty) {
  //             final firstMenu = state.menus.first;
  //             DebugHelper.logApiResponse({
  //               'menu_id': firstMenu.id,
  //               'menu_name': firstMenu.name,
  //               'menu_type': firstMenu.runtimeType.toString(),
  //             }, endpoint: 'First Menu Inspection');
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _buildMenuSection(MenuState state) {
    // Initial loading state - show loading indicator
    if (state.status == MenuStatus.loading && state.menus.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Error state - show error message with retry button
    if (state.status == MenuStatus.error && state.menus.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  state.errorMessage ?? 'An unknown error occurred.',
                  style: AppTextStyle.bodyMedium,
                  textAlign: TextAlign.center,
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
          ),
        ),
      );
    }

    // No menus available
    if (state.menus.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: AppText(
              'No menus available',
              style: AppTextStyle.bodyMedium,
            ),
          ),
        ),
      );
    }

    // Show menu list
    return SliverList.builder(
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
    );
  }
}
