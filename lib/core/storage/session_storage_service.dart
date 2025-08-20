import 'package:tires/features/user/domain/entities/user.dart';

abstract class SessionStorageService {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String token);
  Future<void> deleteAccessToken();

  // * User
  Future<User?> getUser();
  Future<void> saveUser(User user);
  Future<void> deleteUser();
}
