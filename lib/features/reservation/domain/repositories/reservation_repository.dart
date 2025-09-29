import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/reservation/domain/entities/available_hour.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_current_user_reservations_cursor_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_available_hours_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_calendar_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_cursor_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/update_reservation_usecase.dart';

abstract class ReservationRepository {
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> createReservation(
    CreateReservationParams params,
  );
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getReservationsCursor(GetReservationCursorParams params);
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getCurrentUserReservations(GetCurrentUserReservationsCursorParams params);
  Future<Either<Failure, ItemSuccessResponse<Calendar>>> getReservationCalendar(
    GetReservationCalendarParams params,
  );
  Future<Either<Failure, ItemSuccessResponse<AvailableHour>>>
  getReservationAvailableHours(GetReservationAvailableHoursParams params);
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> updateReservation(
    UpdateReservationParams params,
  );
  Future<Either<Failure, ActionSuccess>> deleteReservation(
    DeleteReservationParams params,
  );
}
