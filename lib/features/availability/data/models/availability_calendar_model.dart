import 'package:tires/features/availability/data/models/availability_day_model.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';

class AvailabilityCalendarModel extends AvailabilityCalendar {
  const AvailabilityCalendarModel({
    required super.days,
    required super.currentMonth,
    required super.previousMonth,
    required super.nextMonth,
  });

  factory AvailabilityCalendarModel.fromMap(Map<String, dynamic> map) {
    final dataMap = map['data'] as Map<String, dynamic>;

    return AvailabilityCalendarModel(
      days: (dataMap['days'] as List)
          .map(
            (day) => AvailabilityDayModel.fromMap(day as Map<String, dynamic>),
          )
          .toList(),
      currentMonth: map['current_month'] as String,
      previousMonth: map['previous_month'] as String,
      nextMonth: map['next_month'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': {
        'days': days
            .map((day) => (day as AvailabilityDayModel).toMap())
            .toList(),
        'current_month': currentMonth,
        'previous_month': previousMonth,
        'next_month': nextMonth,
      },
      'current_month': currentMonth,
      'previous_month': previousMonth,
      'next_month': nextMonth,
    };
  }
}
