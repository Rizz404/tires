import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class GetReservationCursorUsecase
    implements
        Usecase<
          CursorPaginatedSuccess<Reservation>,
          GetReservationCursorParams
        > {
  final ReservationRepository _reservationRepository;

  GetReservationCursorUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>> call(
    GetReservationCursorParams params,
  ) async {
    return await _reservationRepository.getReservationCursor(
      cursor: params.cursor,
    );
  }
}

class GetReservationCursorParams extends Equatable {
  final String? cursor;

  const GetReservationCursorParams({this.cursor});

  @override
  List<Object?> get props => [cursor];
}
