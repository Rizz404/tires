import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/customer_management/data/models/customer_dashboard_model.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/features/user/data/datasources/current_user_remote_datasource.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class CurrentUserRemoteDatasourceImpl implements CurrentUserRemoteDatasource {
  final DioClient _dioClient;

  CurrentUserRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<UserModel>> getCurrentUser() async {
    try {
      final response = await _dioClient.get<UserModel>(
        ApiEndpoints.customerProfile,
        fromJson: (json) => UserModel.fromMap(json as Map<String, dynamic>),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<UserModel>> updateCurrentUser({
    required String fullName,
    required String fullNameKana,
    required String email,
    required String phoneNumber,
    String? companyName,
    String? department,
    String? companyAddress,
    String? homeAddress,
    DateTime? dateOfBirth,
    String? gender,
  }) async {
    try {
      final data = {
        'full_name': fullName,
        'full_name_kana': fullNameKana,
        'email': email,
        'phone_number': phoneNumber,
        if (companyName != null) 'company_name': companyName,
        if (department != null) 'department': department,
        if (companyAddress != null) 'company_address': companyAddress,
        if (homeAddress != null) 'home_address': homeAddress,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth.toIso8601String(),
        if (gender != null) 'gender': gender,
      };

      final response = await _dioClient.patch<UserModel>(
        ApiEndpoints.customerProfile,
        data: data,
        fromJson: (json) {
          // Add debugging to catch type errors in update user
          DebugHelper.logMapDetails(
            json as Map<String, dynamic>,
            title: 'Update User API Response Data',
          );
          return UserModel.fromMap(json);
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> updateCurrentUserPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final data = {
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      };

      final response = await _dioClient.patch(
        '${ApiEndpoints.customerProfile}/password',
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<CustomerDashboardModel>> getCurrentUserDashboard() async {
    try {
      final response = await _dioClient.get<CustomerDashboardModel>(
        '${ApiEndpoints.customerProfile}/dashboard',
        fromJson: (json) {
          DebugHelper.logMapDetails(
            json as Map<String, dynamic>,
            title: 'Customer Dashboard API Response Data',
          );
          return CustomerDashboardModel.fromMap(json);
        },
      );

      return response;
    } catch (e) {
      DebugHelper.safeCast(
        e,
        'getCurrentUserDashboard_error',
        defaultValue: 'rethrowing error',
      );
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<ReservationModel>>
  getCurrentUserReservations({
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
        ApiEndpoints.customerReservations,
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
        'getCurrentUserReservations_error',
        defaultValue: 'rethrowing error',
      );
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteCurrentUserAccount() async {
    try {
      final response = await _dioClient.delete(ApiEndpoints.customerProfile);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
