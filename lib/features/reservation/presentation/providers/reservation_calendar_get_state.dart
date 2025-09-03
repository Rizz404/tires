import 'package:equatable/equatable.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart';

enum ReservationCalendarGetStatus { initial, loading, success, error }

class ReservationCalendarGetState extends Equatable {
  final ReservationCalendarGetStatus status;
  final Calendar? calendar;
  final String? errorMessage;

  const ReservationCalendarGetState({
    this.status = ReservationCalendarGetStatus.initial,
    this.calendar,
    this.errorMessage,
  });

  ReservationCalendarGetState copyWith({
    ReservationCalendarGetStatus? status,
    Calendar? calendar,
    String? errorMessage,
  }) {
    return ReservationCalendarGetState(
      status: status ?? this.status,
      calendar: calendar ?? this.calendar,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  ReservationCalendarGetState copyWithClearError() {
    return ReservationCalendarGetState(
      status: status,
      calendar: calendar,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, calendar, errorMessage];
}
