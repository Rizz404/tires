import 'package:tires/features/calendar/data/models/calendar_data_model.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';

extension CalendarDataModelMapper on CalendarDataModel {
  CalendarData toEntity() {
    return CalendarData(
      view: view,
      currentPeriod: (currentPeriod as CurrentPeriodModel).toEntity(),
      navigation: (navigation as NavigationModel).toEntity(),
      calendarData: (calendarData as List<CalendarDayModel>)
          .map((day) => day.toEntity())
          .toList(),
      statistics: (statistics as StatisticsModel).toEntity(),
    );
  }
}

extension CurrentPeriodModelMapper on CurrentPeriodModel {
  CurrentPeriod toEntity() {
    return CurrentPeriod(month: month, startDate: startDate, endDate: endDate);
  }
}

extension NavigationModelMapper on NavigationModel {
  Navigation toEntity() {
    return Navigation(
      previousMonth: previousMonth,
      nextMonth: nextMonth,
      currentMonth: currentMonth,
    );
  }
}

extension CalendarDayModelMapper on CalendarDayModel {
  CalendarDay toEntity() {
    return CalendarDay(
      date: date,
      day: day,
      isCurrentMonth: isCurrentMonth,
      isToday: isToday,
      dayName: dayName,
      reservations: (reservations as List<CalendarReservationModel>)
          .map((reservation) => reservation.toEntity())
          .toList(),
      totalReservations: totalReservations,
    );
  }
}

extension StatisticsModelMapper on StatisticsModel {
  Statistics toEntity() {
    return Statistics(
      totalReservations: totalReservations,
      pending: pending,
      confirmed: confirmed,
      completed: completed,
      cancelled: cancelled,
    );
  }
}

extension CalendarReservationModelMapper on CalendarReservationModel {
  CalendarReservation toEntity() {
    return CalendarReservation(
      id: id,
      reservationNumber: reservationNumber,
      customer: (customer as CalendarCustomerModel).toEntity(),
      time: time,
      endTime: endTime,
      menuName: menuName,
      menuColor: menuColor,
      menu: (menu as CalendarMenuModel).toEntity(),
      status: status,
      peopleCount: peopleCount,
      amount: amount,
    );
  }
}

extension CalendarCustomerModelMapper on CalendarCustomerModel {
  CalendarCustomer toEntity() {
    return CalendarCustomer(name: name, email: email, phone: phone, type: type);
  }
}

extension CalendarDataEntityMapper on CalendarData {
  CalendarDataModel toModel() {
    return CalendarDataModel(
      view: view,
      currentPeriod: currentPeriod.toModel(),
      navigation: navigation.toModel(),
      calendarData: calendarData.map((day) => day.toModel()).toList(),
      statistics: statistics.toModel(),
    );
  }
}

extension CurrentPeriodEntityMapper on CurrentPeriod {
  CurrentPeriodModel toModel() {
    return CurrentPeriodModel(
      month: month,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

extension NavigationEntityMapper on Navigation {
  NavigationModel toModel() {
    return NavigationModel(
      previousMonth: previousMonth,
      nextMonth: nextMonth,
      currentMonth: currentMonth,
    );
  }
}

extension CalendarDayEntityMapper on CalendarDay {
  CalendarDayModel toModel() {
    return CalendarDayModel(
      date: date,
      day: day,
      isCurrentMonth: isCurrentMonth,
      isToday: isToday,
      dayName: dayName,
      reservations: reservations
          .map((reservation) => reservation.toModel())
          .toList(),
      totalReservations: totalReservations,
    );
  }
}

extension StatisticsEntityMapper on Statistics {
  StatisticsModel toModel() {
    return StatisticsModel(
      totalReservations: totalReservations,
      pending: pending,
      confirmed: confirmed,
      completed: completed,
      cancelled: cancelled,
    );
  }
}

extension CalendarReservationEntityMapper on CalendarReservation {
  CalendarReservationModel toModel() {
    return CalendarReservationModel(
      id: id,
      reservationNumber: reservationNumber,
      customer: customer.toModel(),
      time: time,
      endTime: endTime,
      menuName: menuName,
      menuColor: menuColor,
      menu: menu.toModel(),
      status: status,
      peopleCount: peopleCount,
      amount: amount,
    );
  }
}

extension CalendarCustomerEntityMapper on CalendarCustomer {
  CalendarCustomerModel toModel() {
    return CalendarCustomerModel(
      name: name,
      email: email,
      phone: phone,
      type: type,
    );
  }
}

extension CalendarMenuModelMapper on CalendarMenuModel {
  CalendarMenu toEntity() {
    return CalendarMenu(
      id: id,
      name: name,
      description: description,
      requiredTime: requiredTime,
      price: (price as CalendarMenuPriceModel).toEntity(),
      photoPath: photoPath,
      displayOrder: displayOrder,
      isActive: isActive,
      color: (color as CalendarMenuColorModel).toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      translations: translations,
      meta: meta,
    );
  }
}

extension CalendarMenuEntityMapper on CalendarMenu {
  CalendarMenuModel toModel() {
    return CalendarMenuModel(
      id: id,
      name: name,
      description: description,
      requiredTime: requiredTime,
      price: price.toModel(),
      photoPath: photoPath,
      displayOrder: displayOrder,
      isActive: isActive,
      color: color.toModel(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      translations: translations,
      meta: meta,
    );
  }
}

extension CalendarMenuPriceModelMapper on CalendarMenuPriceModel {
  CalendarMenuPrice toEntity() {
    return CalendarMenuPrice(
      amount: amount,
      formatted: formatted,
      currency: currency,
    );
  }
}

extension CalendarMenuPriceEntityMapper on CalendarMenuPrice {
  CalendarMenuPriceModel toModel() {
    return CalendarMenuPriceModel(
      amount: amount,
      formatted: formatted,
      currency: currency,
    );
  }
}

extension CalendarMenuColorModelMapper on CalendarMenuColorModel {
  CalendarMenuColor toEntity() {
    return CalendarMenuColor(
      hex: hex,
      rgbaLight: rgbaLight,
      textColor: textColor,
    );
  }
}

extension CalendarMenuColorEntityMapper on CalendarMenuColor {
  CalendarMenuColorModel toModel() {
    return CalendarMenuColorModel(
      hex: hex,
      rgbaLight: rgbaLight,
      textColor: textColor,
    );
  }
}
