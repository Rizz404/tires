import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_usecase.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_password_usecase.dart';

abstract class CurrentUserRemoteDatasource {
  Future<ApiResponse<UserModel>> getCurrentUser();
  Future<ApiResponse<UserModel>> updateCurrentUser(UpdateUserParams params);
  Future<ApiResponse<dynamic>> updateCurrentUserPassword(
    UpdateUserPasswordParams params,
  );
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
  Future<ApiResponse<UserModel>> updateCurrentUser(
    UpdateUserParams params,
  ) async {
    try {
      AppLogger.networkInfo('Updating current user profile');
      final response = await _dioClient.patch<UserModel>(
        ApiEndpoints.customerProfile,
        data: params.toMap(),
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
  Future<ApiResponse<dynamic>> updateCurrentUserPassword(
    UpdateUserPasswordParams params,
  ) async {
    try {
      AppLogger.networkInfo('Updating current user password');
      final response = await _dioClient.patch<dynamic>(
        ApiEndpoints.setNewPassword,
        data: params.toMap(),
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
      final response = await _dioClient.delete<dynamic>(
        ApiEndpoints.customerProfile,
      );
      AppLogger.networkInfo('Successfully deleted current user account');
      return response;
    } catch (e) {
      AppLogger.networkError('Failed to delete current user account', e);
      rethrow;
    }
  }
}
