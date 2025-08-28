import 'dart:convert';
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class ReservationAmountModel extends ReservationAmount {
  const ReservationAmountModel({required super.raw, required super.formatted});

  factory ReservationAmountModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('ReservationAmountModel', map);

    return ReservationAmountModel(
      raw:
          DebugHelper.safeCast<String>(
            map['raw'],
            'raw',
            defaultValue: '0.00',
          ) ??
          '0.00',
      formatted:
          DebugHelper.safeCast<String>(
            map['formatted'],
            'formatted',
            defaultValue: '0.00',
          ) ??
          '0.00',
    );
  }

  factory ReservationAmountModel.fromJson(String source) =>
      ReservationAmountModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {'raw': raw, 'formatted': formatted};
  }

  String toJson() => json.encode(toMap());

  ReservationAmountModel copyWith({String? raw, String? formatted}) {
    return ReservationAmountModel(
      raw: raw ?? this.raw,
      formatted: formatted ?? this.formatted,
    );
  }

  @override
  String toString() =>
      'ReservationAmountModel(raw: $raw, formatted: $formatted)';
}
