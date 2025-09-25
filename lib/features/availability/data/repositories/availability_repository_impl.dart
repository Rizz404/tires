import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/availability/data/datasources/availability_remote_datasource.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';
import 'package:tires/features/availability/domain/entities/availability_date.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';
import 'package:tires/features/availability/domain/usecases/get_availability_calendar_usecase.dart';
import 'package:tires/features/availability/domain/usecases/get_reservation_availability_usecase.dart';

class AvailabilityRepositoryImpl implements AvailabilityRepository {
  final AvailabilityRemoteDatasource _availabilityRemoteDatasource;

  AvailabilityRepositoryImpl(this._availabilityRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailabilityCalendar>>>
  getAvailabilityCalendar(GetAvailabilityCalendarParams params) async {
    try {
      AppLogger.businessInfo('Getting availability calendar in repository');
      final result = await _availabilityRemoteDatasource
          .getAvailabilityCalendar(params);
      AppLogger.businessDebug('Availability calendar fetched successfully');
      return Right(ItemSuccessResponse(data: result.data));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get availability calendar', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError(
        'Unexpected error in get availability calendar',
        e,
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<List<AvailabilityDate>>>>
  getReservationAvailability(GetReservationAvailabilityParams params) async {
    try {
      AppLogger.businessInfo('Getting reservation availability in repository');
      final result = await _availabilityRemoteDatasource
          .getReservationAvailability(params);
      AppLogger.businessDebug('Reservation availability fetched successfully');
      return Right(ItemSuccessResponse(data: result.data));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get reservation availability', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError(
        'Unexpected error in get reservation availability',
        e,
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
