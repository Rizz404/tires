import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/routes/auth_guard.dart';
import 'package:tires/core/routes/duplicate_guard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tires/core/storage/language_storage_service.dart';
import 'package:tires/di/service_providers.dart';
import 'package:tires/l10n_generated/app_localizations.dart';

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
  final dioClient = DioClient(_dio);

  // * Listen ke locale dan update dio
  ref.listen<Locale>(localeProvider, (previous, next) {
    dioClient.updateLocale(next);
  });

  // * Set initial locale
  final currentLocale = ref.read(localeProvider);

  dioClient.updateLocale(currentLocale);

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

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final languageStorageService = ref.watch(languageStorageServiceProvider);
  return LocaleNotifier(languageStorageService);
});

class LocaleNotifier extends StateNotifier<Locale> {
  final LanguageStorageService _languageStorageService;

  LocaleNotifier(this._languageStorageService)
    : super(L10n.supportedLocales.first) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      final locale = await _languageStorageService.getLocale();
      state = locale;
    } catch (e) {
      state = L10n.supportedLocales.first;
    }
  }

  Future<void> changeLocale(Locale newLocale) async {
    try {
      if (L10n.supportedLocales.contains(newLocale)) {
        await _languageStorageService.setLocale(newLocale);
        state = newLocale;
      } else {
        throw ArgumentError('Unsupported locale: $newLocale');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetLocale() async {
    try {
      await _languageStorageService.removeLocale();
      state = L10n.supportedLocales.first;
    } catch (e) {
      rethrow;
    }
  }
}
