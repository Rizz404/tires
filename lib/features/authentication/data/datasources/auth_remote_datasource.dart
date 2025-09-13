// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/authentication/data/models/auth_model.dart';
import 'package:tires/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/set_new_password_usecase.dart';

abstract class AuthRemoteDatasource {
  Future<ApiResponse<AuthModel>> register(RegisterParams params);
  Future<ApiResponse<AuthModel>> login(LoginParams params);
  Future<ApiResponse<void>> logout();
  Future<ApiResponse<void>> forgotPassword(ForgotPasswordParams params);
  Future<ApiResponse<void>> setNewPassword(SetNewPasswordParams params);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient _dioClient;

  AuthRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<AuthModel>> register(RegisterParams params) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.register,
        data: params.toMap(),
        fromJson: (json) => AuthModel.fromMap(json as Map<String, dynamic>),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<AuthModel>> login(LoginParams params) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: params.toMap(),
        fromJson: (json) => AuthModel.fromMap(json as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<void>> logout() async {
    try {
      final response = await _dioClient.post(ApiEndpoints.logout);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<void>> forgotPassword(ForgotPasswordParams params) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.forgotPassword,
        data: params.toMap(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<void>> setNewPassword(SetNewPasswordParams params) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.setNewPassword,
        data: params.toMap(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
