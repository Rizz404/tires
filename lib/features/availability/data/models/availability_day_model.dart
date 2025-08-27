import 'package:equatable/equatable.dart';
import 'package:tires/features/availability/domain/entities/availability_day.dart';

class AvailabilityDayModel extends Equatable {
  final String date;
  final int day;
  final bool isCurrentMonth;
  final bool isToday;
  final bool isPastDate;
  final bool hasAvailableHours;
  final String bookingStatus;
  final List<String> blockedHours;
  final int reservationCount;

  const AvailabilityDayModel({
    required this.date,
    required this.day,
    required this.isCurrentMonth,
    required this.isToday,
    required this.isPastDate,
    required this.hasAvailableHours,
    required this.bookingStatus,
    required this.blockedHours,
    required this.reservationCount,
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

  AvailabilityDay toEntity() {
    return AvailabilityDay(
      date: date,
      day: day,
      isCurrentMonth: isCurrentMonth,
      isToday: isToday,
      isPastDate: isPastDate,
      hasAvailableHours: hasAvailableHours,
      bookingStatus: _parseBookingStatus(bookingStatus),
      blockedHours: blockedHours,
      reservationCount: reservationCount,
    );
  }

  BookingStatus _parseBookingStatus(String status) {
    switch (status.toLowerCase()) {
      case 'past':
        return BookingStatus.past;
      case 'available':
        return BookingStatus.available;
      case 'fully_booked':
        return BookingStatus.fullyBooked;
      case 'no_available_hours':
        return BookingStatus.noAvailableHours;
      default:
        return BookingStatus.noAvailableHours;
    }
  }

  @override
  List<Object?> get props => [
        date,
        day,
        isCurrentMonth,
        isToday,
        isPastDate,
        hasAvailableHours,
        bookingStatus,
        blockedHours,
        reservationCount,
      ];
}
