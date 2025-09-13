import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/entities/auth.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';

class LoginUsecase implements Usecase<ItemSuccessResponse<Auth>, LoginParams> {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Auth>>> call(
    LoginParams params,
  ) async {
    return await _authRepository.login(params);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  String toJson() => json.encode(toMap());
}
