import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/network/validation_error_mapper.dart';
import 'package:tires/core/storage/session_storage_service.dart';
import 'package:tires/features/reservation/data/datasources/reservation_remote_datasource.dart';
import 'package:tires/features/reservation/data/mapper/reservation_mapper.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  final ReservationRemoteDatasource _reservationRemoteDatasource;

  ReservationRepositoryImpl(this._reservationRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>>
  createReservation() {
    // TODO: implement createReservation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> deleteReservation({
    required String id,
  }) {
    // TODO: implement deleteReservation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>>
  getReservationCursor({String? cursor}) {
    // TODO: implement getReservationCursor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> updateReservation({
    required String id,
  }) {
    // TODO: implement updateReservation
    throw UnimplementedError();
  }
}
