import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/available_hour.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class GetReservationAvailableHoursUsecase
    implements
        Usecase<
          ItemSuccessResponse<AvailableHour>,
          GetReservationCalendarParams
        > {
  final ReservationRepository _reservationRepository;

  GetReservationAvailableHoursUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailableHour>>> call(
    GetReservationCalendarParams params,
  ) async {
    return await _reservationRepository.getReservationAvailableHours(
      date: params.date,
      menuId: params.menuId,
    );
  }
}

class GetReservationCalendarParams extends Equatable {
  final String date;
  final String menuId;

  const GetReservationCalendarParams({
    required this.date,
    required this.menuId,
  });

  @override
  List<Object?> get props => [date, menuId];
}
