import 'package:tires/features/dashboard/data/models/dashboard_model.dart';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';

extension DashboardModelMapper on DashboardModel {
  Dashboard toEntity() {
    return Dashboard(
      announcements: announcements,
      todayReservations: todayReservations,
      pendingContactsCount: pendingContactsCount,
      pendingContacts: pendingContacts,
      monthlyReservations: monthlyReservations,
      statistics: (statistics as StatisticsModel).toEntity(),
      lastLogin: lastLogin,
      currentMonth: currentMonth,
    );
  }
}

extension StatisticsModelMapper on StatisticsModel {
  Statistics toEntity() {
    return Statistics(
      newCustomersThisMonth: newCustomersThisMonth,
      onlineReservationsThisMonth: onlineReservationsThisMonth,
      totalCustomers: totalCustomers,
      customersUntilLimit: customersUntilLimit,
      customerLimit: customerLimit,
    );
  }
}

extension DashboardEntityMapper on Dashboard {
  DashboardModel toModel() {
    return DashboardModel(
      announcements: announcements,
      todayReservations: todayReservations,
      pendingContactsCount: pendingContactsCount,
      pendingContacts: pendingContacts,
      monthlyReservations: monthlyReservations,
      statistics: statistics.toModel(),
      lastLogin: lastLogin,
      currentMonth: currentMonth,
    );
  }
}

extension StatisticsEntityMapper on Statistics {
  StatisticsModel toModel() {
    return StatisticsModel(
      newCustomersThisMonth: newCustomersThisMonth,
      onlineReservationsThisMonth: onlineReservationsThisMonth,
      totalCustomers: totalCustomers,
      customersUntilLimit: customersUntilLimit,
      customerLimit: customerLimit,
    );
  }
}
