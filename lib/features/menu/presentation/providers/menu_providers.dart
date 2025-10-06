import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_notifier.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_mutation_notifier.dart';
import 'package:tires/features/menu/presentation/providers/menu_mutation_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_notifier.dart';
import 'package:tires/features/menu/presentation/providers/menu_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_statistics_notifier.dart';
import 'package:tires/features/menu/presentation/providers/menu_statistics_state.dart';

final adminMenuGetNotifierProvider =
    NotifierProvider<AdminMenusNotifier, AdminMenusState>(
      AdminMenusNotifier.new,
    );

final menuMutationNotifierProvider =
    NotifierProvider<MenuMutationNotifier, MenuMutationState>(
      MenuMutationNotifier.new,
    );

final menuStatisticsNotifierProvider =
    NotifierProvider<MenuStatisticsNotifier, MenuStatisticsState>(
      MenuStatisticsNotifier.new,
    );

final menuNotifierProvider = NotifierProvider<MenuNotifier, MenuState>(
  MenuNotifier.new,
);

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
