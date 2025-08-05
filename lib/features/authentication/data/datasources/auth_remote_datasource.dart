import 'dart:convert';

import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/user/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<ApiResponse<UserModel>> register(RegisterPayload payload);
  Future<ApiResponse<UserModel>> login(LoginPayload payload);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient _dioClient;

  AuthRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<UserModel>> register(RegisterPayload payload) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: payload.toJson(),
        fromJson: (json) => UserModel.fromMap(json as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<UserModel>> login(LoginPayload payload) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: payload.toJson(),
        fromJson: (json) => UserModel.fromMap(json as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

// * Payload kaga butuh equatable di params baru butuh
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
