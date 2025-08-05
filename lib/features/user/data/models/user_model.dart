import 'dart:convert';

import 'package:tires/features/user/data/models/password_reset_token_model.dart';
import 'package:tires/features/user/data/models/session_model.dart';

import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/domain/entities/password_reset_token.dart';
import 'package:tires/features/user/domain/entities/session.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.emailVerifiedAt,
    required super.password,
    required super.fullName,
    required super.fullNameKana,
    required super.phoneNumber,
    super.companyName,
    super.department,
    super.companyAddress,
    super.homeAddress,
    super.dateOfBirth,
    required super.role,
    required super.gender,
    required super.createdAt,
    required super.updatedAt,
    required super.passwordResetToken,
    required super.session,
  });

  UserModel copyWith({
    String? id,
    String? email,
    bool? emailVerifiedAt,
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
      'emailVerifiedAt': emailVerifiedAt,
      'password': password,
      'fullName': fullName,
      'fullNameKana': fullNameKana,
      'phoneNumber': phoneNumber,
      'companyName': companyName,
      'department': department,
      'companyAddress': companyAddress,
      'homeAddress': homeAddress,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'role': role.name,
      'gender': gender.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'passwordResetToken': PasswordResetTokenModel(
        email: this.email,
        token: passwordResetToken.token,
        createdAt: passwordResetToken.createdAt,
      ).toMap(),
      'session': SessionModel(
        id: session.id,
        userId: this.id,
        ipAddress: session.ipAddress,
        userAgent: session.userAgent,
        payload: session.payload,
        lastActivity: session.lastActivity,
      ).toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      emailVerifiedAt: map['emailVerifiedAt'] as bool,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      fullNameKana: map['fullNameKana'] as String,
      phoneNumber: map['phoneNumber'] as String,
      companyName: map['companyName'] != null
          ? map['companyName'] as String
          : null,
      department: map['department'] != null
          ? map['department'] as String
          : null,
      companyAddress: map['companyAddress'] != null
          ? map['companyAddress'] as String
          : null,
      homeAddress: map['homeAddress'] != null
          ? map['homeAddress'] as String
          : null,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map['dateOfBirth'] as String)
          : null,
      role: UserRole.values.byName(map['role'] as String),
      gender: UserGender.values.byName(map['gender'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      passwordResetToken: PasswordResetTokenModel.fromMap(
        map['passwordResetToken'] as Map<String, dynamic>,
      ),
      session: SessionModel.fromMap(map['session'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
