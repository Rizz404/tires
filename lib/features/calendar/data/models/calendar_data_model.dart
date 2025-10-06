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
    required List<CalendarReservationModel> super.reservations,
    required super.totalReservations,
  });

  factory CalendarDayModel.fromMap(Map<String, dynamic> map) {
    return CalendarDayModel(
      date: (map['date'] as String?) ?? '',
      day: (map['day'] as num?) ?? 0,
      isCurrentMonth: (map['is_current_month'] as bool?) ?? false,
      isToday: (map['is_today'] as bool?) ?? false,
      dayName: (map['day_name'] as String?) ?? '',
      reservations: List<CalendarReservationModel>.from(
        (map['reservations'] as List<dynamic>).map(
          (x) => CalendarReservationModel.fromMap(x),
        ),
      ),
      totalReservations: (map['total_reservations'] as num?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'day': day,
      'is_current_month': isCurrentMonth,
      'is_today': isToday,
      'day_name': dayName,
      'reservations': (reservations as List<CalendarReservationModel>)
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
      totalReservations: (map['total_reservations'] as num?) ?? 0,
      pending: (map['pending'] as num?) ?? 0,
      confirmed: (map['confirmed'] as num?) ?? 0,
      completed: (map['completed'] as num?) ?? 0,
      cancelled: (map['cancelled'] as num?) ?? 0,
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

class CalendarReservationModel extends CalendarReservation {
  const CalendarReservationModel({
    required super.id,
    required super.reservationNumber,
    required CalendarCustomerModel super.customer,
    required super.time,
    required super.endTime,
    required super.menuName,
    required super.menuColor,
    required CalendarMenuModel super.menu,
    required super.status,
    required super.peopleCount,
    required super.amount,
  });

  factory CalendarReservationModel.fromMap(Map<String, dynamic> map) {
    return CalendarReservationModel(
      id: (map['id'] as int?) ?? 0,
      reservationNumber: (map['reservation_number'] as String?) ?? '',
      customer: CalendarCustomerModel.fromMap(map['customer']),
      time: (map['time'] as String?) ?? '',
      endTime: (map['end_time'] as String?) ?? '',
      menuName: (map['menu_name'] as String?) ?? '',
      menuColor: (map['menu_color'] as String?) ?? '',
      menu: CalendarMenuModel.fromMap(map['menu']),
      status: (map['status'] as String?) ?? '',
      peopleCount: (map['people_count'] as num?) ?? 0,
      amount: (map['amount'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation_number': reservationNumber,
      'customer': (customer as CalendarCustomerModel).toMap(),
      'time': time,
      'end_time': endTime,
      'menu_name': menuName,
      'menu_color': menuColor,
      'menu': (menu as CalendarMenuModel).toMap(),
      'status': status,
      'people_count': peopleCount,
      'amount': amount,
    };
  }
}

class CalendarCustomerModel extends CalendarCustomer {
  const CalendarCustomerModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.type,
  });

  factory CalendarCustomerModel.fromMap(Map<String, dynamic> map) {
    return CalendarCustomerModel(
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      type: (map['type'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'phone': phone, 'type': type};
  }
}

class CalendarMenuModel extends CalendarMenu {
  const CalendarMenuModel({
    required super.id,
    required super.name,
    required super.description,
    required super.requiredTime,
    required CalendarMenuPriceModel super.price,
    required super.photoPath,
    required super.displayOrder,
    required super.isActive,
    required CalendarMenuColorModel super.color,
    required super.createdAt,
    required super.updatedAt,
    required super.translations,
    required super.meta,
  });

  factory CalendarMenuModel.fromMap(Map<String, dynamic> map) {
    return CalendarMenuModel(
      id: (map['id'] as int?) ?? 0,
      name: (map['name'] as String?) ?? '',
      description: (map['description'] as String?) ?? '',
      requiredTime: (map['required_time'] as num?) ?? 0,
      price: CalendarMenuPriceModel.fromMap(map['price']),
      photoPath: map['photo_path'] as String?,
      displayOrder: (map['display_order'] as num?) ?? 0,
      isActive: (map['is_active'] as bool?) ?? true,
      color: CalendarMenuColorModel.fromMap(map['color']),
      createdAt: (map['created_at'] as String?) ?? '',
      updatedAt: (map['updated_at'] as String?) ?? '',
      translations: map['translations'] as Map<String, dynamic>?,
      meta: map['meta'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'required_time': requiredTime,
      'price': (price as CalendarMenuPriceModel).toMap(),
      'photo_path': photoPath,
      'display_order': displayOrder,
      'is_active': isActive,
      'color': (color as CalendarMenuColorModel).toMap(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'translations': translations,
      'meta': meta,
    };
  }
}

class CalendarMenuPriceModel extends CalendarMenuPrice {
  const CalendarMenuPriceModel({
    required super.amount,
    required super.formatted,
    required super.currency,
  });

  factory CalendarMenuPriceModel.fromMap(Map<String, dynamic> map) {
    return CalendarMenuPriceModel(
      amount: (map['amount'] as String?) ?? '',
      formatted: (map['formatted'] as String?) ?? '',
      currency: (map['currency'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'amount': amount, 'formatted': formatted, 'currency': currency};
  }
}

class CalendarMenuColorModel extends CalendarMenuColor {
  const CalendarMenuColorModel({
    required super.hex,
    required super.rgbaLight,
    required super.textColor,
  });

  factory CalendarMenuColorModel.fromMap(Map<String, dynamic> map) {
    return CalendarMenuColorModel(
      hex: (map['hex'] as String?) ?? '',
      rgbaLight: (map['rgba_light'] as String?) ?? '',
      textColor: (map['text_color'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'hex': hex, 'rgba_light': rgbaLight, 'text_color': textColor};
  }
}
