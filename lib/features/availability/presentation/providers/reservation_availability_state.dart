import 'package:equatable/equatable.dart';
import 'package:tires/features/availability/domain/entities/availability_date.dart';

enum ReservationAvailabilityStatus { initial, loading, success, error }

class ReservationAvailabilityState extends Equatable {
  final ReservationAvailabilityStatus status;
  final List<AvailabilityDate>? availabilityDates;
  final String? errorMessage;
  final int? currentMenuId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? excludeReservationId;

  const ReservationAvailabilityState({
    this.status = ReservationAvailabilityStatus.initial,
    this.availabilityDates,
    this.errorMessage,
    this.currentMenuId,
    this.startDate,
    this.endDate,
    this.excludeReservationId,
  });

  ReservationAvailabilityState copyWith({
    ReservationAvailabilityStatus? status,
    List<AvailabilityDate>? availabilityDates,
    String? errorMessage,
    int? currentMenuId,
    DateTime? startDate,
    DateTime? endDate,
    int? excludeReservationId,
  }) {
    return ReservationAvailabilityState(
      status: status ?? this.status,
      availabilityDates: availabilityDates ?? this.availabilityDates,
      errorMessage: errorMessage ?? this.errorMessage,
      currentMenuId: currentMenuId ?? this.currentMenuId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      excludeReservationId: excludeReservationId ?? this.excludeReservationId,
    );
  }

  ReservationAvailabilityState copyWithClearError() {
    return ReservationAvailabilityState(
      status: status,
      availabilityDates: availabilityDates,
      errorMessage: null,
      currentMenuId: currentMenuId,
      startDate: startDate,
      endDate: endDate,
      excludeReservationId: excludeReservationId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    availabilityDates,
    errorMessage,
    currentMenuId,
    startDate,
    endDate,
    excludeReservationId,
  ];
}
