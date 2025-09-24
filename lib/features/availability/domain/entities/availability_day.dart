import 'package:equatable/equatable.dart';

class AvailabilityDay extends Equatable {
  final String date;
  final int day;
  final bool isCurrentMonth;
  final bool isToday;
  final bool isPastDate;
  final bool hasAvailableHours;
  final String bookingStatus;
  final List<String> blockedHours;
  final int reservationCount;

  const AvailabilityDay({
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

  AvailabilityDay copyWith({
    String? date,
    int? day,
    bool? isCurrentMonth,
    bool? isToday,
    bool? isPastDate,
    bool? hasAvailableHours,
    String? bookingStatus,
    List<String>? blockedHours,
    int? reservationCount,
  }) {
    return AvailabilityDay(
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
