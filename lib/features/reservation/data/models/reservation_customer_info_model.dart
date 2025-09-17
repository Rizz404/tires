import 'dart:convert';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';

class ReservationCustomerInfoModel extends ReservationCustomerInfo {
  const ReservationCustomerInfoModel({
    required super.fullName,
    required super.fullNameKana,
    required super.email,
    required super.phoneNumber,
    required super.isGuest,
  });

  factory ReservationCustomerInfoModel.fromMap(Map<String, dynamic> map) {
    return ReservationCustomerInfoModel(
      fullName: (map['full_name'] as String?) ?? '',
      fullNameKana: (map['full_name_kana'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      phoneNumber: (map['phone_number'] as String?) ?? '',
      isGuest: (map['is_guest'] as bool?) ?? false,
    );
  }

  factory ReservationCustomerInfoModel.fromJson(String source) =>
      ReservationCustomerInfoModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'full_name_kana': fullNameKana,
      'email': email,
      'phone_number': phoneNumber,
      'is_guest': isGuest,
    };
  }

  String toJson() => json.encode(toMap());

  ReservationCustomerInfoModel copyWith({
    String? fullName,
    String? fullNameKana,
    String? email,
    String? phoneNumber,
    bool? isGuest,
  }) {
    return ReservationCustomerInfoModel(
      fullName: fullName ?? this.fullName,
      fullNameKana: fullNameKana ?? this.fullNameKana,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isGuest: isGuest ?? this.isGuest,
    );
  }

  @override
  String toString() =>
      'ReservationCustomerInfoModel(fullName: $fullName, fullNameKana: $fullNameKana, email: $email, phoneNumber: $phoneNumber, isGuest: $isGuest)';
}
