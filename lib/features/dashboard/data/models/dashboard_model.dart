import 'dart:convert';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/inquiry/domain/entities/contact.dart';
import 'package:tires/features/announcement/data/models/announcement_model.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/features/inquiry/data/models/contact_model.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

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
    DebugHelper.traceModelCreation('DashboardModel', map);
    try {
      final lastLoginString = DebugHelper.safeCast<String>(
        map['last_login'],
        'last_login',
      );

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
        pendingContactsCount:
            DebugHelper.safeCast<int>(
              map['pending_contacts_count'],
              'pending_contacts_count',
              defaultValue: 0,
            ) ??
            0,
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
        currentMonth:
            DebugHelper.safeCast<String>(
              map['current_month'],
              'current_month',
              defaultValue: '',
            ) ??
            '',
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
    DebugHelper.traceModelCreation('StatisticsModel', map);
    return StatisticsModel(
      newCustomersThisMonth:
          DebugHelper.safeCast<int>(
            map['new_customers_this_month'],
            'new_customers_this_month',
            defaultValue: 0,
          ) ??
          0,
      onlineReservationsThisMonth:
          DebugHelper.safeCast<int>(
            map['online_reservations_this_month'],
            'online_reservations_this_month',
            defaultValue: 0,
          ) ??
          0,
      totalCustomers:
          DebugHelper.safeCast<int>(
            map['total_customers'],
            'total_customers',
            defaultValue: 0,
          ) ??
          0,
      customersUntilLimit:
          DebugHelper.safeCast<int>(
            map['customers_until_limit'],
            'customers_until_limit',
            defaultValue: 0,
          ) ??
          0,
      customerLimit:
          DebugHelper.safeCast<int>(
            map['customer_limit'],
            'customer_limit',
            defaultValue: 0,
          ) ??
          0,
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
