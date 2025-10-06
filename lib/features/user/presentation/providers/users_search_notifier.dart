import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/domain/usecases/get_users_cursor_usecase.dart';
import 'package:tires/features/user/presentation/providers/users_search_state.dart';

class UsersSearchNotifier extends Notifier<UsersSearchState> {
  late GetUsersCursorUsecase _getUsersCursorUsecase;

  @override
  UsersSearchState build() {
    _getUsersCursorUsecase = ref.watch(getUsersCursorUsecaseProvider);
    return const UsersSearchState();
  }

  Future<void> searchUsers({
    required String search,
    String? role,
    String? status,
    String? createdFrom,
    String? createdTo,
    int perPage = 10,
  }) async {
    if (state.status == UsersSearchStatus.loading) return;

    AppLogger.uiInfo('Searching users in notifier');
    state = state.copyWith(status: UsersSearchStatus.loading);

    final params = GetUsersCursorParams(
      paginate: true,
      perPage: perPage,
      search: search,
      role: role,
      status: status,
      createdFrom: createdFrom,
      createdTo: createdTo,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to search users', failure);
        state = state.copyWith(
          status: UsersSearchStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Users searched successfully in notifier');
        state = state
            .copyWith(
              status: UsersSearchStatus.success,
              users: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> loadMoreSearchResults({
    required String search,
    String? role,
    String? status,
    String? createdFrom,
    String? createdTo,
    int perPage = 10,
  }) async {
    if (!state.hasNextPage || state.status == UsersSearchStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more search results in notifier');
    state = state.copyWith(status: UsersSearchStatus.loadingMore);

    final params = GetUsersCursorParams(
      paginate: true,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
      search: search,
      role: role,
      status: status,
      createdFrom: createdFrom,
      createdTo: createdTo,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more search results', failure);
        state = state.copyWith(
          status: UsersSearchStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'More search results loaded successfully in notifier',
        );
        final List<User> alls = [...state.users, ...success.data ?? <User>[]];
        state = state
            .copyWith(
              status: UsersSearchStatus.success,
              users: alls,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  void clearSearch() {
    AppLogger.uiInfo('Clearing search results');
    state = const UsersSearchState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
