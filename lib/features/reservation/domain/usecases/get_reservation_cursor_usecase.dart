// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    return await _reservationRepository.getReservationsCursor(
      cursor: params.cursor,
      paginate: params.paginate,
      perPage: params.perPage,
    );
  }
}

class GetReservationCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  const GetReservationCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  @override
  List<Object?> get props => [cursor];
}
