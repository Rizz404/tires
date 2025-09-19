import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/blocked_period/domain/usecases/create_blocked_period_usecase.dart';
import 'package:tires/features/blocked_period/domain/usecases/update_blocked_period_usecase.dart';
import 'package:tires/features/blocked_period/domain/usecases/delete_blocked_period_usecase.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_mutation_state.dart';

class BlockedPeriodMutationNotifier
    extends Notifier<BlockedPeriodMutationState> {
  late CreateBlockedPeriodUsecase _createBlockedPeriodUsecase;
  late UpdateBlockedPeriodUsecase _updateBlockedPeriodUsecase;
  late DeleteBlockedPeriodUsecase _deleteBlockedPeriodUsecase;

  @override
  BlockedPeriodMutationState build() {
    _createBlockedPeriodUsecase = ref.watch(createBlockedPeriodUsecaseProvider);
    _updateBlockedPeriodUsecase = ref.watch(updateBlockedPeriodUsecaseProvider);
    _deleteBlockedPeriodUsecase = ref.watch(deleteBlockedPeriodUsecaseProvider);
    return const BlockedPeriodMutationState();
  }

  Future<void> createBlockedPeriod(CreateBlockedPeriodParams params) async {
    if (state.status == BlockedPeriodMutationStatus.loading) return;

    AppLogger.uiInfo('Creating blocked period in notifier');
    state = state.copyWith(status: BlockedPeriodMutationStatus.loading);

    final response = await _createBlockedPeriodUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to create blocked period', failure);
        state = state.copyWith(
          status: BlockedPeriodMutationStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Blocked period created successfully in notifier');
        state = state
            .copyWith(
              status: BlockedPeriodMutationStatus.success,
              blockedPeriod: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> updateBlockedPeriod(UpdateBlockedPeriodParams params) async {
    if (state.status == BlockedPeriodMutationStatus.loading) return;

    AppLogger.uiInfo('Updating blocked period in notifier');
    state = state.copyWith(status: BlockedPeriodMutationStatus.loading);

    final response = await _updateBlockedPeriodUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to update blocked period', failure);
        state = state.copyWith(
          status: BlockedPeriodMutationStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Blocked period updated successfully in notifier');
        state = state
            .copyWith(
              status: BlockedPeriodMutationStatus.success,
              blockedPeriod: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> deleteBlockedPeriod(DeleteBlockedPeriodParams params) async {
    if (state.status == BlockedPeriodMutationStatus.loading) return;

    AppLogger.uiInfo('Deleting blocked period in notifier');
    state = state.copyWith(status: BlockedPeriodMutationStatus.loading);

    final response = await _deleteBlockedPeriodUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to delete blocked period', failure);
        state = state.copyWith(
          status: BlockedPeriodMutationStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Blocked period deleted successfully in notifier');
        state = state
            .copyWith(status: BlockedPeriodMutationStatus.success)
            .copyWithClearError();
      },
    );
  }

  void clearError() {
    state = state.copyWithClearError();
  }

  void reset() {
    state = const BlockedPeriodMutationState();
  }
}
