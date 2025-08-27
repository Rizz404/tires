import 'package:equatable/equatable.dart';
import 'package:tires/features/availability/domain/entities/availability_day.dart';

class AvailabilityCalendar extends Equatable {
  final List<AvailabilityDay> days;
  final String currentMonth;
  final String previousMonth;
  final String nextMonth;

  const AvailabilityCalendar({
    required this.days,
    required this.currentMonth,
    required this.previousMonth,
    required this.nextMonth,
  });

  AvailabilityCalendar copyWith({
    List<AvailabilityDay>? days,
    String? currentMonth,
    String? previousMonth,
    String? nextMonth,
  }) {
    return AvailabilityCalendar(
      days: days ?? this.days,
      currentMonth: currentMonth ?? this.currentMonth,
      previousMonth: previousMonth ?? this.previousMonth,
      nextMonth: nextMonth ?? this.nextMonth,
    );
  }

  @override
  List<Object?> get props => [
        days,
        currentMonth,
        previousMonth,
        nextMonth,
      ];
}
