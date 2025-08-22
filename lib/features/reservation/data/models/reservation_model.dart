import 'dart:convert';

import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/data/models/user_model.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.reservationNumber,
    super.user,
    super.fullName,
    super.fullNameKana,
    super.email,
    super.phoneNumber,
    required super.menu,
    required super.reservationDatetime,
    required super.numberOfPeople,
    required super.amount,
    required super.status,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  ReservationModel copyWith({
    int? id,
    String? reservationNumber,
    UserModel? user,
    String? fullName,
    String? fullNameKana,
    String? email,
    String? phoneNumber,
    MenuModel? menu,
    DateTime? reservationDatetime,
    int? numberOfPeople,
    double? amount,
    ReservationStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReservationModel(
      id: id ?? this.id,
      reservationNumber: reservationNumber ?? this.reservationNumber,
      user: user ?? this.user,
      fullName: fullName ?? this.fullName,
      fullNameKana: fullNameKana ?? this.fullNameKana,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      menu: menu ?? this.menu,
      reservationDatetime: reservationDatetime ?? this.reservationDatetime,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation_number': reservationNumber,
      'user': (user as UserModel?)?.toMap(),
      'full_name': fullName,
      'full_name_kana': fullNameKana,
      'email': email,
      'phone_number': phoneNumber,
      'menu': (menu as MenuModel).toMap(),
      'reservation_datetime': reservationDatetime.toIso8601String(),
      'number_of_people': numberOfPeople,
      'amount': amount,
      'status': status.name,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['id']?.toInt() ?? 0,
      reservationNumber: map['reservation_number'] ?? '',
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      fullName: map['full_name'],
      fullNameKana: map['full_name_kana'],
      email: map['email'],
      phoneNumber: map['phone_number'],
      menu: MenuModel.fromMap(map['menu']),
      reservationDatetime: DateTime.parse(map['reservation_datetime']),
      numberOfPeople: map['number_of_people']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      status: ReservationStatus.values.byName(map['status']),
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  factory ReservationModel.fromEntity(Reservation entity) {
    return ReservationModel(
      id: entity.id,
      reservationNumber: entity.reservationNumber,
      user: entity.user?.toModel(),
      fullName: entity.fullName,
      fullNameKana: entity.fullNameKana,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      menu: entity.menu.toModel(),
      reservationDatetime: entity.reservationDatetime,
      numberOfPeople: entity.numberOfPeople,
      amount: entity.amount,
      status: entity.status,
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
