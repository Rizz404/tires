import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/availability/data/mapper/availability_mapper.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';
import 'package:tires/features/availability/domain/usecases/get_availability_calendar_usecase.dart';

abstract class AvailabilityRemoteDatasource {
  Future<Either<Failure, ItemSuccessResponse<AvailabilityCalendar>>>
  getAvailabilityCalendar(GetAvailabilityCalendarParams params);
}

class AvailabilityRemoteDatasourceImpl implements AvailabilityRemoteDatasource {
  final DioClient _dioClient;

  AvailabilityRemoteDatasourceImpl(this._dioClient);

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailabilityCalendar>>>
  getAvailabilityCalendar(GetAvailabilityCalendarParams params) async {
    try {
      AppLogger.networkInfo('Fetching availability calendar');
      final queryParameters = params.toMap();

      final response = await _dioClient.get<Map<String, dynamic>>(
        ApiEndpoints.customerReservationCalendar,
        queryParameters: queryParameters,
        fromJson: (json) => json as Map<String, dynamic>,
      );

      final availabilityCalendar = AvailabilityMapper.mapApiResponseToEntity(
        response,
      );

      return Right(ItemSuccessResponse(data: availabilityCalendar));
    } on ApiErrorResponse catch (e) {
      AppLogger.networkError('Error fetching availability calendar', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.networkError('Error fetching availability calendar', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
