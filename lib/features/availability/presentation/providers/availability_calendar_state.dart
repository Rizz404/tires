import 'package:equatable/equatable.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';

enum AvailabilityCalendarStatus { initial, loading, success, error }

class AvailabilityCalendarState extends Equatable {
  final AvailabilityCalendarStatus status;
  final AvailabilityCalendar? availabilityCalendar;
  final String? errorMessage;
  final String? currentMenuId;
  final String? currentMonth;

  const AvailabilityCalendarState({
    this.status = AvailabilityCalendarStatus.initial,
    this.availabilityCalendar,
    this.errorMessage,
    this.currentMenuId,
    this.currentMonth,
  });

  AvailabilityCalendarState copyWith({
    AvailabilityCalendarStatus? status,
    AvailabilityCalendar? availabilityCalendar,
    String? errorMessage,
    String? currentMenuId,
    String? currentMonth,
  }) {
    return AvailabilityCalendarState(
      status: status ?? this.status,
      availabilityCalendar: availabilityCalendar ?? this.availabilityCalendar,
      errorMessage: errorMessage ?? this.errorMessage,
      currentMenuId: currentMenuId ?? this.currentMenuId,
      currentMonth: currentMonth ?? this.currentMonth,
    );
  }

  AvailabilityCalendarState copyWithClearError() {
    return AvailabilityCalendarState(
      status: status,
      availabilityCalendar: availabilityCalendar,
      errorMessage: null,
      currentMenuId: currentMenuId,
      currentMonth: currentMonth,
    );
  }

  @override
  List<Object?> get props => [
    status,
    availabilityCalendar,
    errorMessage,
    currentMenuId,
    currentMonth,
  ];
}
