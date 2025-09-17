import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_available_hours_usecase.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_available_hours_get_state.dart';

class ReservationAvailableHoursGetNotifier
    extends Notifier<ReservationAvailableHoursGetState> {
  late final GetReservationAvailableHoursUsecase
  _getReservationAvailableHoursUsecase;

  @override
  ReservationAvailableHoursGetState build() {
    _getReservationAvailableHoursUsecase = ref.watch(
      getReservationAvailableHoursUsecaseProvider,
    );
    return const ReservationAvailableHoursGetState();
  }

  Future<void> getInitialAvailableHours({
    required String date,
    required String menuId,
  }) async {
    AppLogger.uiInfo('Getting initial reservation available hours');
    await getAvailableHours(date: date, menuId: menuId);
  }

  Future<void> getAvailableHours({
    required String date,
    required String menuId,
  }) async {
    // Prevent duplicate loading if already in progress
    if (state.status == ReservationAvailableHoursGetStatus.loading) return;

    AppLogger.uiInfo('Loading reservation available hours');
    state = state.copyWith(status: ReservationAvailableHoursGetStatus.loading);

    final params = GetReservationAvailableHoursParams(
      date: date,
      menuId: menuId,
    );

    final response = await _getReservationAvailableHoursUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError(
          'Failed to load reservation available hours',
          failure,
        );
        state = state.copyWith(
          status: ReservationAvailableHoursGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully loaded reservation available hours');
        state = state
            .copyWith(
              status: ReservationAvailableHoursGetStatus.success,
              availableHour: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refreshAvailableHours({
    required String date,
    required String menuId,
  }) async {
    AppLogger.uiInfo('Refreshing reservation available hours');
    await getAvailableHours(date: date, menuId: menuId);
  }

  void clearState() {
    AppLogger.uiInfo('Clearing reservation available hours state');
    state = const ReservationAvailableHoursGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing reservation available hours error');
      state = state.copyWithClearError();
    }
  }
}
