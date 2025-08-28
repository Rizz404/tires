import 'package:equatable/equatable.dart';

class ReservationAmount extends Equatable {
  final String raw;
  final String formatted;

  const ReservationAmount({required this.raw, required this.formatted});

  @override
  List<Object?> get props => [raw, formatted];
}
