import 'package:tires/features/user/domain/entities/user.dart';

abstract class SessionStorageService {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveAccessToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<void> deleteAccessToken();
  Future<void> deleteRefreshToken();

  // * User
  Future<User?> getUser();
  Future<void> saveUser(User user);
  Future<void> deleteUser();
}
