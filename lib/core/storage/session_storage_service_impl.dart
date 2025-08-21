import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tires/core/storage/session_storage_keys.dart';
import 'package:tires/core/storage/session_storage_service.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class SessionStorageServiceImpl implements SessionStorageService {
  final FlutterSecureStorage _flutterSecureStorage;
  final SharedPreferencesWithCache _sharedPreferencesWithCache;
  final Logger _logger = Logger();

  SessionStorageServiceImpl(
    this._flutterSecureStorage,
    this._sharedPreferencesWithCache,
  );

  @override
  Future<String?> getAccessToken() async {
    final token = await _flutterSecureStorage.read(
      key: SessionStorageKeys.accessTokenKey,
    );
    _logger.i("Get Access Token: $token");
    return token;
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await _flutterSecureStorage.write(
      key: SessionStorageKeys.accessTokenKey,
      value: token,
    );
    _logger.i("Saved Access Token: $token");
  }

  @override
  Future<void> deleteAccessToken() async {
    await _flutterSecureStorage.delete(key: SessionStorageKeys.accessTokenKey);
    _logger.w("Deleted Access Token");
  }

  @override
  Future<User?> getUser() async {
    final userJson = await _sharedPreferencesWithCache.getString(
      SessionStorageKeys.userKey,
    );

    if (userJson != null) {
      final userModelJson = UserModel.fromJson(jsonDecode(userJson));
      final user = userModelJson.toEntity();
      _logger.i("Get User: ${user.toString()}");
      return user;
    }

    _logger.w("No user found in storage");
    return null;
  }

  @override
  Future<void> saveUser(User user) async {
    final userModel = user.toModel();
    await _sharedPreferencesWithCache.setString(
      SessionStorageKeys.userKey,
      jsonEncode(userModel.toJson()),
    );
    _logger.i("Saved User: ${user.toString()}");
  }

  @override
  Future<void> deleteUser() async {
    await _sharedPreferencesWithCache.remove(SessionStorageKeys.userKey);
    _logger.w("Deleted User");
  }
}
