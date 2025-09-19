import 'dart:convert';
import 'package:tires/features/customer_management/domain/entities/customer_detail.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';

class CustomerDetailModel extends CustomerDetail {
  CustomerDetailModel({
    required super.customer,
    required super.reservationHistory,
    super.tireStorage,
    required super.stats,
  });

  factory CustomerDetailModel.fromMap(Map<String, dynamic> map) {
    final customerData = map['customer'] as Map<String, dynamic>? ?? {};
    final reservationHistoryData =
        (map['reservation_history'] as List<dynamic>?) ?? <dynamic>[];
    final tireStorageData = (map['tire_storage'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();
    final statsData = map['stats'] as Map<String, dynamic>? ?? {};

    return CustomerDetailModel(
      customer: CustomerModel.fromMap(customerData),
      reservationHistory: reservationHistoryData
          .map(
            (item) =>
                ReservationHistoryModel.fromMap(item as Map<String, dynamic>),
          )
          .toList(),
      tireStorage: tireStorageData,
      stats: StatsModel.fromMap(statsData),
    );
  }

  factory CustomerDetailModel.fromJson(String source) =>
      CustomerDetailModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'customer': (customer as CustomerModel).toMap(),
      'reservation_history': reservationHistory
          .map((history) => (history as ReservationHistoryModel).toMap())
          .toList(),
      'tire_storage': tireStorage,
      'stats': (stats as StatsModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class CustomerModel extends Customer {
  CustomerModel({
    required super.customerId,
    required super.fullName,
    required super.fullNameKana,
    required super.email,
    required super.phoneNumber,
    required super.isRegistered,
    super.userId,
    super.companyName,
    super.department,
    super.companyAddress,
    super.homeAddress,
    super.dateOfBirth,
    super.gender,
    required super.reservationCount,
    required super.latestReservation,
    required super.totalAmount,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      customerId: (map['customer_id'] as String?) ?? '',
      fullName: (map['full_name'] as String?) ?? '',
      fullNameKana: (map['full_name_kana'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      phoneNumber: (map['phone_number'] as String?) ?? '',
      isRegistered: (map['is_registered'] as int?) ?? 0,
      userId: map['user_id'] as String?,
      companyName: map['company_name'] as String?,
      department: map['department'] as String?,
      companyAddress: map['company_address'] as String?,
      homeAddress: map['home_address'] as String?,
      dateOfBirth: map['date_of_birth'] as String?,
      gender: map['gender'] as String?,
      reservationCount: (map['reservation_count'] as int?) ?? 0,
      latestReservation: map['latest_reservation'] != null
          ? DateTime.parse(map['latest_reservation'] as String)
          : DateTime.now(),
      totalAmount: (map['total_amount'] as String?) ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customer_id': customerId,
      'full_name': fullName,
      'full_name_kana': fullNameKana,
      'email': email,
      'phone_number': phoneNumber,
      'is_registered': isRegistered,
      'user_id': userId,
      'company_name': companyName,
      'department': department,
      'company_address': companyAddress,
      'home_address': homeAddress,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'reservation_count': reservationCount,
      'latest_reservation': latestReservation.toIso8601String(),
      'total_amount': totalAmount,
    };
  }
}

class ReservationHistoryModel extends ReservationHistory {
  ReservationHistoryModel({
    required super.id,
    required super.reservationNumber,
    super.userId,
    required super.fullName,
    required super.fullNameKana,
    required super.email,
    required super.phoneNumber,
    required super.menuId,
    required super.reservationDatetime,
    required super.numberOfPeople,
    required super.amount,
    required super.status,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
    required super.menu,
  });

  factory ReservationHistoryModel.fromMap(Map<String, dynamic> map) {
    return ReservationHistoryModel(
      id: (map['id'] as int?) ?? 0,
      reservationNumber: (map['reservation_number'] as String?) ?? '',
      userId: map['user_id'] as String?,
      fullName: (map['full_name'] as String?) ?? '',
      fullNameKana: (map['full_name_kana'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      phoneNumber: (map['phone_number'] as String?) ?? '',
      menuId: (map['menu_id'] as int?) ?? 0,
      reservationDatetime: map['reservation_datetime'] != null
          ? DateTime.parse(map['reservation_datetime'] as String)
          : DateTime.now(),
      numberOfPeople: (map['number_of_people'] as int?) ?? 0,
      amount: (map['amount'] as String?) ?? '0',
      status: (map['status'] as String?) ?? '',
      notes: map['notes'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : DateTime.now(),
      menu: map['menu'] != null && map['menu'] is Map<String, dynamic>
          ? MenuModel.fromMap(map['menu'])
          : MenuModel.fromMap({}), // Default empty menu
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation_number': reservationNumber,
      'user_id': userId,
      'full_name': fullName,
      'full_name_kana': fullNameKana,
      'email': email,
      'phone_number': phoneNumber,
      'menu_id': menuId,
      'reservation_datetime': reservationDatetime.toIso8601String(),
      'number_of_people': numberOfPeople,
      'amount': amount,
      'status': status,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'menu': (menu as MenuModel).toMap(),
    };
  }
}

class StatsModel extends Stats {
  StatsModel({
    required super.reservationCount,
    required super.totalAmount,
    required super.tireStorageCount,
  });

  factory StatsModel.fromMap(Map<String, dynamic> map) {
    return StatsModel(
      reservationCount: (map['reservation_count'] as int?) ?? 0,
      totalAmount: (map['total_amount'] as String?) ?? '0',
      tireStorageCount: (map['tire_storage_count'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reservation_count': reservationCount,
      'total_amount': totalAmount,
      'tire_storage_count': tireStorageCount,
    };
  }
}
