import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/availability/data/models/availability_calendar_model.dart';
import 'package:tires/features/availability/data/models/availability_date_model.dart';
import 'package:tires/features/availability/domain/usecases/get_availability_calendar_usecase.dart';
import 'package:tires/features/availability/domain/usecases/get_reservation_availability_usecase.dart';

abstract class AvailabilityRemoteDatasource {
  Future<ApiResponse<AvailabilityCalendarModel>> getAvailabilityCalendar(
    GetAvailabilityCalendarParams params,
  );
  Future<ApiResponse<List<AvailabilityDateModel>>> getReservationAvailability(
    GetReservationAvailabilityParams params,
  );
}

class AvailabilityRemoteDatasourceImpl implements AvailabilityRemoteDatasource {
  final DioClient _dioClient;

  AvailabilityRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<AvailabilityCalendarModel>> getAvailabilityCalendar(
    GetAvailabilityCalendarParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching availability calendar');
      final queryParameters = params.toMap();

      final response = await _dioClient.get<AvailabilityCalendarModel>(
        ApiEndpoints.customerReservationCalendar,
        queryParameters: queryParameters,
        fromJson: (json) =>
            AvailabilityCalendarModel.fromMap(json as Map<String, dynamic>),
      );

      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching availability calendar', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<AvailabilityDateModel>>> getReservationAvailability(
    GetReservationAvailabilityParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching reservation availability');
      final response = await _dioClient.get<List<AvailabilityDateModel>>(
        ApiEndpoints.adminReservationAvailability,
        queryParameters: params.toMap(),
        fromJson: (json) => (json as List<dynamic>)
            .map(
              (e) => AvailabilityDateModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching reservation availability', e);
      rethrow;
    }
  }
}
