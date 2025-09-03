import 'dart:convert';

import 'package:tires/features/reservation/data/mapper/calendar_mapper.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

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
    DebugHelper.traceModelCreation('CalendarModel', map);

    final daysData =
        DebugHelper.safeCast<List>(
          map['days'],
          'days',
          defaultValue: <dynamic>[],
        ) ??
        <dynamic>[];

    return CalendarModel(
      currentMonth:
          DebugHelper.safeCast<String>(
            map['current_month'] ?? map['currentMonth'],
            'current_month',
            defaultValue: '',
          ) ??
          '',
      previousMonth:
          DebugHelper.safeCast<String>(
            map['previous_month'] ?? map['previousMonth'],
            'previous_month',
            defaultValue: '',
          ) ??
          '',
      nextMonth:
          DebugHelper.safeCast<String>(
            map['next_month'] ?? map['nextMonth'],
            'next_month',
            defaultValue: '',
          ) ??
          '',
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
    DebugHelper.traceModelCreation('DayModel', map);

    final blockedHoursData =
        DebugHelper.safeCast<List>(
          map['blocked_hours'],
          'blocked_hours',
          defaultValue: <dynamic>[],
        ) ??
        <dynamic>[];

    final dateValue =
        DebugHelper.safeParseDateTime(map['date'], 'date') ?? DateTime.now();

    // Fix: Handle both snake_case and camelCase for booking_status/bookingStatus
    final bookingStatusString =
        DebugHelper.safeCast<String>(
          map['booking_status'] ?? map['bookingStatus'],
          'booking_status',
          defaultValue: 'available',
        ) ??
        'available';

    return DayModel(
      date: dateValue,
      day: DebugHelper.safeCast<int>(map['day'], 'day', defaultValue: 1) ?? 1,
      isCurrentMonth:
          DebugHelper.safeCast<bool>(
            map['is_current_month'] ?? map['isCurrentMonth'],
            'is_current_month',
            defaultValue: true,
          ) ??
          true,
      isToday:
          DebugHelper.safeCast<bool>(
            map['is_today'] ?? map['isToday'],
            'is_today',
            defaultValue: false,
          ) ??
          false,
      isPastDate:
          DebugHelper.safeCast<bool>(
            map['is_past_date'] ?? map['isPastDate'],
            'is_past_date',
            defaultValue: false,
          ) ??
          false,
      hasAvailableHours:
          DebugHelper.safeCast<bool>(
            map['has_available_hours'] ?? map['hasAvailableHours'],
            'has_available_hours',
            defaultValue: false,
          ) ??
          false,
      bookingStatus: _parseBookingStatus(bookingStatusString),
      blockedHours: blockedHoursData.cast<String>(),
      reservationCount:
          DebugHelper.safeCast<int>(
            map['reservation_count'] ?? map['reservationCount'],
            'reservation_count',
            defaultValue: 0,
          ) ??
          0,
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
