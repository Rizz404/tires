import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_calendar_usecase.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_calendar_get_state.dart';

class ReservationCalendarGetNotifier
    extends Notifier<ReservationCalendarGetState> {
  late final GetReservationCalendarUsecase _getReservationCalendarUsecase;

  @override
  ReservationCalendarGetState build() {
    _getReservationCalendarUsecase = ref.watch(
      getReservationCalendarUsecaseProvider,
    );
    return const ReservationCalendarGetState();
  }

  Future<void> getInitialCalendar({
    String? month,
    required String menuId,
  }) async {
    AppLogger.uiInfo('Getting initial reservation calendar');
    await getReservationCalendar(month: month, menuId: menuId);
  }

  Future<void> getReservationCalendar({
    String? month,
    required String menuId,
  }) async {
    if (state.status == ReservationCalendarGetStatus.loading) return;

    AppLogger.uiInfo('Loading reservation calendar');
    state = state.copyWith(status: ReservationCalendarGetStatus.loading);

    final params = GetReservationCalendarParams(month: month, menuId: menuId);

    final response = await _getReservationCalendarUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load reservation calendar', failure);
        state = state.copyWith(
          status: ReservationCalendarGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully loaded reservation calendar');
        state = state
            .copyWith(
              status: ReservationCalendarGetStatus.success,
              calendar: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refreshCalendar({String? month, required String menuId}) async {
    AppLogger.uiInfo('Refreshing reservation calendar');
    await getReservationCalendar(month: month, menuId: menuId);
  }

  void clearState() {
    AppLogger.uiInfo('Clearing reservation calendar state');
    state = const ReservationCalendarGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing reservation calendar error');
      state = state.copyWithClearError();
    }
  }
}
