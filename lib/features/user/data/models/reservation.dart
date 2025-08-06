import 'dart:convert';

import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/features/user/domain/entities/reservation.dart';

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
      'reservationNumber': reservationNumber,
      'user': (user as UserModel?)?.toMap(),
      'fullName': fullName,
      'fullNameKana': fullNameKana,
      'email': email,
      'phoneNumber': phoneNumber,
      'menu': (menu as MenuModel).toMap(),
      'reservationDatetime': reservationDatetime.toIso8601String(),
      'numberOfPeople': numberOfPeople,
      'amount': amount,
      'status': status.name,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['id']?.toInt() ?? 0,
      reservationNumber: map['reservationNumber'] ?? '',
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      fullName: map['fullName'],
      fullNameKana: map['fullNameKana'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      menu: MenuModel.fromMap(map['menu']),
      reservationDatetime: DateTime.parse(map['reservationDatetime']),
      numberOfPeople: map['numberOfPeople']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      status: ReservationStatus.values.byName(map['status']),
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  factory ReservationModel.fromEntity(Reservation entity) {
    return ReservationModel(
      id: entity.id,
      reservationNumber: entity.reservationNumber,
      user: entity.user,
      fullName: entity.fullName,
      fullNameKana: entity.fullNameKana,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      menu: entity.menu,
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
