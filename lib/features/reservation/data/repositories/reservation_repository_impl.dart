import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/features/reservation/data/datasources/reservation_remote_datasource.dart';
import 'package:tires/features/reservation/data/mapper/available_hour_mapper.dart';
import 'package:tires/features/reservation/data/mapper/calendar_mapper.dart';
import 'package:tires/features/reservation/data/mapper/reservation_mapper.dart';
import 'package:tires/features/reservation/domain/entities/available_hour.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:tires/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_current_user_reservations_cursor_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_available_hours_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_calendar_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_cursor_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/update_reservation_usecase.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDatasource _reservationRemoteDatasource;

  ReservationRepositoryImpl(this._reservationRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> createReservation(
    CreateReservationParams params,
  ) async {
    try {
      final result = await _reservationRemoteDatasource.createReservation(
        params,
      );

      return Right(
        ItemSuccessResponse<Reservation>(
          data: result.data,
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getReservationsCursor(GetReservationCursorParams params) async {
    try {
      final result = await _reservationRemoteDatasource.getReservationsCursor(
        params,
      );

      return Right(
        CursorPaginatedSuccess<Reservation>(
          data: result.data
              .map((reservation) => reservation.toEntity())
              .toList(),
          cursor: result.cursor?.toEntity(),
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getCurrentUserReservations(
    GetCurrentUserReservationsCursorParams params,
  ) async {
    try {
      final result = await _reservationRemoteDatasource
          .getCurrentUserReservations(params);

      return Right(
        CursorPaginatedSuccess<Reservation>(
          data: result.data
              .map((reservation) => reservation.toEntity())
              .toList(),
          cursor: result.cursor?.toEntity(),
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Calendar>>> getReservationCalendar(
    GetReservationCalendarParams params,
  ) async {
    try {
      final result = await _reservationRemoteDatasource.getReservationCalendar(
        params,
      );

      final calendar = result.data.toEntity();
      return Right(
        ItemSuccessResponse(data: calendar, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailableHour>>>
  getReservationAvailableHours(
    GetReservationAvailableHoursParams params,
  ) async {
    try {
      final result = await _reservationRemoteDatasource
          .getReservationAvailableHours(params);

      final calendar = result.data.toEntity();
      return Right(
        ItemSuccessResponse(data: calendar, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> updateReservation(
    UpdateReservationParams params,
  ) async {
    // TODO: implement updateReservation - method not available in datasource
    throw UnimplementedError(
      'updateReservation method not implemented in datasource',
    );
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> deleteReservation(
    DeleteReservationParams params,
  ) async {
    // TODO: implement deleteReservation - method not available in datasource
    throw UnimplementedError(
      'deleteReservation method not implemented in datasource',
    );
  }
}
