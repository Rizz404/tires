import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/features/user/domain/entities/user.dart';

extension UserModelMapper on UserModel {
  User toEntity() {
    return User(
      id: id,
      email: email,
      emailVerifiedAt: emailVerifiedAt,
      password: password ?? '',
      fullName: fullName,
      fullNameKana: fullNameKana,
      phoneNumber: phoneNumber,
      companyName: companyName,
      department: department,
      companyAddress: companyAddress,
      homeAddress: homeAddress,
      dateOfBirth: dateOfBirth,
      role: role,
      gender: gender,
      createdAt: createdAt,
      updatedAt: updatedAt,
      passwordResetToken: passwordResetToken,
      session: session,
    );
  }
}

extension UserEntityMapper on User {
  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      fullName: fullName,
      fullNameKana: fullNameKana,
      phoneNumber: phoneNumber,
      companyName: companyName,
      department: department,
      companyAddress: companyAddress,
      homeAddress: homeAddress,
      dateOfBirth: dateOfBirth,
      role: role,
      gender: gender,
      emailVerifiedAt: emailVerifiedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      passwordResetToken: passwordResetToken,
      session: session,
    );
  }
}
