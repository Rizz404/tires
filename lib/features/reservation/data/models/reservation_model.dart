import 'dart:convert';

import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.reservationNumber,
    super.user,
    super.fullName,
    super.fullNameKana,
    super.email,
    super.phoneNumber,
    required super.isGuest,
    required super.menu,
    required super.reservationDatetime,
    required super.numberOfPeople,
    required super.amount,
    super.formattedAmount,
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
    bool? isGuest,
    MenuModel? menu,
    DateTime? reservationDatetime,
    int? numberOfPeople,
    double? amount,
    String? formattedAmount,
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
      isGuest: isGuest ?? this.isGuest,
      menu: menu ?? this.menu,
      reservationDatetime: reservationDatetime ?? this.reservationDatetime,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
      amount: amount ?? this.amount,
      formattedAmount: formattedAmount ?? this.formattedAmount,
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
      'customer_info': {
        'full_name': fullName,
        'full_name_kana': fullNameKana,
        'email': email,
        'phone_number': phoneNumber,
        'is_guest': isGuest,
      },
      'menu': (menu as MenuModel).toMap(),
      'reservation_datetime': reservationDatetime.toIso8601String(),
      'number_of_people': numberOfPeople,
      'amount': {'raw': amount.toString(), 'formatted': formattedAmount},
      'status': {'value': status.name, 'label': _getStatusLabel(status)},
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('ReservationModel', map);

    final customerInfo = DebugHelper.safeExtractMap(map, 'customer_info');
    final amountData = DebugHelper.safeExtractMap(map, 'amount');
    final statusData = DebugHelper.safeExtractMap(map, 'status');
    final menuData = DebugHelper.safeExtractMap(map, 'menu');

    // Parse dates safely
    final reservationDatetime =
        DebugHelper.safeParseDateTime(
          map['reservation_datetime'],
          'reservation_datetime',
        ) ??
        DateTime.now();

    final createdAt =
        DebugHelper.safeParseDateTime(map['created_at'], 'created_at') ??
        DateTime.now();

    final updatedAt =
        DebugHelper.safeParseDateTime(map['updated_at'], 'updated_at') ??
        DateTime.now();

    return ReservationModel(
      id: DebugHelper.safeCast<int>(map['id'], 'id', defaultValue: 0) ?? 0,
      reservationNumber:
          DebugHelper.safeCast<String>(
            map['reservation_number'],
            'reservation_number',
            defaultValue: '',
          ) ??
          '',
      user: map['user'] != null
          ? UserModel.fromMap(DebugHelper.safeExtractMap(map, 'user'))
          : null,
      fullName: DebugHelper.safeCast<String>(
        customerInfo['full_name'],
        'customer_info.full_name',
      ),
      fullNameKana: DebugHelper.safeCast<String>(
        customerInfo['full_name_kana'],
        'customer_info.full_name_kana',
      ),
      email: DebugHelper.safeCast<String>(
        customerInfo['email'],
        'customer_info.email',
      ),
      phoneNumber: DebugHelper.safeCast<String>(
        customerInfo['phone_number'],
        'customer_info.phone_number',
      ),
      isGuest:
          DebugHelper.safeCast<bool>(
            customerInfo['is_guest'],
            'customer_info.is_guest',
            defaultValue: false,
          ) ??
          false,
      menu: MenuModel.fromMap(menuData),
      reservationDatetime: reservationDatetime,
      numberOfPeople:
          DebugHelper.safeCast<int>(
            map['number_of_people'],
            'number_of_people',
            defaultValue: 1,
          ) ??
          1,
      amount: _parseAmount(amountData),
      formattedAmount: DebugHelper.safeCast<String>(
        amountData['formatted'],
        'amount.formatted',
      ),
      status: _parseStatus(
        DebugHelper.safeCast<String>(statusData['value'], 'status.value'),
      ),
      notes: DebugHelper.safeCast<String>(map['notes'], 'notes'),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static double _parseAmount(Map<String, dynamic> amountData) {
    final rawAmount = amountData['raw'];
    if (rawAmount == null) {
      DebugHelper.safeCast(null, 'amount.raw', defaultValue: 0.0);
      return 0.0;
    }

    if (rawAmount is double) {
      return rawAmount;
    }

    if (rawAmount is int) {
      return rawAmount.toDouble();
    }

    if (rawAmount is String) {
      return double.tryParse(rawAmount) ?? 0.0;
    }

    DebugHelper.safeCast(
      rawAmount,
      'amount.raw (unknown type)',
      defaultValue: 0.0,
    );
    return 0.0;
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
      isGuest: entity.isGuest,
      menu: entity.menu.toModel(),
      reservationDatetime: entity.reservationDatetime,
      numberOfPeople: entity.numberOfPeople,
      amount: entity.amount,
      formattedAmount: entity.formattedAmount,
      status: entity.status,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static ReservationStatus _parseStatus(String? statusValue) {
    if (statusValue == null) return ReservationStatus.pending;

    switch (statusValue.toLowerCase()) {
      case 'pending':
        return ReservationStatus.pending;
      case 'confirmed':
        return ReservationStatus.confirmed;
      case 'completed':
        return ReservationStatus.completed;
      case 'cancelled':
        return ReservationStatus.cancelled;
      default:
        return ReservationStatus.pending;
    }
  }

  static String _getStatusLabel(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return 'Pending';
      case ReservationStatus.confirmed:
        return 'Confirmed';
      case ReservationStatus.completed:
        return 'Completed';
      case ReservationStatus.cancelled:
        return 'Cancelled';
    }
  }

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source));

  @override
  String toString() => 'ReservationModel(${toMap()})';
}
