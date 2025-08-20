import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tires/core/storage/session_storage_keys.dart';
import 'package:tires/core/storage/session_storage_service.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStorageServiceImpl implements SessionStorageService {
  final FlutterSecureStorage _flutterSecureStorage;
  final SharedPreferencesWithCache _sharedPreferencesWithCache;

  SessionStorageServiceImpl(
    this._flutterSecureStorage,
    this._sharedPreferencesWithCache,
  );

  @override
  Future<String?> getAccessToken() async {
    return await _flutterSecureStorage.read(
      key: SessionStorageKeys.accessTokenKey,
    );
  }

  @override
  Future<void> saveAccessToken(String token) async {
    _flutterSecureStorage.write(
      key: SessionStorageKeys.accessTokenKey,
      value: token,
    );
  }

  @override
  Future<void> deleteAccessToken() async {
    _flutterSecureStorage.delete(key: SessionStorageKeys.accessTokenKey);
  }

  @override
  Future<User?> getUser() async {
    final userJson = await _sharedPreferencesWithCache.getString(
      SessionStorageKeys.userKey,
    );

    if (userJson != null) {
      final userModelJson = UserModel.fromJson(jsonDecode(userJson));
      return userModelJson.toEntity();
    }

    return null;
  }

  @override
  Future<void> saveUser(User user) async {
    final userModel = user.toModel();
    await _sharedPreferencesWithCache.setString(
      SessionStorageKeys.userKey,
      jsonDecode(userModel.toJson()),
    );
  }

  @override
  Future<void> deleteUser() async {
    await _sharedPreferencesWithCache.remove(SessionStorageKeys.userKey);
  }
}
