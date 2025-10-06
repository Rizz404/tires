import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/calendar/presentation/providers/calendar_providers.dart';
import 'package:tires/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/update_reservation_usecase.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_mutation_state.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_providers.dart';
import 'package:tires/features/dashboard/presentation/providers/dashboard_providers.dart';

class ReservationMutationNotifier extends Notifier<ReservationMutationState> {
  late CreateReservationUsecase _createReservationUsecase;
  late UpdateReservationUsecase _updateReservationUsecase;
  late DeleteReservationUsecase _deleteReservationUsecase;

  @override
  ReservationMutationState build() {
    _createReservationUsecase = ref.watch(createReservationUsecaseProvider);
    _updateReservationUsecase = ref.watch(updateReservationUsecaseProvider);
    _deleteReservationUsecase = ref.watch(deleteReservationUsecaseProvider);
    return const ReservationMutationState();
  }

  Future<void> createReservation({
    required int menuId,
    required DateTime reservationDatetime,
    int? numberOfPeople,
    required int amount,
  }) async {
    AppLogger.uiInfo('Creating reservation in notifier');
    state = state.copyWith(status: ReservationMutationStatus.loading);

    final params = CreateReservationParams(
      menuId: menuId,
      reservationDatetime: reservationDatetime,
      amount: amount,
      numberOfPeople: numberOfPeople ?? 1,
    );
    final response = await _createReservationUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to create reservation', failure);
        state = state.copyWith(
          status: ReservationMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully created reservation');
        state = state
            .copyWith(
              status: ReservationMutationStatus.success,
              reservation: success.data,
              successMessage:
                  success.message ?? 'Reservation created successfully',
            )
            .copyWithClearError();
        ref.invalidate(reservationGetNotifierProvider);
        ref.invalidate(reservationCalendarGetNotifierProvider);
        ref.invalidate(reservationAvailableHoursGetNotifierProvider);
        ref.invalidate(currentUserReservationsGetNotifierProvider);
        ref.invalidate(calendarNotifierProvider);
        ref.invalidate(dashboardNotifierProvider);
      },
    );
  }

  Future<void> updateReservation(UpdateReservationParams params) async {
    AppLogger.uiInfo('Updating reservation in notifier');
    state = state.copyWith(status: ReservationMutationStatus.loading);

    final response = await _updateReservationUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to update reservation', failure);
        state = state.copyWith(
          status: ReservationMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully updated reservation');
        state = state
            .copyWith(
              status: ReservationMutationStatus.success,
              reservation: success.data,
              successMessage:
                  success.message ?? 'Reservation updated successfully',
            )
            .copyWithClearError();
        ref.invalidate(reservationGetNotifierProvider);
        ref.invalidate(reservationCalendarGetNotifierProvider);
        ref.invalidate(reservationAvailableHoursGetNotifierProvider);
        ref.invalidate(currentUserReservationsGetNotifierProvider);
        ref.invalidate(calendarNotifierProvider);
        ref.invalidate(dashboardNotifierProvider);
      },
    );
  }

  Future<void> deleteReservation({required int id}) async {
    AppLogger.uiInfo('Deleting reservation in notifier');
    state = state.copyWith(status: ReservationMutationStatus.loading);

    final params = DeleteReservationParams(id: id);
    final response = await _deleteReservationUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to delete reservation', failure);
        state = state.copyWith(
          status: ReservationMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully deleted reservation');
        state = state
            .copyWith(
              status: ReservationMutationStatus.success,
              reservation: success.data,
              successMessage:
                  success.message ?? 'Reservation deleted successfully',
            )
            .copyWithClearError();
        ref.invalidate(reservationGetNotifierProvider);
        ref.invalidate(reservationCalendarGetNotifierProvider);
        ref.invalidate(reservationAvailableHoursGetNotifierProvider);
        ref.invalidate(currentUserReservationsGetNotifierProvider);
        ref.invalidate(calendarNotifierProvider);
        ref.invalidate(dashboardNotifierProvider);
      },
    );
  }

  void clearState() {
    AppLogger.uiInfo('Clearing reservation mutation state');
    state = const ReservationMutationState();
  }

  void clearError() {
    if (state.failure != null) {
      AppLogger.uiInfo('Clearing reservation mutation error');
      state = state.copyWithClearError();
    }
  }

  void clearSuccess() {
    if (state.successMessage != null) {
      AppLogger.uiInfo('Clearing reservation mutation success message');
      state = state.copyWithClearSuccess();
    }
  }
}
