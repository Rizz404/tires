import 'dart:convert';
import 'package:tires/features/contact/data/models/contact_model.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/announcement/data/models/announcement_model.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';

class DashboardModel extends Dashboard {
  DashboardModel({
    required super.announcements,
    required super.todayReservations,
    required super.pendingContactsCount,
    required super.pendingContacts,
    required super.monthlyReservations,
    required super.statistics,
    required super.lastLogin,
    required super.currentMonth,
  });

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    try {
      final lastLoginString = map['last_login'] as String?;

      return DashboardModel(
        announcements: List<Announcement>.from(
          (map['announcements'] as List<dynamic>? ?? []).map(
            (x) => AnnouncementModel.fromMap(x),
          ),
        ),
        todayReservations: List<Reservation>.from(
          (map['today_reservations'] as List<dynamic>? ?? []).map(
            (x) => ReservationModel.fromMap(x),
          ),
        ),
        pendingContactsCount: (map['pending_contacts_count'] as int?) ?? 0,
        pendingContacts: List<Contact>.from(
          (map['pending_contacts'] as List<dynamic>? ?? []).map(
            (x) => ContactModel.fromMap(x),
          ),
        ),
        monthlyReservations: List<Reservation>.from(
          (map['monthly_reservations'] as List<dynamic>? ?? []).map(
            (x) => ReservationModel.fromMap(x),
          ),
        ),
        statistics:
            map['statistics'] != null &&
                map['statistics'] is Map<String, dynamic>
            ? StatisticsModel.fromMap(map['statistics'])
            : StatisticsModel(
                newCustomersThisMonth: 0,
                onlineReservationsThisMonth: 0,
                totalCustomers: 0,
                customersUntilLimit: 0,
                customerLimit: 0,
              ),
        lastLogin: lastLoginString != null
            ? DateTime.tryParse(lastLoginString) ?? DateTime.now()
            : DateTime.now(),
        currentMonth: (map['current_month'] as String?) ?? '',
      );
    } catch (e, stackTrace) {
      print('❌ Error in DashboardModel.fromMap: $e');
      print('📋 Map contents: $map');
      print('📊 Stack trace: $stackTrace');
      rethrow;
    }
  }

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'announcements': announcements
          .map((x) => (x as AnnouncementModel).toMap())
          .toList(),
      'today_reservations': todayReservations
          .map((x) => (x as ReservationModel).toMap())
          .toList(),
      'pending_contacts_count': pendingContactsCount,
      'pending_contacts': pendingContacts
          .map((x) => (x as ContactModel).toMap())
          .toList(),
      'monthly_reservations': monthlyReservations
          .map((x) => (x as ReservationModel).toMap())
          .toList(),
      'statistics': (statistics as StatisticsModel).toMap(),
      'last_login': lastLogin.toIso8601String(),
      'current_month': currentMonth,
    };
  }

  String toJson() => json.encode(toMap());
}

class StatisticsModel extends Statistics {
  StatisticsModel({
    required super.newCustomersThisMonth,
    required super.onlineReservationsThisMonth,
    required super.totalCustomers,
    required super.customersUntilLimit,
    required super.customerLimit,
  });

  factory StatisticsModel.fromMap(Map<String, dynamic> map) {
    return StatisticsModel(
      newCustomersThisMonth: (map['new_customers_this_month'] as num?) ?? 0,
      onlineReservationsThisMonth:
          (map['online_reservations_this_month'] as num?) ?? 0,
      totalCustomers: (map['total_customers'] as num?) ?? 0,
      customersUntilLimit: (map['customers_until_limit'] as num?) ?? 0,
      customerLimit: (map['customer_limit'] as num?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'new_customers_this_month': newCustomersThisMonth,
      'online_reservations_this_month': onlineReservationsThisMonth,
      'total_customers': totalCustomers,
      'customers_until_limit': customersUntilLimit,
      'customer_limit': customerLimit,
    };
  }
}
