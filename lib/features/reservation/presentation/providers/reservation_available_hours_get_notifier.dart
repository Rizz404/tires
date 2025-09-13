import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_available_hours_usecase.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_available_hours_get_state.dart';

class ReservationAvailableHoursGetNotifier
    extends StateNotifier<ReservationAvailableHoursGetState> {
  final GetReservationAvailableHoursUsecase
  _getReservationAvailableHoursUsecase;

  ReservationAvailableHoursGetNotifier(
    this._getReservationAvailableHoursUsecase,
  ) : super(const ReservationAvailableHoursGetState()) {
    // Note: Available hours requires date and menuId parameters, so no automatic initialization
    // Will be called when date is selected
  }

  Future<void> getInitialAvailableHours({
    required String date,
    required String menuId,
  }) async {
    await getAvailableHours(date: date, menuId: menuId);
  }

  Future<void> getAvailableHours({
    required String date,
    required String menuId,
  }) async {
    // Prevent duplicate loading if already in progress
    if (state.status == ReservationAvailableHoursGetStatus.loading) return;

    state = state.copyWith(status: ReservationAvailableHoursGetStatus.loading);

    final params = GetReservationAvailableHoursParams(
      date: date,
      menuId: menuId,
    );

    final response = await _getReservationAvailableHoursUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: ReservationAvailableHoursGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
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
    await getAvailableHours(date: date, menuId: menuId);
  }

  void clearState() {
    state = const ReservationAvailableHoursGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
