import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';

enum ReservationGetStatus { initial, loading, success, error, loadingMore }

class ReservationGetState extends Equatable {
  final ReservationGetStatus status;
  final List<Reservation> reservations;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const ReservationGetState({
    this.status = ReservationGetStatus.initial,
    this.reservations = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  ReservationGetState copyWith({
    ReservationGetStatus? status,
    List<Reservation>? reservations,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return ReservationGetState(
      status: status ?? this.status,
      reservations: reservations ?? this.reservations,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  ReservationGetState copyWithClearError() {
    return ReservationGetState(
      status: status,
      reservations: reservations,
      cursor: cursor,
      errorMessage: null,
      hasNextPage: hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    reservations,
    cursor,
    errorMessage,
    hasNextPage,
  ];
}
