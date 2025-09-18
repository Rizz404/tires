import 'package:equatable/equatable.dart';

import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';

class Dashboard extends Equatable {
  final List<Announcement> announcements;
  final List<Reservation> todayReservations;
  final int pendingContactsCount;
  final List<Contact> pendingContacts;
  final List<Reservation> monthlyReservations;
  final Statistics statistics;
  final DateTime lastLogin;
  final String currentMonth;

  Dashboard({
    required this.announcements,
    required this.todayReservations,
    required this.pendingContactsCount,
    required this.pendingContacts,
    required this.monthlyReservations,
    required this.statistics,
    required this.lastLogin,
    required this.currentMonth,
  });

  @override
  List<Object> get props {
    return [
      announcements,
      todayReservations,
      pendingContactsCount,
      pendingContacts,
      monthlyReservations,
      statistics,
      lastLogin,
      currentMonth,
    ];
  }
}

class Statistics extends Equatable {
  final int newCustomersThisMonth;
  final int onlineReservationsThisMonth;
  final int totalCustomers;
  final int customersUntilLimit;
  final int customerLimit;

  Statistics({
    required this.newCustomersThisMonth,
    required this.onlineReservationsThisMonth,
    required this.totalCustomers,
    required this.customersUntilLimit,
    required this.customerLimit,
  });

  @override
  List<Object> get props {
    return [
      newCustomersThisMonth,
      onlineReservationsThisMonth,
      totalCustomers,
      customersUntilLimit,
      customerLimit,
    ];
  }
}
