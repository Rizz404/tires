import 'package:tires/features/availability/domain/entities/availability_slot.dart';

class AvailabilitySlotModel extends AvailabilitySlot {
  const AvailabilitySlotModel({
    required super.hour,
    required super.available,
    super.blockedBy,
  });

  factory AvailabilitySlotModel.fromJson(Map<String, dynamic> json) {
    return AvailabilitySlotModel(
      hour: json['hour'] as String,
      available: json['available'] as bool,
      blockedBy: json['blocked_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'hour': hour, 'available': available, 'blocked_by': blockedBy};
  }
}
