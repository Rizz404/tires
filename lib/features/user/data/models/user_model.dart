import 'dart:convert';

import 'package:tires/features/user/data/models/password_reset_token_model.dart';
import 'package:tires/features/user/data/models/session_model.dart';
import 'package:tires/features/user/domain/entities/password_reset_token.dart';
import 'package:tires/features/user/domain/entities/session.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.emailVerifiedAt,
    super.password,
    required super.fullName,
    required super.fullNameKana,
    required super.phoneNumber,
    super.companyName,
    super.department,
    super.companyAddress,
    super.homeAddress,
    super.dateOfBirth,
    required super.role,
    super.gender,
    required super.createdAt,
    required super.updatedAt,
    super.passwordResetToken,
    super.session,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      // Add debugging for critical fields that might cause type errors
      final roleValue = map['role'];
      final genderValue = map['gender'];

      // Safe role parsing
      UserRole role;
      try {
        role = UserRole.values.byName(roleValue as String);
      } catch (e) {
        print(
          'Warning: Invalid role value "$roleValue", defaulting to customer',
        );
        role = UserRole.customer;
      }

      // Safe gender parsing
      UserGender? gender;
      if (genderValue != null) {
        try {
          gender = UserGender.values.byName(genderValue as String);
        } catch (e) {
          print(
            'Warning: Invalid gender value "$genderValue", setting to null',
          );
          gender = null;
        }
      }

      return UserModel(
        id: map['id']! as int,
        email: map['email'] as String,
        emailVerifiedAt: DateTime.parse(map['email_verified_at'] as String),
        password: null, // Tidak ada di response login
        fullName: map['full_name'] as String,
        fullNameKana: map['full_name_kana'] as String,
        phoneNumber: map['phone_number'] as String,
        companyName: map['company_name'] as String?,
        department: map['department'] as String?,
        companyAddress: map['company_address'] as String?,
        homeAddress: map['home_address'] as String?,
        dateOfBirth: map['date_of_birth'] != null
            ? DateTime.parse(map['date_of_birth'] as String)
            : null,
        role: role,
        gender: gender,
        createdAt: DateTime.parse(map['created_at'] as String),
        updatedAt: DateTime.parse(map['updated_at'] as String),
        passwordResetToken: null, // Tidak ada di response login
        session: null, // Tidak ada di response login
      );
    } catch (e, stackTrace) {
      print('Error parsing UserModel from map: $e');
      print('Map data: $map');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    int? id,
    String? email,
    DateTime? emailVerifiedAt,
    String? password,
    String? fullName,
    String? fullNameKana,
    String? phoneNumber,
    String? companyName,
    String? department,
    String? companyAddress,
    String? homeAddress,
    DateTime? dateOfBirth,
    UserRole? role,
    UserGender? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
    PasswordResetToken? passwordResetToken,
    Session? session,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      fullNameKana: fullNameKana ?? this.fullNameKana,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      companyName: companyName ?? this.companyName,
      department: department ?? this.department,
      companyAddress: companyAddress ?? this.companyAddress,
      homeAddress: homeAddress ?? this.homeAddress,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      passwordResetToken: passwordResetToken ?? this.passwordResetToken,
      session: session ?? this.session,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'email_verified_at': emailVerifiedAt.toIso8601String(),
      'password': password,
      'full_name': fullName,
      'full_name_kana': fullNameKana,
      'phone_number': phoneNumber,
      'company_name': companyName,
      'department': department,
      'company_address': companyAddress,
      'home_address': homeAddress,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'role': role.name,
      'gender': gender?.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'password_reset_token': (passwordResetToken as PasswordResetTokenModel?)
          ?.toMap(),
      'session': (session as SessionModel?)?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
