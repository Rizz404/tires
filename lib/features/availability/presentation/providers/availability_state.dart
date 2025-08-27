import 'package:equatable/equatable.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';

enum AvailabilityStatus { initial, loading, success, error }

class AvailabilityState extends Equatable {
  final AvailabilityStatus status;
  final AvailabilityCalendar? availabilityCalendar;
  final String? errorMessage;
  final String? currentMenuId;
  final String? currentMonth;

  const AvailabilityState({
    this.status = AvailabilityStatus.initial,
    this.availabilityCalendar,
    this.errorMessage,
    this.currentMenuId,
    this.currentMonth,
  });

  AvailabilityState copyWith({
    AvailabilityStatus? status,
    AvailabilityCalendar? availabilityCalendar,
    String? errorMessage,
    String? currentMenuId,
    String? currentMonth,
  }) {
    return AvailabilityState(
      status: status ?? this.status,
      availabilityCalendar: availabilityCalendar ?? this.availabilityCalendar,
      errorMessage: errorMessage ?? this.errorMessage,
      currentMenuId: currentMenuId ?? this.currentMenuId,
      currentMonth: currentMonth ?? this.currentMonth,
    );
  }

  AvailabilityState copyWithClearError() {
    return AvailabilityState(
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
