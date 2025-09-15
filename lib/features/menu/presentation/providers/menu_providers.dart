import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_notifier.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_mutation_notifier.dart';
import 'package:tires/features/menu/presentation/providers/menu_mutation_state.dart';

final adminMenuGetNotifierProvider =
    NotifierProvider<AdminMenusNotifier, AdminMenusState>(
      AdminMenusNotifier.new,
    );

final menuMutationNotifierProvider =
    NotifierProvider<MenuMutationNotifier, MenuMutationState>(
      MenuMutationNotifier.new,
    );
