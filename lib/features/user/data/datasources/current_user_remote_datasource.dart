import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/user/data/models/user_model.dart';


abstract class CurrentUserRemoteDatasource {
  Future<ApiResponse<UserModel>> getCurrentUser();
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
  });
  Future<ApiResponse<dynamic>> updateCurrentUserPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<ApiResponse<dynamic>> deleteCurrentUserAccount();
}

class CurrentUserRemoteDatasourceImpl implements CurrentUserRemoteDatasource {
  final DioClient _dioClient;

  CurrentUserRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<UserModel>> getCurrentUser() async {
    try {
      AppLogger.networkInfo('Fetching current user profile');
      final response = await _dioClient.get<UserModel>(
        ApiEndpoints.customerProfile,
        fromJson: (json) => UserModel.fromMap(json as Map<String, dynamic>),
      );

      AppLogger.networkInfo('Successfully fetched current user profile');
      return response;
    } catch (e) {
      AppLogger.networkError('Failed to fetch current user profile', e);
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
      AppLogger.networkInfo('Updating current user profile');
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
          return UserModel.fromMap(json);
        },
      );

      AppLogger.networkInfo('Successfully updated current user profile');
      return response;
    } catch (e) {
      AppLogger.networkError('Failed to update current user profile', e);
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
      AppLogger.networkInfo('Updating current user password');
      final data = {
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      };

      final response = await _dioClient.patch(
        '${ApiEndpoints.customerProfile}/password',
        data: data,
      );

      AppLogger.networkInfo('Successfully updated current user password');
      return response;
    } catch (e) {
      AppLogger.networkError('Failed to update current user password', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteCurrentUserAccount() async {
    try {
      AppLogger.networkInfo('Deleting current user account');
      final response = await _dioClient.delete(ApiEndpoints.customerProfile);
      AppLogger.networkInfo('Successfully deleted current user account');
      return response;
    } catch (e) {
      AppLogger.networkError('Failed to delete current user account', e);
      rethrow;
    }
  }
}
