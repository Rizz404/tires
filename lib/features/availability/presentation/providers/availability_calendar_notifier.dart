import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/availability/domain/usecases/get_availability_calendar_usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/availability/presentation/providers/availability_calendar_state.dart';

class AvailabilityCalendarNotifier extends Notifier<AvailabilityCalendarState> {
  late GetAvailabilityCalendarUsecase _getAvailabilityCalendarUsecase;

  @override
  AvailabilityCalendarState build() {
    _getAvailabilityCalendarUsecase = ref.watch(
      getAvailabilityCalendarUsecaseProvider,
    );
    return const AvailabilityCalendarState();
  }

  Future<void> getAvailabilityCalendar({
    required String menuId,
    DateTime? targetMonth,
  }) async {
    AppLogger.uiInfo('Getting availability calendar');
    final currentMonth = targetMonth ?? DateTime.now();
    final monthString = DateFormat('yyyy-MM').format(currentMonth);

    // Only fetch if we don't have data for this menu and month
    if (state.currentMenuId == menuId && state.currentMonth == monthString) {
      return;
    }

    state = state.copyWith(
      status: AvailabilityCalendarStatus.loading,
      currentMenuId: menuId,
      currentMonth: monthString,
    );

    final params = GetAvailabilityCalendarParams(
      menuId: menuId,
      currentMonth: monthString,
      paginate: true,
    );

    final response = await _getAvailabilityCalendarUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to get availability calendar', failure);
        state = state.copyWith(
          status: AvailabilityCalendarStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Availability calendar loaded successfully');
        state = state
            .copyWith(
              status: AvailabilityCalendarStatus.success,
              availabilityCalendar: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refreshAvailabilityCalendar({
    required String menuId,
    DateTime? targetMonth,
  }) async {
    AppLogger.uiInfo('Refreshing availability calendar');
    final currentMonth = targetMonth ?? DateTime.now();
    final monthString = DateFormat('yyyy-MM').format(currentMonth);

    state = state.copyWith(
      status: AvailabilityCalendarStatus.loading,
      currentMenuId: menuId,
      currentMonth: monthString,
    );

    final params = GetAvailabilityCalendarParams(
      menuId: menuId,
      currentMonth: monthString,
      paginate: true,
    );

    final response = await _getAvailabilityCalendarUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to refresh availability calendar', failure);
        state = state.copyWith(
          status: AvailabilityCalendarStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Availability calendar refreshed successfully');
        state = state
            .copyWith(
              status: AvailabilityCalendarStatus.success,
              availabilityCalendar: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  void clearState() {
    AppLogger.uiInfo('Clearing availability calendar state');
    state = const AvailabilityCalendarState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing availability calendar error');
      state = state.copyWithClearError();
    }
  }
}
