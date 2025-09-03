import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class GetReservationCalendarUsecase
    implements
        Usecase<ItemSuccessResponse<Calendar>, GetReservationCalendarParams> {
  final ReservationRepository _reservationRepository;

  GetReservationCalendarUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Calendar>>> call(
    GetReservationCalendarParams params,
  ) async {
    return await _reservationRepository.getReservationCalendar(
      month: params.month,
      menuId: params.menuId,
    );
  }
}

class GetReservationCalendarParams extends Equatable {
  final String? month;
  final String menuId;

  const GetReservationCalendarParams({this.month, required this.menuId});

  @override
  List<Object?> get props => [month, menuId];
}
