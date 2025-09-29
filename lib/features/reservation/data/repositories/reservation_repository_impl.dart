import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
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
      AppLogger.businessInfo('Creating reservation in repository');
      final result = await _reservationRemoteDatasource.createReservation(
        params,
      );
      AppLogger.businessDebug('Reservation created successfully in repository');
      return Right(
        ItemSuccessResponse<Reservation>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in create reservation', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Error in create reservation', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getReservationsCursor(GetReservationCursorParams params) async {
    try {
      AppLogger.businessInfo('Getting reservations cursor in repository');
      final result = await _reservationRemoteDatasource.getReservationsCursor(
        params,
      );
      AppLogger.businessDebug(
        'Reservations cursor fetched successfully in repository',
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
      AppLogger.businessError('API error in get reservations cursor', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Error in get reservations cursor', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getCurrentUserReservations(
    GetCurrentUserReservationsCursorParams params,
  ) async {
    try {
      AppLogger.businessInfo('Getting current user reservations in repository');
      final result = await _reservationRemoteDatasource
          .getCurrentUserReservations(params);
      AppLogger.businessDebug(
        'Current user reservations fetched successfully in repository',
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
      AppLogger.businessError('API error in get current user reservations', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Error in get current user reservations', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Calendar>>> getReservationCalendar(
    GetReservationCalendarParams params,
  ) async {
    try {
      AppLogger.businessInfo('Getting reservation calendar in repository');
      final result = await _reservationRemoteDatasource.getReservationCalendar(
        params,
      );
      AppLogger.businessDebug(
        'Reservation calendar fetched successfully in repository',
      );
      final calendar = result.data.toEntity();
      return Right(
        ItemSuccessResponse(data: calendar, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get reservation calendar', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Error in get reservation calendar', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailableHour>>>
  getReservationAvailableHours(
    GetReservationAvailableHoursParams params,
  ) async {
    try {
      AppLogger.businessInfo(
        'Getting reservation available hours in repository',
      );
      final result = await _reservationRemoteDatasource
          .getReservationAvailableHours(params);
      AppLogger.businessDebug(
        'Reservation available hours fetched successfully in repository',
      );
      final calendar = result.data.toEntity();
      return Right(
        ItemSuccessResponse(data: calendar, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError(
        'API error in get reservation available hours',
        e,
      );
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Error in get reservation available hours', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> updateReservation(
    UpdateReservationParams params,
  ) async {
    try {
      AppLogger.businessInfo('Updating reservation in repository');
      final result = await _reservationRemoteDatasource.updateReservation(
        params,
      );
      AppLogger.businessDebug('Reservation updated successfully in repository');
      return Right(
        ItemSuccessResponse<Reservation>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in update reservation', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in update reservation', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> deleteReservation(
    DeleteReservationParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting reservation in repository');
      final result = await _reservationRemoteDatasource.deleteReservation(
        params,
      );
      AppLogger.businessDebug('Reservation deleted successfully in repository');
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete reservation', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete reservation', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
