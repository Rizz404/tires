import 'dart:convert';
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';

class ReservationAmountModel extends ReservationAmount {
  const ReservationAmountModel({required super.raw, required super.formatted});

  factory ReservationAmountModel.fromMap(Map<String, dynamic> map) {
    return ReservationAmountModel(
      raw: (map['raw'] as String?) ?? '0.00',
      formatted: (map['formatted'] as String?) ?? '0.00',
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
