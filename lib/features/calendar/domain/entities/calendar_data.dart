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
  final List<CalendarReservation> reservations;
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
  final num totalReservations;
  final num pending;
  final num confirmed;
  final num completed;
  final num cancelled;

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

class CalendarReservation extends Equatable {
  final int id;
  final String reservationNumber;
  final CalendarCustomer customer;
  final String time;
  final String endTime;
  final String menuName;
  final String menuColor;
  final CalendarMenu menu;
  final String status;
  final int peopleCount;
  final String amount;

  const CalendarReservation({
    required this.id,
    required this.reservationNumber,
    required this.customer,
    required this.time,
    required this.endTime,
    required this.menuName,
    required this.menuColor,
    required this.menu,
    required this.status,
    required this.peopleCount,
    required this.amount,
  });

  @override
  List<Object?> get props => [
    id,
    reservationNumber,
    customer,
    time,
    endTime,
    menuName,
    menuColor,
    menu,
    status,
    peopleCount,
    amount,
  ];
}

class CalendarCustomer extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String type;

  const CalendarCustomer({
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
  });

  @override
  List<Object?> get props => [name, email, phone, type];
}

class CalendarMenu extends Equatable {
  final int id;
  final String name;
  final String description;
  final int requiredTime;
  final CalendarMenuPrice price;
  final String? photoPath;
  final int displayOrder;
  final bool isActive;
  final CalendarMenuColor color;
  final String createdAt;
  final String updatedAt;
  final Map<String, dynamic>? translations;
  final Map<String, dynamic>? meta;

  const CalendarMenu({
    required this.id,
    required this.name,
    required this.description,
    required this.requiredTime,
    required this.price,
    required this.photoPath,
    required this.displayOrder,
    required this.isActive,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
    required this.meta,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    requiredTime,
    price,
    photoPath,
    displayOrder,
    isActive,
    color,
    createdAt,
    updatedAt,
    translations,
    meta,
  ];
}

class CalendarMenuPrice extends Equatable {
  final String amount;
  final String formatted;
  final String currency;

  const CalendarMenuPrice({
    required this.amount,
    required this.formatted,
    required this.currency,
  });

  @override
  List<Object> get props => [amount, formatted, currency];
}

class CalendarMenuColor extends Equatable {
  final String hex;
  final String rgbaLight;
  final String textColor;

  const CalendarMenuColor({
    required this.hex,
    required this.rgbaLight,
    required this.textColor,
  });

  @override
  List<Object> get props => [hex, rgbaLight, textColor];
}
