import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class DeleteReservationUsecase
    implements
        Usecase<ItemSuccessResponse<Reservation>, DeleteReservationParams> {
  final ReservationRepository _reservationRepository;

  DeleteReservationUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> call(
    DeleteReservationParams params,
  ) async {
    return await _reservationRepository.deleteReservation(id: params.id);
  }
}

class DeleteReservationParams extends Equatable {
  final String id;

  const DeleteReservationParams({required this.id});

  @override
  List<Object?> get props => [id];
}
