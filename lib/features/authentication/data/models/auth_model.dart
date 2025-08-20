import 'dart:convert';
import 'package:tires/features/authentication/domain/entities/auth.dart';
import 'package:tires/features/user/data/models/user_model.dart';

class AuthModel extends Auth {
  const AuthModel({required UserModel super.user, required super.token});

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      token: map['token'] as String,
    );
  }

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': (user as UserModel).toMap(),
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());
}
