// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/authentication/data/models/auth_model.dart';

abstract class AuthRemoteDatasource {
  Future<ApiResponse<AuthModel>> register(RegisterPayload payload);
  Future<ApiResponse<AuthModel>> login(LoginPayload payload);
  Future<ApiResponse<void>> forgotPassword(ForgotPasswordPayload payload);
  Future<ApiResponse<void>> setNewPassword(SetNewPasswordPayload payload);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient _dioClient;

  AuthRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<AuthModel>> register(RegisterPayload payload) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.register,
        data: payload.toJson(),
        fromJson: (json) => AuthModel.fromMap(json as Map<String, dynamic>),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<AuthModel>> login(LoginPayload payload) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: payload.toJson(),
        fromJson: (json) => AuthModel.fromMap(json as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<void>> forgotPassword(
    ForgotPasswordPayload payload,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.forgotPassword,
        data: payload.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<void>> setNewPassword(
    SetNewPasswordPayload payload,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.setNewPassword,
        data: payload.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

// * Payload kaga butuh equatable di payload baru butuh
class RegisterPayload {
  final String username;
  final String email;
  final String password;

  const RegisterPayload({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory RegisterPayload.fromMap(Map<String, dynamic> map) {
    return RegisterPayload(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterPayload.fromJson(String source) =>
      RegisterPayload.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LoginPayload {
  final String email;
  final String password;

  const LoginPayload({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  factory LoginPayload.fromMap(Map<String, dynamic> map) {
    return LoginPayload(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginPayload.fromJson(String source) =>
      LoginPayload.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ForgotPasswordPayload {
  final String email;

  const ForgotPasswordPayload({required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email};
  }

  factory ForgotPasswordPayload.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordPayload(email: map['email'] as String);
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordPayload.fromJson(String source) =>
      ForgotPasswordPayload.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

class SetNewPasswordPayload {
  final String newPassword;
  final String confirmNewPassword;

  const SetNewPasswordPayload({
    required this.newPassword,
    required this.confirmNewPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }

  factory SetNewPasswordPayload.fromMap(Map<String, dynamic> map) {
    return SetNewPasswordPayload(
      newPassword: map['newPassword'] as String,
      confirmNewPassword: map['confirmNewPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SetNewPasswordPayload.fromJson(String source) =>
      SetNewPasswordPayload.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
