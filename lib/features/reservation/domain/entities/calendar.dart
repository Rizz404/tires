// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/features/reservation/domain/entities/reservation_user.dart';

enum BookingStatus { available, past }

class Calendar extends Equatable {
  final String currentMonth;
  final String previousMonth;
  final String nextMonth;
  final List<Day> days;

  Calendar({
    required this.currentMonth,
    required this.previousMonth,
    required this.nextMonth,
    required this.days,
  });

  @override
  List<Object> get props => [currentMonth, previousMonth, nextMonth, days];
}

class Day extends Equatable {
  final DateTime date;
  final int day;
  final bool isCurrentMonth;
  final bool isToday;
  final bool isPastDate;
  final bool hasAvailableHours;
  final BookingStatus bookingStatus;
  final List<String> blockedHours; // * Contohnya "09:00", "10:00", "11:00",
  final int reservationCount;

  Day({
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

  @override
  List<Object> get props {
    return [
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
}
