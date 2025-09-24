import 'package:tires/features/availability/data/models/availability_slot_model.dart';
import 'package:tires/features/availability/domain/entities/availability_date.dart';

class AvailabilityDateModel extends AvailabilityDate {
  const AvailabilityDateModel({
    required super.date,
    required super.availableHours,
    required super.hasAvailableSlots,
  });

  factory AvailabilityDateModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityDateModel(
      date: json['date'] as String,
      availableHours: (json['available_hours'] as List<dynamic>)
          .map((e) => AvailabilitySlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasAvailableSlots: json['has_available_slots'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'available_hours': availableHours
          .map((e) => (e as AvailabilitySlotModel).toJson())
          .toList(),
      'has_available_slots': hasAvailableSlots,
    };
  }
}
