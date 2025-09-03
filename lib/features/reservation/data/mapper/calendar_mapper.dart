import 'package:tires/features/reservation/data/models/calendar_model.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart';

// Calendar mappers
extension CalendarModelMapper on CalendarModel {
  Calendar toEntity() {
    return Calendar(
      currentMonth: currentMonth,
      previousMonth: previousMonth,
      nextMonth: nextMonth,
      days: (days as List<DayModel>).map((day) => day.toEntity()).toList(),
    );
  }
}

extension CalendarEntityMapper on Calendar {
  CalendarModel toModel() {
    return CalendarModel.fromEntity(this);
  }
}

// Day mappers
extension DayModelMapper on DayModel {
  Day toEntity() {
    return Day(
      date: date,
      day: day,
      isCurrentMonth: isCurrentMonth,
      isToday: isToday,
      isPastDate: isPastDate,
      hasAvailableHours: hasAvailableHours,
      bookingStatus: bookingStatus,
      blockedHours: blockedHours,
      reservationCount: reservationCount,
    );
  }
}

extension DayEntityMapper on Day {
  DayModel toModel() {
    return DayModel.fromEntity(this);
  }
}
