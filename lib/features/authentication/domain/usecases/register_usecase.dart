// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
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
    AppLogger.businessInfo('Executing register usecase');
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
  final String role;
  final String passwordConfirmation;

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
    this.role = 'customer',
    required this.passwordConfirmation,
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
      role,
      passwordConfirmation,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'full_name': fullName,
      'full_name_kana': fullNameKana,
      'phone_number': phoneNumber,
      'company_name': companyName,
      'department': department,
      'company_address': companyAddress,
      'home_address': homeAddress,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender.name,
      'role': role,
      'password_confirmation': passwordConfirmation,
    };
  }

  String toJson() => json.encode(toMap());

  RegisterParams copyWith({
    String? email,
    String? password,
    String? fullName,
    String? fullNameKana,
    String? phoneNumber,
    ValueGetter<String?>? companyName,
    ValueGetter<String?>? department,
    ValueGetter<String?>? companyAddress,
    ValueGetter<String?>? homeAddress,
    DateTime? dateOfBirth,
    UserGender? gender,
    String? role,
    String? passwordConfirmation,
  }) {
    return RegisterParams(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      fullNameKana: fullNameKana ?? this.fullNameKana,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      companyName: companyName != null ? companyName() : this.companyName,
      department: department != null ? department() : this.department,
      companyAddress: companyAddress != null
          ? companyAddress()
          : this.companyAddress,
      homeAddress: homeAddress != null ? homeAddress() : this.homeAddress,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  factory RegisterParams.fromMap(Map<String, dynamic> map) {
    return RegisterParams(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      fullName: map['full_name'] ?? '',
      fullNameKana: map['full_name_kana'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      companyName: map['company_name'],
      department: map['department'],
      companyAddress: map['company_address'],
      homeAddress: map['home_address'],
      dateOfBirth: DateTime.parse(map['date_of_birth']),
      gender: UserGender.values.firstWhere((g) => g.name == map['gender']),
      role: map['role'] ?? 'customer',
      passwordConfirmation: map['password_confirmation'] ?? '',
    );
  }

  factory RegisterParams.fromJson(String source) =>
      RegisterParams.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegisterParams(email: $email, password: $password, fullName: $fullName, fullNameKana: $fullNameKana, phoneNumber: $phoneNumber, companyName: $companyName, department: $department, companyAddress: $companyAddress, homeAddress: $homeAddress, dateOfBirth: $dateOfBirth, gender: $gender, role: $role, passwordConfirmation: $passwordConfirmation)';
  }
}
