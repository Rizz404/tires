import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/reservation/data/models/available_hour_model.dart';
import 'package:tires/features/reservation/data/models/calendar_model.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_current_user_reservations_cursor_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_available_hours_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_calendar_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_cursor_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/update_reservation_usecase.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

abstract class ReservationRemoteDatasource {
  Future<ApiResponse<ReservationModel>> createReservation(
    CreateReservationParams params,
  );
  Future<ApiCursorPaginationResponse<ReservationModel>> getReservationsCursor(
    GetReservationCursorParams params,
  );
  Future<ApiCursorPaginationResponse<ReservationModel>>
  getCurrentUserReservations(GetCurrentUserReservationsCursorParams params);
  // * Contoh month 2025-08, 2025-09, 2025-10, 2025-11, 2025-12
  Future<ApiResponse<CalendarModel>> getReservationCalendar(
    GetReservationCalendarParams params,
  );
  Future<ApiResponse<AvailableHourModel>> getReservationAvailableHours(
    GetReservationAvailableHoursParams params,
  );
  Future<ApiResponse<ReservationModel>> updateReservation(
    UpdateReservationParams params,
  );
  Future<ApiResponse<ReservationModel>> deleteReservation(
    DeleteReservationParams params,
  );
}

class ReservationRemoteDatasourceImpl implements ReservationRemoteDatasource {
  final DioClient _dioClient;

  ReservationRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<ReservationModel>> createReservation(
    CreateReservationParams params,
  ) async {
    try {
      final data = params.toMap();

      final response = await _dioClient.post<ReservationModel>(
        ApiEndpoints.customerCreateReservation,
        data: data,
        fromJson: (item) {
          DebugHelper.logMapDetails(
            item as Map<String, dynamic>,
            title: 'Create reservation from API',
          );
          return ReservationModel.fromMap(item);
        },
      );

      return response;
    } catch (e) {
      DebugHelper.safeCast(
        e,
        'createReservation_error',
        defaultValue: 'rethrowing error',
      );
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<ReservationModel>> getReservationsCursor(
    GetReservationCursorParams params,
  ) async {
    try {
      final queryParameters = params.toMap();

      final response = await _dioClient.getWithCursor<ReservationModel>(
        ApiEndpoints.adminReservations,
        fromJson: (item) {
          DebugHelper.logMapDetails(
            item as Map<String, dynamic>,
            title: 'Raw Reservation Item from API',
          );
          return ReservationModel.fromMap(item);
        },
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
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
  Future<ApiCursorPaginationResponse<ReservationModel>>
  getCurrentUserReservations(
    GetCurrentUserReservationsCursorParams params,
  ) async {
    try {
      final queryParameters = params.toMap();

      final response = await _dioClient.getWithCursor<ReservationModel>(
        ApiEndpoints.customerReservations,
        fromJson: (item) {
          DebugHelper.logMapDetails(
            item as Map<String, dynamic>,
            title: 'Raw Reservation Item from API',
          );
          return ReservationModel.fromMap(item);
        },
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      return response;
    } catch (e) {
      DebugHelper.safeCast(
        e,
        'getCurrentUserReservations_error',
        defaultValue: 'rethrowing error',
      );
      rethrow;
    }
  }

  @override
  Future<ApiResponse<CalendarModel>> getReservationCalendar(
    GetReservationCalendarParams params,
  ) async {
    try {
      final queryParameters = params.toMap();

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
  Future<ApiResponse<AvailableHourModel>> getReservationAvailableHours(
    GetReservationAvailableHoursParams params,
  ) async {
    try {
      final queryParameters = params.toMap();

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

  @override
  Future<ApiResponse<ReservationModel>> updateReservation(
    UpdateReservationParams params,
  ) async {
    // TODO: implement updateReservation - method not available in API
    throw UnimplementedError('updateReservation method not implemented in API');
  }

  @override
  Future<ApiResponse<ReservationModel>> deleteReservation(
    DeleteReservationParams params,
  ) async {
    // TODO: implement deleteReservation - method not available in API
    throw UnimplementedError('deleteReservation method not implemented in API');
  }
}
