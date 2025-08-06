import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/storage/language_storage_service.dart';
import 'package:tires/core/storage/language_storage_service_impl.dart';
import 'package:tires/core/storage/session_storage_service.dart';
import 'package:tires/core/storage/session_storage_service_impl.dart';
import 'package:tires/di/common_providers.dart';

final sessionStorageServiceProvider = Provider<SessionStorageService>((ref) {
  final _sharedPreferencesWithCache = ref.watch(
    sharedPreferencesWithCacheProvider,
  );
  final _flutterSecureStorage = ref.watch(secureStorageProvider);

  return SessionStorageServiceImpl(
    _flutterSecureStorage,
    _sharedPreferencesWithCache,
  );
});

final languageStorageServiceProvider = Provider<LanguageStorageService>((ref) {
  final _sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LanguageStorageServiceImpl(_sharedPreferences);
});
