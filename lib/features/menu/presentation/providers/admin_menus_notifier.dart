import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/usecases/get_admin_menus_cursor_usecase.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_state.dart';

class AdminMenusNotifier extends Notifier<AdminMenusState> {
  late final GetAdminMenusCursorUsecase _getUsersCursorUsecase;

  @override
  AdminMenusState build() {
    _getUsersCursorUsecase = ref.watch(getAdminMenusCursorUsecaseProvider);
    Future.microtask(() => getInitialAdminMenus());
    return const AdminMenusState();
  }

  Future<void> getInitialAdminMenus({
    bool paginate = true,
    int perPage = 10,
  }) async {
    if (state.status == AdminMenusStatus.loading) return;

    state = state.copyWith(status: AdminMenusStatus.loading);

    final params = GetAdminMenusCursorParams(
      paginate: paginate,
      perPage: perPage,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: AdminMenusStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: AdminMenusStatus.success,
              menus: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> getAdminMenus({bool paginate = true, int perPage = 10}) async {
    await getInitialAdminMenus(paginate: paginate, perPage: perPage);
  }

  Future<void> loadMore({bool paginate = true, int perPage = 10}) async {
    if (!state.hasNextPage || state.status == AdminMenusStatus.loadingMore) {
      return;
    }

    state = state.copyWith(status: AdminMenusStatus.loadingMore);

    final params = GetAdminMenusCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: AdminMenusStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        final List<Menu> alls = [...state.menus, ...success.data ?? <Menu>[]];
        state = state
            .copyWith(
              status: AdminMenusStatus.success,
              menus: alls,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh({bool paginate = true, int perPage = 10}) async {
    await getInitialAdminMenus(paginate: paginate, perPage: perPage);
  }

  void clearState() {
    state = const AdminMenusState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
