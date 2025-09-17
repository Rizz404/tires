import 'dart:convert';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';

class ReservationStatusModel extends ReservationStatus {
  const ReservationStatusModel({required super.value, required super.label});

  factory ReservationStatusModel.fromMap(Map<String, dynamic> map) {
    final statusValue = _parseStatus(map['value'] as String?);
    final label = (map['label'] as String?) ?? _getStatusLabel(statusValue);

    return ReservationStatusModel(value: statusValue, label: label);
  }

  factory ReservationStatusModel.fromJson(String source) =>
      ReservationStatusModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {'value': value.name, 'label': label};
  }

  String toJson() => json.encode(toMap());

  ReservationStatusModel copyWith({
    ReservationStatusValue? value,
    String? label,
  }) {
    return ReservationStatusModel(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }

  static ReservationStatusValue _parseStatus(String? statusValue) {
    if (statusValue == null) return ReservationStatusValue.pending;

    switch (statusValue.toLowerCase()) {
      case 'pending':
        return ReservationStatusValue.pending;
      case 'confirmed':
        return ReservationStatusValue.confirmed;
      case 'completed':
        return ReservationStatusValue.completed;
      case 'cancelled':
        return ReservationStatusValue.cancelled;
      default:
        return ReservationStatusValue.pending;
    }
  }

  static String _getStatusLabel(ReservationStatusValue status) {
    switch (status) {
      case ReservationStatusValue.pending:
        return 'Pending';
      case ReservationStatusValue.confirmed:
        return 'Confirmed';
      case ReservationStatusValue.completed:
        return 'Completed';
      case ReservationStatusValue.cancelled:
        return 'Cancelled';
    }
  }

  @override
  String toString() => 'ReservationStatusModel(value: $value, label: $label)';
}
