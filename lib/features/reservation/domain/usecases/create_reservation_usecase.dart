import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class CreateReservationUsecase
    implements
        Usecase<ItemSuccessResponse<Reservation>, CreateReservationParams> {
  final ReservationRepository _reservationRepository;

  CreateReservationUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> call(
    CreateReservationParams params,
  ) async {
    return await _reservationRepository.createReservation();
  }
}

class CreateReservationParams extends Equatable {
  const CreateReservationParams();

  @override
  List<Object?> get props => [];
}
