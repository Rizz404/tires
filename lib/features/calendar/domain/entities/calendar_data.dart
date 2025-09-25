import 'package:equatable/equatable.dart';

class CalendarData extends Equatable {
  final String view;
  final CurrentPeriod currentPeriod;
  final Navigation navigation;
  final List<CalendarDay> calendarData;
  final Statistics statistics;

  const CalendarData({
    required this.view,
    required this.currentPeriod,
    required this.navigation,
    required this.calendarData,
    required this.statistics,
  });

  @override
  List<Object> get props => [
    view,
    currentPeriod,
    navigation,
    calendarData,
    statistics,
  ];
}

class CalendarDay extends Equatable {
  final String date;
  final int day;
  final bool isCurrentMonth;
  final bool isToday;
  final String dayName;
  final List<Reservation> reservations;
  final int totalReservations;

  const CalendarDay({
    required this.date,
    required this.day,
    required this.isCurrentMonth,
    required this.isToday,
    required this.dayName,
    required this.reservations,
    required this.totalReservations,
  });

  @override
  List<Object> get props => [
    date,
    day,
    isCurrentMonth,
    isToday,
    dayName,
    reservations,
    totalReservations,
  ];
}

class CurrentPeriod extends Equatable {
  final String month;
  final String startDate;
  final String endDate;

  const CurrentPeriod({
    required this.month,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [month, startDate, endDate];
}

class Navigation extends Equatable {
  final String previousMonth;
  final String nextMonth;
  final String currentMonth;

  const Navigation({
    required this.previousMonth,
    required this.nextMonth,
    required this.currentMonth,
  });

  @override
  List<Object> get props => [previousMonth, nextMonth, currentMonth];
}

class Statistics extends Equatable {
  final int totalReservations;
  final int pending;
  final int confirmed;
  final int completed;
  final int cancelled;

  const Statistics({
    required this.totalReservations,
    required this.pending,
    required this.confirmed,
    required this.completed,
    required this.cancelled,
  });

  @override
  List<Object> get props => [
    totalReservations,
    pending,
    confirmed,
    completed,
    cancelled,
  ];
}

class Reservation extends Equatable {
  final int id;
  final String reservationNumber;
  final String? customerName;
  final String time;
  final String endTime;
  final String menuName;
  final String menuColor;
  final String status;
  final int peopleCount;
  final String amount;

  const Reservation({
    required this.id,
    required this.reservationNumber,
    this.customerName,
    required this.time,
    required this.endTime,
    required this.menuName,
    required this.menuColor,
    required this.status,
    required this.peopleCount,
    required this.amount,
  });

  @override
  List<Object?> get props => [
    id,
    reservationNumber,
    customerName,
    time,
    endTime,
    menuName,
    menuColor,
    status,
    peopleCount,
    amount,
  ];
}
