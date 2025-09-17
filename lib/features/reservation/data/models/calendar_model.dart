import 'dart:convert';

import 'package:tires/features/reservation/data/mapper/calendar_mapper.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart';

class CalendarModel extends Calendar {
  CalendarModel({
    required super.currentMonth,
    required super.previousMonth,
    required super.nextMonth,
    required super.days,
  });

  CalendarModel copyWith({
    String? currentMonth,
    String? previousMonth,
    String? nextMonth,
    List<DayModel>? days,
  }) {
    return CalendarModel(
      currentMonth: currentMonth ?? this.currentMonth,
      previousMonth: previousMonth ?? this.previousMonth,
      nextMonth: nextMonth ?? this.nextMonth,
      days: days ?? this.days,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_month': currentMonth,
      'previous_month': previousMonth,
      'next_month': nextMonth,
      'days': (days as List<DayModel>).map((day) => day.toMap()).toList(),
    };
  }

  factory CalendarModel.fromMap(Map<String, dynamic> map) {
    final daysData = (map['days'] as List<dynamic>?) ?? <dynamic>[];

    return CalendarModel(
      currentMonth:
          (map['current_month'] ?? map['currentMonth'] as String?) ?? '',
      previousMonth:
          (map['previous_month'] ?? map['previousMonth'] as String?) ?? '',
      nextMonth: (map['next_month'] ?? map['nextMonth'] as String?) ?? '',
      days: daysData
          .map((day) => DayModel.fromMap(day as Map<String, dynamic>))
          .toList(),
    );
  }

  factory CalendarModel.fromEntity(Calendar entity) {
    return CalendarModel(
      currentMonth: entity.currentMonth,
      previousMonth: entity.previousMonth,
      nextMonth: entity.nextMonth,
      days: entity.days.map((day) => day.toModel()).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarModel.fromJson(String source) =>
      CalendarModel.fromMap(json.decode(source));

  @override
  String toString() => 'CalendarModel(${toMap()})';
}

class DayModel extends Day {
  DayModel({
    required super.date,
    required super.day,
    required super.isCurrentMonth,
    required super.isToday,
    required super.isPastDate,
    required super.hasAvailableHours,
    required super.bookingStatus,
    required super.blockedHours,
    required super.reservationCount,
  });

  DayModel copyWith({
    DateTime? date,
    int? day,
    bool? isCurrentMonth,
    bool? isToday,
    bool? isPastDate,
    bool? hasAvailableHours,
    BookingStatus? bookingStatus,
    List<String>? blockedHours,
    int? reservationCount,
  }) {
    return DayModel(
      date: date ?? this.date,
      day: day ?? this.day,
      isCurrentMonth: isCurrentMonth ?? this.isCurrentMonth,
      isToday: isToday ?? this.isToday,
      isPastDate: isPastDate ?? this.isPastDate,
      hasAvailableHours: hasAvailableHours ?? this.hasAvailableHours,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      blockedHours: blockedHours ?? this.blockedHours,
      reservationCount: reservationCount ?? this.reservationCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'day': day,
      'is_current_month': isCurrentMonth,
      'is_today': isToday,
      'is_past_date': isPastDate,
      'has_available_hours': hasAvailableHours,
      'booking_status': _bookingStatusToString(bookingStatus),
      'blocked_hours': blockedHours,
      'reservation_count': reservationCount,
    };
  }

  factory DayModel.fromMap(Map<String, dynamic> map) {
    final blockedHoursData =
        (map['blocked_hours'] as List<dynamic>?) ?? <dynamic>[];

    final dateValue =
        DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now();

    // Fix: Handle both snake_case and camelCase for booking_status/bookingStatus
    final bookingStatusString =
        (map['booking_status'] ?? map['bookingStatus'] as String?) ??
        'available';

    return DayModel(
      date: dateValue,
      day: (map['day'] as int?) ?? 1,
      isCurrentMonth:
          (map['is_current_month'] ?? map['isCurrentMonth'] as bool?) ?? true,
      isToday: (map['is_today'] ?? map['isToday'] as bool?) ?? false,
      isPastDate: (map['is_past_date'] ?? map['isPastDate'] as bool?) ?? false,
      hasAvailableHours:
          (map['has_available_hours'] ?? map['hasAvailableHours'] as bool?) ??
          false,
      bookingStatus: _parseBookingStatus(bookingStatusString),
      blockedHours: blockedHoursData.cast<String>(),
      reservationCount:
          (map['reservation_count'] ?? map['reservationCount'] as int?) ?? 0,
    );
  }

  factory DayModel.fromEntity(Day entity) {
    return DayModel(
      date: entity.date,
      day: entity.day,
      isCurrentMonth: entity.isCurrentMonth,
      isToday: entity.isToday,
      isPastDate: entity.isPastDate,
      hasAvailableHours: entity.hasAvailableHours,
      bookingStatus: entity.bookingStatus,
      blockedHours: entity.blockedHours,
      reservationCount: entity.reservationCount,
    );
  }

  String toJson() => json.encode(toMap());

  factory DayModel.fromJson(String source) =>
      DayModel.fromMap(json.decode(source));

  @override
  String toString() => 'DayModel(${toMap()})';

  static BookingStatus _parseBookingStatus(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return BookingStatus.available;
      case 'past':
        return BookingStatus.past;
      default:
        return BookingStatus.available;
    }
  }

  static String _bookingStatusToString(BookingStatus status) {
    switch (status) {
      case BookingStatus.available:
        return 'available';
      case BookingStatus.past:
        return 'past';
    }
  }
}
