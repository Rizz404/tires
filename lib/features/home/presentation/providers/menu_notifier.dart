import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/home/presentation/providers/menu_state.dart';
import 'package:tires/features/menu/domain/usecases/get_menus_usecase.dart';

class MenuNotifier extends StateNotifier<MenuState> {
  final GetMenusUsecase _getMenusUsecase;

  MenuNotifier(this._getMenusUsecase) : super(const MenuState());

  Future<void> getMenus() async {
    state = state.copyWith(status: MenuStatus.loading);

    final result = await _getMenusUsecase(NoParams());

    result.fold(
      (failure) {
        state = state.copyWith(
          status: MenuStatus.error,
          errorMessage: failure.message,
        );
      },
      (menus) {
        state = state.copyWith(
          status: MenuStatus.loaded,
          menus: menus,
          errorMessage: null,
        );
      },
    );
  }

  void clearError() {
    state = state.copyWith(
      status: state.status == MenuStatus.error
          ? MenuStatus.initial
          : state.status,
      errorMessage: null,
    );
  }

  Future<void> refreshMenus() async {
    await getMenus();
  }
}
