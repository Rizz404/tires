import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/blocked_period/domain/usecases/get_blocked_periods_cursor_usecase.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_periods_state.dart';

class BlockedPeriodsNotifier extends Notifier<BlockedPeriodsState> {
  late GetBlockedPeriodsCursorUsecase _getBlockedPeriodsCursorUsecase;

  @override
  BlockedPeriodsState build() {
    _getBlockedPeriodsCursorUsecase = ref.watch(
      getBlockedPeriodsCursorUsecaseProvider,
    );
    Future.microtask(() => getInitialBlockedPeriods());
    return const BlockedPeriodsState();
  }

  Future<void> getInitialBlockedPeriods({
    String? cursor,
    int? perPage,
    String? search,
    String? status,
    int? menuId,
    bool? allMenus,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (state.status == BlockedPeriodsStatus.loading) return;

    AppLogger.uiInfo('Fetching initial blocked periods in notifier');

    state = state.copyWith(status: BlockedPeriodsStatus.loading);

    final params = GetBlockedPeriodsCursorParams(
      cursor: cursor,
      perPage: perPage ?? 10,
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
        AppLogger.uiError('Failed to fetch initial blocked periods', failure);
        state = state.copyWith(
          status: BlockedPeriodsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'Initial blocked periods fetched successfully in notifier',
        );
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

  Future<void> getBlockedPeriods({
    String? cursor,
    int? perPage,
    String? search,
    String? status,
    int? menuId,
    bool? allMenus,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await getInitialBlockedPeriods(
      cursor: cursor,
      perPage: perPage,
      search: search,
      status: status,
      menuId: menuId,
      allMenus: allMenus,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<void> loadMore() async {
    if (state.status == BlockedPeriodsStatus.loadingMore ||
        !state.hasNextPage ||
        state.cursor?.nextCursor == null) {
      return;
    }

    AppLogger.uiInfo('Loading more blocked periods in notifier');

    state = state.copyWith(status: BlockedPeriodsStatus.loadingMore);

    final params = GetBlockedPeriodsCursorParams(
      cursor: state.cursor?.nextCursor,
      perPage: 10,
    );

    final response = await _getBlockedPeriodsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more blocked periods', failure);
        state = state.copyWith(
          status: BlockedPeriodsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'More blocked periods loaded successfully in notifier',
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

  Future<void> refresh({
    String? search,
    String? status,
    int? menuId,
    bool? allMenus,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    AppLogger.uiInfo('Refreshing blocked periods in notifier');
    state = state.copyWith(
      status: BlockedPeriodsStatus.loading,
      blockedPeriods: [],
      cursor: null,
    );
    await getInitialBlockedPeriods(
      search: search,
      status: status,
      menuId: menuId,
      allMenus: allMenus,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void clearError() {
    state = state.copyWithClearError();
  }
}
