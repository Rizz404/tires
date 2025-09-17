import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/user/data/datasources/current_user_remote_datasource.dart';
import 'package:tires/features/user/data/models/user_model.dart';

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
  Future<ApiResponse<dynamic>> deleteCurrentUserAccount() async {
    try {
      final response = await _dioClient.delete(ApiEndpoints.customerProfile);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
