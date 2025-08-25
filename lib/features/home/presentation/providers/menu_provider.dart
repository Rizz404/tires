import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/home/presentation/providers/menu_notifier.dart';
import 'package:tires/features/home/presentation/providers/menu_state.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

final menuNotifierProvider = StateNotifierProvider<MenuNotifier, MenuState>((
  ref,
) {
  final getMenuCursorUsecase = ref.watch(getMenuCursorUsecaseProvider);
  return MenuNotifier(getMenuCursorUsecase);
});

// Convenient computed providers
final menusProvider = Provider<List<Menu>>((ref) {
  final menuState = ref.watch(menuNotifierProvider);
  return menuState.menus;
});

final activeMenusProvider = Provider<List<Menu>>((ref) {
  final menus = ref.watch(menusProvider);
  return menus.where((menu) => menu.isActive).toList()
    ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
});

final menuLoadingProvider = Provider<bool>((ref) {
  final menuState = ref.watch(menuNotifierProvider);
  return menuState.status == MenuStatus.loading;
});

final menuErrorProvider = Provider<String?>((ref) {
  final menuState = ref.watch(menuNotifierProvider);
  return menuState.errorMessage;
});
