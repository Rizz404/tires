import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/reservation/domain/entities/available_hour.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';

abstract class ReservationRepository {
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> createReservation({
    required int menuId,
    required DateTime reservationDatetime,
    int numberOfPeople = 1,
    required int amount,
  });
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getReservationsCursor({
    required bool paginate,
    required int perPage,
    String? cursor,
  });
  Future<Either<Failure, ItemSuccessResponse<Calendar>>>
  getReservationCalendar({required String menuId, String? month});
  Future<Either<Failure, ItemSuccessResponse<AvailableHour>>>
  getReservationAvailableHours({required String date, required String menuId});
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> updateReservation({
    required String id,
  });
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> deleteReservation({
    required String id,
  });
}
