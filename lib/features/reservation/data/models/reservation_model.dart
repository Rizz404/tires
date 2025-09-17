import 'dart:convert';

import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/reservation/data/mapper/reservation_mapper.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/data/models/reservation_amount_model.dart';
import 'package:tires/features/reservation/data/models/reservation_customer_info_model.dart';
import 'package:tires/features/reservation/data/models/reservation_status_model.dart';
import 'package:tires/features/reservation/data/models/reservation_user_model.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.reservationNumber,
    super.user,
    required super.customerInfo,
    required super.menu,
    required super.reservationDatetime,
    required super.numberOfPeople,
    required super.amount,
    required super.status,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  // ReservationModel copyWith({
  //   int? id,
  //   String? reservationNumber,
  //   ReservationUserModel? user,
  //   ReservationCustomerInfoModel? customerInfo,
  //   MenuModel? menu,
  //   DateTime? reservationDatetime,
  //   int? numberOfPeople,
  //   ReservationAmountModel? amount,
  //   ReservationStatusModel? status,
  //   String? notes,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) {
  //   return ReservationModel(
  //     id: id ?? this.id,
  //     reservationNumber: reservationNumber ?? this.reservationNumber,
  //     user: user ?? this.user,
  //     customerInfo: customerInfo ?? this.customerInfo,
  //     menu: menu ?? this.menu,
  //     reservationDatetime: reservationDatetime ?? this.reservationDatetime,
  //     numberOfPeople: numberOfPeople ?? this.numberOfPeople,
  //     amount: amount ?? this.amount,
  //     status: status ?? this.status,
  //     notes: notes ?? this.notes,
  //     createdAt: createdAt ?? this.createdAt,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation_number': reservationNumber,
      'user': (user as ReservationUserModel?)?.toMap(),
      'customer_info': (customerInfo as ReservationCustomerInfoModel).toMap(),
      'menu': (menu as MenuModel).toMap(),
      'reservation_datetime': reservationDatetime.toIso8601String(),
      'number_of_people': numberOfPeople,
      'amount': (amount as ReservationAmountModel).toMap(),
      'status': (status as ReservationStatusModel).toMap(),
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    final customerInfoData = map['customer_info'] as Map<String, dynamic>;
    final amountData = map['amount'] as Map<String, dynamic>;
    final statusData = map['status'] as Map<String, dynamic>;
    final menuData = map['menu'] as Map<String, dynamic>;
    final userData = map['user'] != null
        ? map['user'] as Map<String, dynamic>
        : null;

    // Parse dates safely
    final reservationDatetime =
        DateTime.tryParse(map['reservation_datetime'] as String? ?? '') ??
        DateTime.now();

    final createdAt =
        DateTime.tryParse(map['created_at'] as String? ?? '') ?? DateTime.now();

    final updatedAt =
        DateTime.tryParse(map['updated_at'] as String? ?? '') ?? DateTime.now();

    return ReservationModel(
      id: (map['id'] as int?) ?? 0,
      reservationNumber: (map['reservation_number'] as String?) ?? '',
      user: userData != null ? ReservationUserModel.fromMap(userData) : null,
      customerInfo: ReservationCustomerInfoModel.fromMap(customerInfoData),
      menu: MenuModel.fromMap(menuData),
      reservationDatetime: reservationDatetime,
      numberOfPeople: (map['number_of_people'] as int?) ?? 1,
      amount: ReservationAmountModel.fromMap(amountData),
      status: ReservationStatusModel.fromMap(statusData),
      notes: map['notes'] as String?,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ReservationModel.fromEntity(Reservation entity) {
    return ReservationModel(
      id: entity.id,
      reservationNumber: entity.reservationNumber,
      user: entity.user?.toModel(),
      customerInfo: entity.customerInfo.toModel(),
      menu: entity.menu.toModel(),
      reservationDatetime: entity.reservationDatetime,
      numberOfPeople: entity.numberOfPeople,
      amount: entity.amount.toModel(),
      status: entity.status.toModel(),
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source));

  @override
  String toString() => 'ReservationModel(${toMap()})';
}
