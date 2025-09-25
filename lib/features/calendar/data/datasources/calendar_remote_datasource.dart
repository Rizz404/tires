import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/calendar/data/models/calendar_data_model.dart';
import 'package:tires/features/calendar/domain/usecases/get_calendar_data_usecase.dart';

abstract class CalendarRemoteDatasource {
  Future<ApiResponse<CalendarDataModel>> getCalendarData(
    GetCalendarDataParams params,
  );
}

class CalendarRemoteDatasourceImpl implements CalendarRemoteDatasource {
  final DioClient _dioClient;

  CalendarRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<CalendarDataModel>> getCalendarData(
    GetCalendarDataParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching calendar data');
      final response = await _dioClient.get<CalendarDataModel>(
        ApiEndpoints.adminReservationCalendar,
        fromJson: (data) => CalendarDataModel.fromMap(data),
        queryParameters: params.toMap(),
      );
      AppLogger.networkDebug('Calendar data fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching calendar data', e);
      rethrow;
    }
  }
}
