import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/blocked_period/domain/usecases/get_blocked_period_statistics_usecase.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_statistics_state.dart';

class BlockedPeriodStatisticsNotifier
    extends Notifier<BlockedPeriodStatisticsState> {
  late GetBlockedPeriodStatisticsUsecase _getBlockedPeriodStatisticsUsecase;

  @override
  BlockedPeriodStatisticsState build() {
    _getBlockedPeriodStatisticsUsecase = ref.watch(
      getBlockedPeriodStatisticsUsecaseProvider,
    );
    Future.microtask(() => getBlockedPeriodStatistics());
    return const BlockedPeriodStatisticsState();
  }

  Future<void> getBlockedPeriodStatistics() async {
    if (state.status == BlockedPeriodStatisticsStatus.loading) return;

    AppLogger.uiInfo('Fetching blocked period statistics in notifier');
    state = state.copyWith(status: BlockedPeriodStatisticsStatus.loading);

    final response = await _getBlockedPeriodStatisticsUsecase(NoParams());

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch blocked period statistics', failure);
        state = state.copyWith(
          status: BlockedPeriodStatisticsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'Blocked period statistics fetched successfully in notifier',
        );
        state = state
            .copyWith(
              status: BlockedPeriodStatisticsStatus.success,
              statistics: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh() async {
    AppLogger.uiInfo('Refreshing blocked period statistics in notifier');
    await getBlockedPeriodStatistics();
  }

  void clearError() {
    state = state.copyWithClearError();
  }
}
