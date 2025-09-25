import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/calendar/domain/usecases/get_calendar_data_usecase.dart';
import 'package:tires/features/calendar/presentation/providers/calendar_state.dart';

class CalendarNotifier extends Notifier<CalendarState> {
  late GetCalendarDataUsecase _getCalendarDataUsecase;

  @override
  CalendarState build() {
    _getCalendarDataUsecase = ref.watch(getCalendarDataUsecaseProvider);
    return const CalendarState();
  }

  Future<void> getCalendarData({
    int? menuId,
    DateTime? month,
    GetCalendarDataParamsStatus? status,
    GetCalendarDataParamsView? view,
    bool forceRefresh = false,
  }) async {
    if (state.status == CalendarStatus.loading && !forceRefresh) return;

    AppLogger.uiInfo('Fetching calendar data in notifier');

    // Clear previous data when forcing refresh or changing view
    if (forceRefresh) {
      state = state.copyWith(
        status: CalendarStatus.loading,
        calendarData: null,
      );
    } else {
      state = state.copyWith(status: CalendarStatus.loading);
    }

    final params = GetCalendarDataParams(
      menuId: menuId,
      month: month,
      status: status,
      view: view,
    );

    final response = await _getCalendarDataUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch calendar data', failure);
        state = state.copyWith(
          status: CalendarStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Calendar data fetched successfully');
        state = state.copyWith(
          status: CalendarStatus.success,
          calendarData: success.data,
        );
      },
    );
  }

  void clearError() {
    state = state.copyWithClearError();
  }

  void reset() {
    state = const CalendarState();
  }
}
