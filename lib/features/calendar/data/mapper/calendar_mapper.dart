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
      reservations: (reservations as List<ReservationModel>)
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

extension ReservationModelMapper on ReservationModel {
  Reservation toEntity() {
    return Reservation(
      id: id,
      reservationNumber: reservationNumber,
      customerName: customerName,
      time: time,
      endTime: endTime,
      menuName: menuName,
      menuColor: menuColor,
      status: status,
      peopleCount: peopleCount,
      amount: amount,
    );
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

extension ReservationEntityMapper on Reservation {
  ReservationModel toModel() {
    return ReservationModel(
      id: id,
      reservationNumber: reservationNumber,
      customerName: customerName,
      time: time,
      endTime: endTime,
      menuName: menuName,
      menuColor: menuColor,
      status: status,
      peopleCount: peopleCount,
      amount: amount,
    );
  }
}
