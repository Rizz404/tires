import 'package:equatable/equatable.dart';

enum ReservationStatusValue { pending, confirmed, completed, cancelled }

class ReservationStatus extends Equatable {
  final ReservationStatusValue value;
  final String label;

  const ReservationStatus({required this.value, required this.label});

  @override
  List<Object?> get props => [value, label];
}
