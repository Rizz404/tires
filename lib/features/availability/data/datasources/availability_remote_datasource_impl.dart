import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/availability/data/datasources/availability_remote_datasource.dart';
import 'package:tires/features/availability/data/mappers/availability_mapper.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';

class AvailabilityRemoteDatasourceImpl implements AvailabilityRemoteDatasource {
  final DioClient _dioClient;

  AvailabilityRemoteDatasourceImpl(this._dioClient);

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailabilityCalendar>>>
  getAvailabilityCalendar({
    required String menuId,
    required String currentMonth,
    bool paginate = true,
  }) async {
    try {
      final queryParameters = {
        'menu_id': menuId,
        'current_month': currentMonth,
        'paginate': paginate.toString(),
      };

      final response = await _dioClient.get(
        ApiEndpoints.calendar,
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
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
