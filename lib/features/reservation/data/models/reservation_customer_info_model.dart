import 'dart:convert';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class ReservationCustomerInfoModel extends ReservationCustomerInfo {
  const ReservationCustomerInfoModel({
    required super.fullName,
    required super.fullNameKana,
    required super.email,
    required super.phoneNumber,
    required super.isGuest,
  });

  factory ReservationCustomerInfoModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('ReservationCustomerInfoModel', map);

    return ReservationCustomerInfoModel(
      fullName:
          DebugHelper.safeCast<String>(
            map['full_name'],
            'full_name',
            defaultValue: '',
          ) ??
          '',
      fullNameKana:
          DebugHelper.safeCast<String>(
            map['full_name_kana'],
            'full_name_kana',
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
      isGuest:
          DebugHelper.safeCast<bool>(
            map['is_guest'],
            'is_guest',
            defaultValue: false,
          ) ??
          false,
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
