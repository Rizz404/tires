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
          return ReservationModel.fromMap(item);
        },
      );

      return response;
    } catch (e) {
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
          return ReservationModel.fromMap(item);
        },
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      return response;
    } catch (e) {
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
          return ReservationModel.fromMap(item);
        },
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      return response;
    } catch (e) {
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
          return CalendarModel.fromMap(json);
        },
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      return response;
    } catch (e) {
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
          return AvailableHourModel.fromMap(json);
        },
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      return response;
    } catch (e) {
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
