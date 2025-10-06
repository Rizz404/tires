import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/usecases/get_admin_menus_cursor_usecase.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_state.dart';

class AdminMenusSearchNotifier extends Notifier<AdminMenusState> {
  late GetAdminMenusCursorUsecase _getAdminMenusCursorUsecase;

  @override
  AdminMenusState build() {
    _getAdminMenusCursorUsecase = ref.watch(getAdminMenusCursorUsecaseProvider);
    return const AdminMenusState();
  }

  Future<void> searchAdminMenus({
    required String search,
    String? status,
    double? minPrice,
    double? maxPrice,
    int perPage = 10,
  }) async {
    if (state.status == AdminMenusStatus.loading) return;

    AppLogger.uiInfo('Searching admin menus in notifier');
    state = state.copyWith(status: AdminMenusStatus.loading);

    final params = GetAdminMenusCursorParams(
      paginate: true,
      perPage: perPage,
      search: search,
      status: status,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );

    final response = await _getAdminMenusCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to search admin menus', failure);
        state = state.copyWith(
          status: AdminMenusStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Admin menus searched successfully in notifier');
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

  Future<void> loadMoreSearchResults({
    required String search,
    String? status,
    double? minPrice,
    double? maxPrice,
    int perPage = 10,
  }) async {
    if (!state.hasNextPage || state.status == AdminMenusStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more search results in notifier');
    state = state.copyWith(status: AdminMenusStatus.loadingMore);

    final params = GetAdminMenusCursorParams(
      paginate: true,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
      search: search,
      status: status,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );

    final response = await _getAdminMenusCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more search results', failure);
        state = state.copyWith(
          status: AdminMenusStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'More search results loaded successfully in notifier',
        );
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

  void clearSearch() {
    AppLogger.uiInfo('Clearing search results');
    state = const AdminMenusState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
