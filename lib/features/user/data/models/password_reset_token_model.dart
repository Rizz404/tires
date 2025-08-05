import 'dart:convert';

import 'package:tires/features/user/domain/entities/password_reset_token.dart';

class PasswordResetTokenModel extends PasswordResetToken {
  PasswordResetTokenModel({
    required super.email,
    required super.token,
    required super.createdAt,
  });

  factory PasswordResetTokenModel.fromMap(Map<String, dynamic> map) {
    return PasswordResetTokenModel(
      email: map['email'] as String,
      token: map['token'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'token': token,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory PasswordResetTokenModel.fromJson(String source) =>
      PasswordResetTokenModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  String toJson() => json.encode(toMap());
}
