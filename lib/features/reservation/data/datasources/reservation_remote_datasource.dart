import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/reservation/data/models/available_hour_model.dart';
import 'package:tires/features/reservation/data/models/calendar_model.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

abstract class ReservationRemoteDatasource {
  Future<ApiCursorPaginationResponse<ReservationModel>> getReservationsCursor({
    required bool paginate,
    required int perPage,
    String? cursor,
  });
  // * Contoh month 2025-08, 2025-09, 2025-10, 2025-11, 2025-12
  Future<ApiResponse<CalendarModel>> getReservationCalendar({
    required String menuId,
    String? month,
  });
  Future<ApiResponse<AvailableHourModel>> getReservationAvailableHours({
    required String date,
    required String menuId,
  });
}

class ReservationRemoteDatasourceImpl implements ReservationRemoteDatasource {
  final DioClient _dioClient;

  ReservationRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<ReservationModel>> getReservationsCursor({
    required bool paginate,
    required int perPage,
    String? cursor,
  }) async {
    try {
      final queryParameters = {
        'paginate': paginate.toString(),
        'per_page': perPage.toString(),
        if (cursor != null) 'cursor': cursor,
      };

      final response = await _dioClient.getWithCursor<ReservationModel>(
        ApiEndpoints.adminReservations,
        fromJson: (item) {
          DebugHelper.logMapDetails(
            item as Map<String, dynamic>,
            title: 'Raw Reservation Item from API',
          );
          return ReservationModel.fromMap(item);
        },
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      DebugHelper.safeCast(
        e,
        'getReservationsCursor_error',
        defaultValue: 'rethrowing error',
      );
      rethrow;
    }
  }

  @override
  Future<ApiResponse<CalendarModel>> getReservationCalendar({
    required String menuId,
    String? month,
  }) async {
    try {
      final queryParameters = <String, String>{'menu_id': menuId};
      if (month != null) {
        queryParameters['month'] = month;
      }

      final response = await _dioClient.get<CalendarModel>(
        ApiEndpoints.customerReservationCalendar,
        fromJson: (json) {
          DebugHelper.logMapDetails(
            json as Map<String, dynamic>,
            title: 'Calendar API Response Data',
          );
          return CalendarModel.fromMap(json);
        },
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      return response;
    } catch (e) {
      DebugHelper.safeCast(
        e,
        'getReservationCalendar_error',
        defaultValue: 'rethrowing error',
      );
      rethrow;
    }
  }

  @override
  Future<ApiResponse<AvailableHourModel>> getReservationAvailableHours({
    required String date,
    required String menuId,
  }) async {
    try {
      final queryParameters = <String, String>{'menu_id': menuId, 'date': date};

      final response = await _dioClient.get<AvailableHourModel>(
        ApiEndpoints.customerReservationAvailableHours,
        fromJson: (json) {
          DebugHelper.logMapDetails(
            json as Map<String, dynamic>,
            title: 'AvailableHours API Response Data',
          );
          return AvailableHourModel.fromMap(json);
        },
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      return response;
    } catch (e) {
      DebugHelper.safeCast(
        e,
        'getReservationAvailableHours_error',
        defaultValue: 'rethrowing error',
      );
      rethrow;
    }
  }
}
