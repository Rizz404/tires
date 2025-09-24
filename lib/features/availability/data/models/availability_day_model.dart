import 'package:tires/features/availability/domain/entities/availability_day.dart';

class AvailabilityDayModel extends AvailabilityDay {
  const AvailabilityDayModel({
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

  factory AvailabilityDayModel.fromMap(Map<String, dynamic> map) {
    return AvailabilityDayModel(
      date: map['date'] as String,
      day: map['day'] as int,
      isCurrentMonth: map['is_current_month'] as bool,
      isToday: map['is_today'] as bool,
      isPastDate: map['is_past_date'] as bool,
      hasAvailableHours: map['has_available_hours'] as bool,
      bookingStatus: map['booking_status'] as String,
      blockedHours: List<String>.from(map['blocked_hours'] as List),
      reservationCount: map['reservation_count'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'day': day,
      'is_current_month': isCurrentMonth,
      'is_today': isToday,
      'is_past_date': isPastDate,
      'has_available_hours': hasAvailableHours,
      'booking_status': bookingStatus,
      'blocked_hours': blockedHours,
      'reservation_count': reservationCount,
    };
  }
}
