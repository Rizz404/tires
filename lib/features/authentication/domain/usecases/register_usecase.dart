// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/entities/auth.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class RegisterUsecase
    implements Usecase<ItemSuccessResponse<Auth>, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUsecase(this._authRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Auth>>> call(
    RegisterParams params,
  ) async {
    return await _authRepository.register(params);
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String fullName;
  final String fullNameKana;
  final String phoneNumber;
  final String? companyName;
  final String? department;
  final String? companyAddress;
  final String? homeAddress;
  final DateTime dateOfBirth;
  final UserGender gender;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.fullNameKana,
    required this.phoneNumber,
    this.companyName,
    this.department,
    this.companyAddress,
    this.homeAddress,
    required this.dateOfBirth,
    required this.gender,
  });

  @override
  List<Object?> get props {
    return [
      email,
      password,
      fullName,
      fullNameKana,
      phoneNumber,
      companyName,
      department,
      companyAddress,
      homeAddress,
      dateOfBirth,
      gender,
    ];
  }
}
