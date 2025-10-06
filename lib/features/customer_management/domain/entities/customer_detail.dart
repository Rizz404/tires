import 'package:equatable/equatable.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

class CustomerDetail extends Equatable {
  final Customer customer;
  final List<ReservationHistory> reservationHistory;
  final List<String>? tireStorage;
  final Stats stats;

  CustomerDetail({
    required this.customer,
    required this.reservationHistory,
    this.tireStorage,
    required this.stats,
  });

  @override
  List<Object?> get props => [customer, reservationHistory, tireStorage, stats];
}

class Customer extends Equatable {
  final String customerId;
  final String fullName;
  final String fullNameKana;
  final String email;
  final String phoneNumber;
  final num isRegistered;
  final String? userId;
  final String? companyName;
  final String? department;
  final String? companyAddress;
  final String? homeAddress;
  final String? dateOfBirth;
  final String? gender;
  final num reservationCount;
  final DateTime latestReservation;
  final String totalAmount;

  Customer({
    required this.customerId,
    required this.fullName,
    required this.fullNameKana,
    required this.email,
    required this.phoneNumber,
    required this.isRegistered,
    required this.userId,
    this.companyName,
    this.department,
    this.companyAddress,
    this.homeAddress,
    this.dateOfBirth,
    this.gender,
    required this.reservationCount,
    required this.latestReservation,
    required this.totalAmount,
  });

  @override
  List<Object?> get props {
    return [
      customerId,
      fullName,
      fullNameKana,
      email,
      phoneNumber,
      isRegistered,
      userId,
      companyName,
      department,
      companyAddress,
      homeAddress,
      dateOfBirth,
      gender,
      reservationCount,
      latestReservation,
      totalAmount,
    ];
  }
}

class ReservationHistory extends Equatable {
  final int id;
  final String reservationNumber;
  final String? userId;
  final String fullName;
  final String fullNameKana;
  final String email;
  final String phoneNumber;
  final num menuId;
  final DateTime reservationDatetime;
  final num numberOfPeople;
  final String amount;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Menu menu;

  ReservationHistory({
    required this.id,
    required this.reservationNumber,
    this.userId,
    required this.fullName,
    required this.fullNameKana,
    required this.email,
    required this.phoneNumber,
    required this.menuId,
    required this.reservationDatetime,
    required this.numberOfPeople,
    required this.amount,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.menu,
  });

  @override
  List<Object?> get props {
    return [
      id,
      reservationNumber,
      userId,
      fullName,
      fullNameKana,
      email,
      phoneNumber,
      menuId,
      reservationDatetime,
      numberOfPeople,
      amount,
      status,
      notes,
      createdAt,
      updatedAt,
      menu,
    ];
  }
}

class Stats {
  num reservationCount;
  String totalAmount;
  num tireStorageCount;

  Stats({
    required this.reservationCount,
    required this.totalAmount,
    required this.tireStorageCount,
  });
}
