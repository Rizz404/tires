import 'package:tires/features/availability/data/models/availability_calendar_model.dart';
import 'package:tires/features/availability/data/models/availability_date_model.dart';
import 'package:tires/features/availability/data/models/availability_day_model.dart';
import 'package:tires/features/availability/data/models/availability_slot_model.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';
import 'package:tires/features/availability/domain/entities/availability_date.dart';
import 'package:tires/features/availability/domain/entities/availability_day.dart';
import 'package:tires/features/availability/domain/entities/availability_slot.dart';

extension AvailabilityDayModelMapper on AvailabilityDayModel {
  AvailabilityDay toEntity() {
    return this;
  }
}

extension AvailabilityDayEntityMapper on AvailabilityDay {
  AvailabilityDayModel toModel() {
    return AvailabilityDayModel(
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

extension AvailabilityCalendarModelMapper on AvailabilityCalendarModel {
  AvailabilityCalendar toEntity() {
    return this;
  }
}

extension AvailabilityCalendarEntityMapper on AvailabilityCalendar {
  AvailabilityCalendarModel toModel() {
    return AvailabilityCalendarModel(
      days: days.map((day) => day.toModel()).toList(),
      currentMonth: currentMonth,
      previousMonth: previousMonth,
      nextMonth: nextMonth,
    );
  }
}

extension AvailabilityDateModelMapper on AvailabilityDateModel {
  AvailabilityDate toEntity() {
    return this;
  }
}

extension AvailabilityDateEntityMapper on AvailabilityDate {
  AvailabilityDateModel toModel() {
    return AvailabilityDateModel(
      date: date,
      availableHours: availableHours.map((slot) => slot.toModel()).toList(),
      hasAvailableSlots: hasAvailableSlots,
    );
  }
}

extension AvailabilitySlotModelMapper on AvailabilitySlotModel {
  AvailabilitySlot toEntity() {
    return this;
  }
}

extension AvailabilitySlotEntityMapper on AvailabilitySlot {
  AvailabilitySlotModel toModel() {
    return AvailabilitySlotModel(
      hour: hour,
      available: available,
      blockedBy: blockedBy,
    );
  }
}
