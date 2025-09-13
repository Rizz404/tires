import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';

enum CurrentUserReservationsGetStatus {
  initial,
  loading,
  success,
  error,
  loadingMore,
}

class CurrentUserReservationsGetState extends Equatable {
  final CurrentUserReservationsGetStatus status;
  final List<Reservation> reservations;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const CurrentUserReservationsGetState({
    this.status = CurrentUserReservationsGetStatus.initial,
    this.reservations = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  CurrentUserReservationsGetState copyWith({
    CurrentUserReservationsGetStatus? status,
    List<Reservation>? reservations,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return CurrentUserReservationsGetState(
      status: status ?? this.status,
      reservations: reservations ?? this.reservations,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  CurrentUserReservationsGetState copyWithClearError() {
    return CurrentUserReservationsGetState(
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
