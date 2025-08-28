import 'dart:convert';
import 'package:tires/features/reservation/domain/entities/reservation_user.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class ReservationUserModel extends ReservationUser {
  const ReservationUserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
  });

  factory ReservationUserModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('ReservationUserModel', map);

    return ReservationUserModel(
      id: DebugHelper.safeCast<int>(map['id'], 'id', defaultValue: 0) ?? 0,
      fullName:
          DebugHelper.safeCast<String>(
            map['full_name'],
            'full_name',
            defaultValue: '',
          ) ??
          '',
      email:
          DebugHelper.safeCast<String>(
            map['email'],
            'email',
            defaultValue: '',
          ) ??
          '',
      phoneNumber:
          DebugHelper.safeCast<String>(
            map['phone_number'],
            'phone_number',
            defaultValue: '',
          ) ??
          '',
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
