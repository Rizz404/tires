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
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDatasource _reservationRemoteDatasource;

  ReservationRepositoryImpl(this._reservationRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> createReservation({
    required int menuId,
    required DateTime reservationDatetime,
    int numberOfPeople = 1,
    required int amount,
  }) async {
    try {
      final result = await _reservationRemoteDatasource.createReservation(
        menuId: menuId,
        reservationDatetime: reservationDatetime,
        numberOfPeople: numberOfPeople,
        amount: amount,
      );

      return Right(
        ItemSuccessResponse<Reservation>(
          data: result.data,
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getReservationsCursor({
    required bool paginate,
    required int perPage,
    String? cursor,
  }) async {
    try {
      final result = await _reservationRemoteDatasource.getReservationsCursor(
        paginate: paginate,
        perPage: perPage,
        cursor: cursor,
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
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Calendar>>>
  getReservationCalendar({String? month, required String menuId}) async {
    try {
      final result = await _reservationRemoteDatasource.getReservationCalendar(
        month: month,
        menuId: menuId,
      );

      final calendar = result.data.toEntity();
      return Right(
        ItemSuccessResponse(data: calendar, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailableHour>>>
  getReservationAvailableHours({
    required String date,
    required String menuId,
  }) async {
    try {
      final result = await _reservationRemoteDatasource
          .getReservationAvailableHours(date: date, menuId: menuId);

      final calendar = result.data.toEntity();
      return Right(
        ItemSuccessResponse(data: calendar, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> updateReservation({
    required int id,
  }) async {
    // TODO: implement updateReservation - method not available in datasource
    throw UnimplementedError(
      'updateReservation method not implemented in datasource',
    );
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> deleteReservation({
    required int id,
  }) async {
    // TODO: implement deleteReservation - method not available in datasource
    throw UnimplementedError(
      'deleteReservation method not implemented in datasource',
    );
  }
}
