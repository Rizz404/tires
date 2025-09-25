import 'package:equatable/equatable.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';

enum CalendarStatus { initial, loading, success, error }

class CalendarState extends Equatable {
  final CalendarStatus status;
  final CalendarData? calendarData;
  final String? errorMessage;

  const CalendarState({
    this.status = CalendarStatus.initial,
    this.calendarData,
    this.errorMessage,
  });

  CalendarState copyWith({
    CalendarStatus? status,
    CalendarData? calendarData,
    String? errorMessage,
  }) {
    return CalendarState(
      status: status ?? this.status,
      calendarData: calendarData ?? this.calendarData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  CalendarState copyWithClearError() {
    return CalendarState(
      status: status,
      calendarData: calendarData,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, calendarData, errorMessage];
}
