import 'package:equatable/equatable.dart';
import 'package:tires/features/user/domain/entities/password_reset_token.dart';
import 'package:tires/features/user/domain/entities/session.dart';

enum UserRole { customer, admin }

enum UserGender { male, female, other }

extension UserGenderExtension on UserGender {
  String toMap() {
    return name;
  }
}

UserGender userGenderFromMap(String value) {
  return UserGender.values.firstWhere((e) => e.name == value);
}

class User extends Equatable {
  final int id;
  final String email;
  final DateTime emailVerifiedAt;
  final String? password;
  final String fullName;
  final String fullNameKana;
  final String phoneNumber;
  final String? companyName;
  final String? department;
  final String? companyAddress;
  final String? homeAddress;
  final DateTime? dateOfBirth;
  final UserRole role;
  final UserGender? gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PasswordResetToken? passwordResetToken;
  final Session? session;

  const User({
    required this.id,
    required this.email,
    required this.emailVerifiedAt,
    this.password,
    required this.fullName,
    required this.fullNameKana,
    required this.phoneNumber,
    this.companyName,
    this.department,
    this.companyAddress,
    this.homeAddress,
    this.dateOfBirth,
    required this.role,
    this.gender,
    required this.createdAt,
    required this.updatedAt,
    this.passwordResetToken,
    this.session,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      emailVerifiedAt,
      password,
      fullName,
      fullNameKana,
      phoneNumber,
      companyName,
      department,
      companyAddress,
      homeAddress,
      dateOfBirth,
      role,
      gender,
      createdAt,
      updatedAt,
      passwordResetToken,
      session,
    ];
  }
}
