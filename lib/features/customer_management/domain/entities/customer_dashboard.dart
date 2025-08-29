import 'package:equatable/equatable.dart';

import 'package:tires/features/reservation/domain/entities/reservation.dart';

class CustomerDashboard extends Equatable {
  final Summary summary;
  final List<Reservation> recentReservations;

  const CustomerDashboard({
    required this.summary,
    required this.recentReservations,
  });

  @override
  List<Object> get props => [summary, recentReservations];
}

class Summary extends Equatable {
  final int totalReservations;

  const Summary({required this.totalReservations});

  @override
  List<Object> get props => [totalReservations];
}
