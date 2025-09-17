import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
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

    AppLogger.uiInfo('Loading initial admin menus');
    state = state.copyWith(status: AdminMenusStatus.loading);

    final params = GetAdminMenusCursorParams(
      paginate: paginate,
      perPage: perPage,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load initial admin menus', failure);
        state = state.copyWith(
          status: AdminMenusStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully loaded initial admin menus');
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
    AppLogger.uiInfo('Getting admin menus');
    await getInitialAdminMenus(paginate: paginate, perPage: perPage);
  }

  Future<void> loadMore({bool paginate = true, int perPage = 10}) async {
    if (!state.hasNextPage || state.status == AdminMenusStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more admin menus');
    state = state.copyWith(status: AdminMenusStatus.loadingMore);

    final params = GetAdminMenusCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more admin menus', failure);
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
    AppLogger.uiInfo('Refreshing admin menus');
    await getInitialAdminMenus(paginate: paginate, perPage: perPage);
  }

  void clearState() {
    AppLogger.uiInfo('Clearing admin menus state');
    state = const AdminMenusState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing admin menus error');
      state = state.copyWithClearError();
    }
  }
}
