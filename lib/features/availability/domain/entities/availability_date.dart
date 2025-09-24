import 'package:equatable/equatable.dart';
import 'package:tires/features/availability/domain/entities/availability_slot.dart';

class AvailabilityDate extends Equatable {
  final String date;
  final List<AvailabilitySlot> availableHours;
  final bool hasAvailableSlots;

  const AvailabilityDate({
    required this.date,
    required this.availableHours,
    required this.hasAvailableSlots,
  });

  @override
  List<Object?> get props => [date, availableHours, hasAvailableSlots];
}
