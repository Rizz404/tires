import 'package:tires/features/authentication/data/models/auth_model.dart';
import 'package:tires/features/authentication/domain/entities/auth.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/data/models/user_model.dart'; // Asumsi lokasi mapper user

extension AuthModelMapper on AuthModel {
  Auth toEntity() {
    return Auth(user: (user as UserModel).toEntity(), token: token);
  }
}

extension AuthEntityMapper on Auth {
  AuthModel toModel() {
    return AuthModel(user: user.toModel(), token: token);
  }
}
