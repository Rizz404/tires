import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/features/availability/domain/usecases/get_availability_calendar_usecase.dart';
import 'package:tires/features/availability/presentation/providers/availability_provider.dart';
import 'package:tires/features/availability/presentation/providers/availability_state.dart';

class AvailabilityNotifier extends Notifier<AvailabilityState> {
  late GetAvailabilityCalendarUsecase _getAvailabilityCalendarUsecase;

  @override
  AvailabilityState build() {
    _getAvailabilityCalendarUsecase = ref.watch(
      getAvailabilityCalendarUsecaseProvider,
    );
    return const AvailabilityState();
  }

  Future<void> getAvailabilityCalendar({
    required String menuId,
    DateTime? targetMonth,
  }) async {
    final currentMonth = targetMonth ?? DateTime.now();
    final monthString = DateFormat('yyyy-MM').format(currentMonth);

    // Only fetch if we don't have data for this menu and month
    if (state.currentMenuId == menuId && state.currentMonth == monthString) {
      return;
    }

    state = state.copyWith(
      status: AvailabilityStatus.loading,
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
        state = state.copyWith(
          status: AvailabilityStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: AvailabilityStatus.success,
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
    final currentMonth = targetMonth ?? DateTime.now();
    final monthString = DateFormat('yyyy-MM').format(currentMonth);

    state = state.copyWith(
      status: AvailabilityStatus.loading,
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
        state = state.copyWith(
          status: AvailabilityStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: AvailabilityStatus.success,
              availabilityCalendar: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  void clearState() {
    state = const AvailabilityState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
