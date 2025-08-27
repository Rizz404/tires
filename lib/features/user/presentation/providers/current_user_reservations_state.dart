import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';

enum CurrentUserReservationsStatus {
  initial,
  loading,
  success,
  error,
  loadingMore,
}

class CurrentUserReservationsState extends Equatable {
  final CurrentUserReservationsStatus status;
  final List<Reservation> reservations;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const CurrentUserReservationsState({
    this.status = CurrentUserReservationsStatus.initial,
    this.reservations = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  CurrentUserReservationsState copyWith({
    CurrentUserReservationsStatus? status,
    List<Reservation>? reservations,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return CurrentUserReservationsState(
      status: status ?? this.status,
      reservations: reservations ?? this.reservations,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  CurrentUserReservationsState copyWithClearError() {
    return CurrentUserReservationsState(
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
