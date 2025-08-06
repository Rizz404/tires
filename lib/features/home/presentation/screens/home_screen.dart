import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/home/presentation/providers/menu_provider.dart';
import 'package:tires/features/home/presentation/providers/menu_state.dart';
import 'package:tires/features/home/presentation/widgets/menu_tile.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load menus saat screen pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(menuNotifierProvider.notifier).getMenus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuState = ref.watch(menuNotifierProvider);
    final isLoading = ref.watch(menuLoadingProvider);
    final errorMessage = ref.watch(menuErrorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const AppText('Menu Services', style: AppTextStyle.title),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(menuNotifierProvider.notifier).refreshMenus();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ScreenWrapper(
        child: _buildBody(menuState, isLoading, errorMessage),
      ),
    );
  }

  Widget _buildBody(MenuState menuState, bool isLoading, String? errorMessage) {
    if (isLoading && menuState.menus.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null && menuState.menus.isEmpty) {
      print(errorMessage);
      return _buildErrorWidget(errorMessage);
    }

    if (menuState.menus.isEmpty) {
      return const Center(
        child: AppText('No menus available', style: AppTextStyle.body),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(menuNotifierProvider.notifier).refreshMenus();
      },
      child: Column(
        children: [
          // Error banner jika ada error saat refresh
          if (errorMessage != null && menuState.menus.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),
              color: Theme.of(context).colorScheme.error.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppText(
                      errorMessage,
                      style: AppTextStyle.caption,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(menuNotifierProvider.notifier).clearError();
                    },
                    icon: const Icon(Icons.close, size: 16),
                  ),
                ],
              ),
            ),

          // Menu List
          Expanded(
            child: ListView.builder(
              itemCount: menuState.menus.length,
              itemBuilder: (context, index) {
                final menu = menuState.menus[index];
                return MenuTile(
                  menu: menu,
                  onBookPressed: () {
                    _handleBookPressed(menu);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            AppText('Failed to load menus', style: AppTextStyle.title),
            const SizedBox(height: 8),
            AppText(
              errorMessage,
              style: AppTextStyle.body,
              textAlign: TextAlign.center,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.read(menuNotifierProvider.notifier).getMenus();
              },
              child: const AppText('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBookPressed(Menu menu) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText('Booking ${menu.name}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
