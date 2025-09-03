import 'package:equatable/equatable.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';

enum ReservationMutationStatus { initial, loading, success, error }

class ReservationMutationState extends Equatable {
  final ReservationMutationStatus status;
  final Reservation? reservation;
  final Failure? failure;
  final String? successMessage;

  const ReservationMutationState({
    this.status = ReservationMutationStatus.initial,
    this.reservation,
    this.failure,
    this.successMessage,
  });

  ReservationMutationState copyWith({
    ReservationMutationStatus? status,
    Reservation? reservation,
    Failure? failure,
    String? successMessage,
  }) {
    return ReservationMutationState(
      status: status ?? this.status,
      reservation: reservation ?? this.reservation,
      failure: failure ?? this.failure,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  ReservationMutationState copyWithClearError() {
    return ReservationMutationState(
      status: status,
      reservation: reservation,
      failure: null,
      successMessage: successMessage,
    );
  }

  ReservationMutationState copyWithClearSuccess() {
    return ReservationMutationState(
      status: status,
      reservation: reservation,
      failure: failure,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, reservation, failure, successMessage];
}
