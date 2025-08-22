import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';

abstract class ReservationRepository {
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> createReservation();
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getReservationCursor({String? cursor});
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> updateReservation({
    required String id,
  });
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> deleteReservation({
    required String id,
  });
}
