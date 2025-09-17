import 'dart:convert';
import 'package:tires/features/reservation/domain/entities/reservation_user.dart';

class ReservationUserModel extends ReservationUser {
  const ReservationUserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
  });

  factory ReservationUserModel.fromMap(Map<String, dynamic> map) {
    return ReservationUserModel(
      id: (map['id'] as int?) ?? 0,
      fullName: (map['full_name'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      phoneNumber: (map['phone_number'] as String?) ?? '',
    );
  }

  factory ReservationUserModel.fromJson(String source) =>
      ReservationUserModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  String toJson() => json.encode(toMap());

  ReservationUserModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phoneNumber,
  }) {
    return ReservationUserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  String toString() =>
      'ReservationUserModel(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber)';
}
