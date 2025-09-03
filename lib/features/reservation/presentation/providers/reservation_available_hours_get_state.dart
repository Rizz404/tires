import 'package:equatable/equatable.dart';
import 'package:tires/features/reservation/domain/entities/available_hour.dart';

enum ReservationAvailableHoursGetStatus { initial, loading, success, error }

class ReservationAvailableHoursGetState extends Equatable {
  final ReservationAvailableHoursGetStatus status;
  final AvailableHour? availableHour;
  final String? errorMessage;

  const ReservationAvailableHoursGetState({
    this.status = ReservationAvailableHoursGetStatus.initial,
    this.availableHour,
    this.errorMessage,
  });

  ReservationAvailableHoursGetState copyWith({
    ReservationAvailableHoursGetStatus? status,
    AvailableHour? availableHour,
    String? errorMessage,
  }) {
    return ReservationAvailableHoursGetState(
      status: status ?? this.status,
      availableHour: availableHour ?? this.availableHour,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  ReservationAvailableHoursGetState copyWithClearError() {
    return ReservationAvailableHoursGetState(
      status: status,
      availableHour: availableHour,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, availableHour, errorMessage];
}
