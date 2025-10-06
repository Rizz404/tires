import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/blocked_period/domain/usecases/get_blocked_periods_cursor_usecase.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_periods_state.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';

class BlockedPeriodsSearchNotifier extends Notifier<BlockedPeriodsState> {
  late GetBlockedPeriodsCursorUsecase _getBlockedPeriodsCursorUsecase;

  @override
  BlockedPeriodsState build() {
    _getBlockedPeriodsCursorUsecase = ref.watch(
      getBlockedPeriodsCursorUsecaseProvider,
    );
    return const BlockedPeriodsState();
  }

  Future<void> searchBlockedPeriods({
    required String search,
    String? status,
    int? menuId,
    bool? allMenus,
    DateTime? startDate,
    DateTime? endDate,
    int perPage = 10,
  }) async {
    if (state.status == BlockedPeriodsStatus.loading) return;

    AppLogger.uiInfo('Searching blocked periods in notifier');
    state = state.copyWith(status: BlockedPeriodsStatus.loading);

    final params = GetBlockedPeriodsCursorParams(
      perPage: perPage,
      search: search,
      status: status,
      menuId: menuId,
      allMenus: allMenus,
      startDate: startDate,
      endDate: endDate,
    );

    final response = await _getBlockedPeriodsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to search blocked periods', failure);
        state = state.copyWith(
          status: BlockedPeriodsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Blocked periods searched successfully in notifier');
        state = state
            .copyWith(
              status: BlockedPeriodsStatus.success,
              blockedPeriods: success.data ?? [],
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
    int? menuId,
    bool? allMenus,
    DateTime? startDate,
    DateTime? endDate,
    int perPage = 10,
  }) async {
    if (state.status == BlockedPeriodsStatus.loadingMore ||
        !state.hasNextPage ||
        state.cursor?.nextCursor == null) {
      return;
    }

    AppLogger.uiInfo('Loading more search results in notifier');
    state = state.copyWith(status: BlockedPeriodsStatus.loadingMore);

    final params = GetBlockedPeriodsCursorParams(
      cursor: state.cursor?.nextCursor,
      perPage: perPage,
      search: search,
      status: status,
      menuId: menuId,
      allMenus: allMenus,
      startDate: startDate,
      endDate: endDate,
    );

    final response = await _getBlockedPeriodsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more search results', failure);
        state = state.copyWith(
          status: BlockedPeriodsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'More search results loaded successfully in notifier',
        );
        final updatedBlockedPeriods = [
          ...state.blockedPeriods,
          ...(success.data ?? []).cast<BlockedPeriod>(),
        ];
        state = state
            .copyWith(
              status: BlockedPeriodsStatus.success,
              blockedPeriods: updatedBlockedPeriods,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  void clearSearch() {
    AppLogger.uiInfo('Clearing search results');
    state = const BlockedPeriodsState();
  }

  void clearError() {
    state = state.copyWithClearError();
  }
}
