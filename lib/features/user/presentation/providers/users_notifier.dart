import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/user/domain/usecases/get_users_cursor_usecase.dart';
import 'package:tires/features/user/presentation/providers/users_state.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class UsersNotifier extends Notifier<UsersState> {
  late GetUsersCursorUsecase _getUsersCursorUsecase;

  @override
  UsersState build() {
    _getUsersCursorUsecase = ref.watch(getUsersCursorUsecaseProvider);
    Future.microtask(() => getInitialUsers());
    return const UsersState();
  }

  Future<void> getInitialUsers({bool paginate = true, int perPage = 10}) async {
    if (state.status == UsersStatus.loading) return;

    AppLogger.uiInfo('Fetching initial users in notifier');
    state = state.copyWith(status: UsersStatus.loading);

    final params = GetUsersCursorParams(paginate: paginate, perPage: perPage);

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch initial users', failure);
        state = state.copyWith(
          status: UsersStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Initial users fetched successfully in notifier');
        state = state
            .copyWith(
              status: UsersStatus.success,
              users: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> getUsers({bool paginate = true, int perPage = 10}) async {
    await getInitialUsers(paginate: paginate, perPage: perPage);
  }

  Future<void> loadMore({bool paginate = true, int perPage = 10}) async {
    if (!state.hasNextPage || state.status == UsersStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more users in notifier');
    state = state.copyWith(status: UsersStatus.loadingMore);

    final params = GetUsersCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more users', failure);
        state = state.copyWith(
          status: UsersStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('More users loaded successfully in notifier');
        final List<User> alls = [...state.users, ...success.data ?? <User>[]];
        state = state
            .copyWith(
              status: UsersStatus.success,
              users: alls,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh({bool paginate = true, int perPage = 10}) async {
    await getInitialUsers(paginate: paginate, perPage: perPage);
  }

  void clearState() {
    state = const UsersState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
