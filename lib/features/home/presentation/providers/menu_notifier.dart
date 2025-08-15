import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/home/presentation/providers/menu_state.dart';
import 'package:tires/features/menu/domain/usecases/get_menus_usecase.dart';

class MenuNotifier extends StateNotifier<MenuState> {
  final GetMenusUsecase _getMenusUsecase;

  MenuNotifier(this._getMenusUsecase) : super(const MenuState());

  Future<void> getInitialMenus() async {
    if (state.status == MenuStatus.loading) return;

    state = state.copyWith(status: MenuStatus.loading);

    final result = await _getMenusUsecase(const GetMenusParams());

    result.fold(
      (failure) {
        state = state.copyWith(
          status: MenuStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state.copyWith(
          status: MenuStatus.loaded,
          menus: success.data ?? [],
          hasNextPage: success.cursor?.hasNextPage,
          nextCursor: success.cursor?.nextCursor,
          forceErrorMessageNull: true,
        );
      },
    );
  }

  Future<void> loadMoreMenus() async {
    if (state.status == MenuStatus.loadingMore || !state.hasNextPage) return;

    state = state.copyWith(status: MenuStatus.loadingMore);

    final result = await _getMenusUsecase(
      GetMenusParams(cursor: state.nextCursor),
    );

    result.fold(
      (failure) {
        // Saat gagal load more, kita kembali ke status loaded,
        // tidak menampilkan error fullscreen.
        state = state.copyWith(
          status: MenuStatus.loaded,
          errorMessage: failure.message, // Bisa ditampilkan di snackbar
        );
      },
      (success) {
        state = state.copyWith(
          status: MenuStatus.loaded,
          // Gabungkan list yang lama dengan yang baru
          menus: [...state.menus, ...success.data ?? []],
          hasNextPage: success.cursor?.hasNextPage,
          nextCursor: success.cursor?.nextCursor,
        );
      },
    );
  }

  Future<void> refreshMenus() async {
    await getInitialMenus();
  }
}
