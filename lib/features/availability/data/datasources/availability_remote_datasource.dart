import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
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
      final queryParameters = params.toMap();

      final response = await _dioClient.get(
        ApiEndpoints.customerReservationCalendar,
        queryParameters: queryParameters,
      );

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromMap(
        response.data,
        (json) => json as Map<String, dynamic>,
      );

      final availabilityCalendar = AvailabilityMapper.mapApiResponseToEntity(
        apiResponse,
      );

      return Right(ItemSuccessResponse(data: availabilityCalendar));
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
