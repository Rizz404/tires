import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/availability/domain/usecases/get_reservation_availability_usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/availability/presentation/providers/reservation_availability_state.dart';

class ReservationAvailabilityNotifier
    extends Notifier<ReservationAvailabilityState> {
  late GetReservationAvailabilityUsecase _getReservationAvailabilityUsecase;

  @override
  ReservationAvailabilityState build() {
    _getReservationAvailabilityUsecase = ref.watch(
      getReservationAvailabilityUsecaseProvider,
    );
    return const ReservationAvailabilityState();
  }

  Future<void> getReservationAvailability({
    required int menuId,
    required DateTime startDate,
    required DateTime endDate,
    int? excludeReservationId,
  }) async {
    AppLogger.uiInfo('Getting reservation availability');

    // Only fetch if we don't have data for this menu and date range
    if (state.currentMenuId == menuId &&
        state.startDate == startDate &&
        state.endDate == endDate &&
        state.excludeReservationId == excludeReservationId) {
      return;
    }

    state = state.copyWith(
      status: ReservationAvailabilityStatus.loading,
      currentMenuId: menuId,
      startDate: startDate,
      endDate: endDate,
      excludeReservationId: excludeReservationId,
    );

    final params = GetReservationAvailabilityParams(
      menuId: menuId,
      startDate: startDate,
      endDate: endDate,
      excludeReservationId: excludeReservationId,
    );

    final response = await _getReservationAvailabilityUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to get reservation availability', failure);
        state = state.copyWith(
          status: ReservationAvailabilityStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Reservation availability loaded successfully');
        state = state
            .copyWith(
              status: ReservationAvailabilityStatus.success,
              availabilityDates: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refreshReservationAvailability({
    required int menuId,
    required DateTime startDate,
    required DateTime endDate,
    int? excludeReservationId,
  }) async {
    AppLogger.uiInfo('Refreshing reservation availability');

    state = state.copyWith(
      status: ReservationAvailabilityStatus.loading,
      currentMenuId: menuId,
      startDate: startDate,
      endDate: endDate,
      excludeReservationId: excludeReservationId,
    );

    final params = GetReservationAvailabilityParams(
      menuId: menuId,
      startDate: startDate,
      endDate: endDate,
      excludeReservationId: excludeReservationId,
    );

    final response = await _getReservationAvailabilityUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError(
          'Failed to refresh reservation availability',
          failure,
        );
        state = state.copyWith(
          status: ReservationAvailabilityStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Reservation availability refreshed successfully');
        state = state
            .copyWith(
              status: ReservationAvailabilityStatus.success,
              availabilityDates: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  void clearState() {
    AppLogger.uiInfo('Clearing reservation availability state');
    state = const ReservationAvailabilityState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing reservation availability error');
      state = state.copyWithClearError();
    }
  }
}
