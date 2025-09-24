import 'package:equatable/equatable.dart';

class AvailabilitySlot extends Equatable {
  final String hour;
  final bool available;
  final String? blockedBy;

  const AvailabilitySlot({
    required this.hour,
    required this.available,
    this.blockedBy,
  });

  @override
  List<Object?> get props => [hour, available, blockedBy];
}
