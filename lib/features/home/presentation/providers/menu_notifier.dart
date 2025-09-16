import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/home/presentation/providers/menu_state.dart';
import 'package:tires/features/menu/domain/usecases/get_menus_cursor_usecase.dart';

class MenuNotifier extends Notifier<MenuState> {
  late final GetMenusCursorUsecase _getMenusUsecase;

  @override
  MenuState build() {
    _getMenusUsecase = ref.watch(getMenusCursorUsecaseProvider);
    Future.microtask(() => getInitialMenus());
    return const MenuState();
  }

  Future<void> getInitialMenus() async {
    if (state.status == MenuStatus.loading) return;

    state = state.copyWith(status: MenuStatus.loading);

    final result = await _getMenusUsecase(
      const GetMenusCursorParams(paginate: true, perPage: 15),
    );

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
      GetMenusCursorParams(
        paginate: true,
        perPage: 15,
        cursor: state.nextCursor,
      ),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: MenuStatus.loaded,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state.copyWith(
          status: MenuStatus.loaded,
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
