import 'dart:convert';

import 'package:tires/features/calendar/domain/entities/calendar_data.dart';

class CalendarDataModel extends CalendarData {
  const CalendarDataModel({
    required super.view,
    required CurrentPeriodModel super.currentPeriod,
    required NavigationModel super.navigation,
    required List<CalendarDayModel> super.calendarData,
    required StatisticsModel super.statistics,
  });

  factory CalendarDataModel.fromMap(Map<String, dynamic> map) {
    return CalendarDataModel(
      view: (map['view'] as String?) ?? '',
      currentPeriod: CurrentPeriodModel.fromMap(map['current_period']),
      navigation: NavigationModel.fromMap(map['navigation']),
      calendarData: List<CalendarDayModel>.from(
        (map['calendar_data'] as List<dynamic>).map(
          (x) => CalendarDayModel.fromMap(x),
        ),
      ),
      statistics: StatisticsModel.fromMap(map['statistics']),
    );
  }

  factory CalendarDataModel.fromJson(String source) =>
      CalendarDataModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'view': view,
      'current_period': (currentPeriod as CurrentPeriodModel).toMap(),
      'navigation': (navigation as NavigationModel).toMap(),
      'calendar_data': (calendarData as List<CalendarDayModel>)
          .map((x) => x.toMap())
          .toList(),
      'statistics': (statistics as StatisticsModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class CalendarDayModel extends CalendarDay {
  const CalendarDayModel({
    required super.date,
    required super.day,
    required super.isCurrentMonth,
    required super.isToday,
    required super.dayName,
    required List<ReservationModel> super.reservations,
    required super.totalReservations,
  });

  factory CalendarDayModel.fromMap(Map<String, dynamic> map) {
    return CalendarDayModel(
      date: (map['date'] as String?) ?? '',
      day: (map['day'] as int?) ?? 0,
      isCurrentMonth: (map['is_current_month'] as bool?) ?? false,
      isToday: (map['is_today'] as bool?) ?? false,
      dayName: (map['day_name'] as String?) ?? '',
      reservations: List<ReservationModel>.from(
        (map['reservations'] as List<dynamic>).map(
          (x) => ReservationModel.fromMap(x),
        ),
      ),
      totalReservations: (map['total_reservations'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'day': day,
      'is_current_month': isCurrentMonth,
      'is_today': isToday,
      'day_name': dayName,
      'reservations': (reservations as List<ReservationModel>)
          .map((x) => x.toMap())
          .toList(),
      'total_reservations': totalReservations,
    };
  }
}

class CurrentPeriodModel extends CurrentPeriod {
  const CurrentPeriodModel({
    required super.month,
    required super.startDate,
    required super.endDate,
  });

  factory CurrentPeriodModel.fromMap(Map<String, dynamic> map) {
    return CurrentPeriodModel(
      month: (map['month'] as String?) ?? '',
      startDate: (map['start_date'] as String?) ?? '',
      endDate: (map['end_date'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'month': month, 'start_date': startDate, 'end_date': endDate};
  }
}

class NavigationModel extends Navigation {
  const NavigationModel({
    required super.previousMonth,
    required super.nextMonth,
    required super.currentMonth,
  });

  factory NavigationModel.fromMap(Map<String, dynamic> map) {
    return NavigationModel(
      previousMonth: (map['previous_month'] as String?) ?? '',
      nextMonth: (map['next_month'] as String?) ?? '',
      currentMonth: (map['current_month'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'previous_month': previousMonth,
      'next_month': nextMonth,
      'current_month': currentMonth,
    };
  }
}

class StatisticsModel extends Statistics {
  const StatisticsModel({
    required super.totalReservations,
    required super.pending,
    required super.confirmed,
    required super.completed,
    required super.cancelled,
  });

  factory StatisticsModel.fromMap(Map<String, dynamic> map) {
    return StatisticsModel(
      totalReservations: (map['total_reservations'] as int?) ?? 0,
      pending: (map['pending'] as int?) ?? 0,
      confirmed: (map['confirmed'] as int?) ?? 0,
      completed: (map['completed'] as int?) ?? 0,
      cancelled: (map['cancelled'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total_reservations': totalReservations,
      'pending': pending,
      'confirmed': confirmed,
      'completed': completed,
      'cancelled': cancelled,
    };
  }
}

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.reservationNumber,
    super.customerName,
    required super.time,
    required super.endTime,
    required super.menuName,
    required super.menuColor,
    required super.status,
    required super.peopleCount,
    required super.amount,
  });

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: (map['id'] as int?) ?? 0,
      reservationNumber: (map['reservation_number'] as String?) ?? '',
      customerName: map['customer_name'] as String?,
      time: (map['time'] as String?) ?? '',
      endTime: (map['end_time'] as String?) ?? '',
      menuName: (map['menu_name'] as String?) ?? '',
      menuColor: (map['menu_color'] as String?) ?? '',
      status: (map['status'] as String?) ?? '',
      peopleCount: (map['people_count'] as int?) ?? 0,
      amount: (map['amount'] as String?) ?? '0.00',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation_number': reservationNumber,
      'customer_name': customerName,
      'time': time,
      'end_time': endTime,
      'menu_name': menuName,
      'menu_color': menuColor,
      'status': status,
      'people_count': peopleCount,
      'amount': amount,
    };
  }
}
