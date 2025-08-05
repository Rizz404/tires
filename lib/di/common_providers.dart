import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/routes/auth_guard.dart';
import 'package:tires/core/routes/duplicate_guard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tires/l10n/app_localizations.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  throw UnimplementedError('secureStorageProvider not initialized');
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider not initialized');
});

final sharedPreferencesWithCacheProvider = Provider<SharedPreferencesWithCache>(
  (ref) {
    throw UnimplementedError(
      'sharedPreferencesWithCacheProvider not initialized',
    );
  },
);

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final dioClientProvider = Provider<DioClient>((ref) {
  final _dio = ref.watch(dioProvider);
  return DioClient(_dio);
});

final authGuardProvider = Provider<AuthGuard>((ref) {
  return AuthGuard();
});

final duplicateGuardProvider = Provider<DuplicateGuard>((ref) {
  return DuplicateGuard();
});

final appRouterProvider = Provider<AppRouter>((ref) {
  final _authGuard = ref.watch(authGuardProvider);
  final _duplicateGuard = ref.watch(duplicateGuardProvider);
  return AppRouter(_authGuard, _duplicateGuard);
});

final localeProvider = StateProvider<Locale>((ref) {
  return L10n.supportedLocales.first;
});
