import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:tires/core/services/app_logger.dart';

/// Provider untuk mendapatkan logger berdasarkan tipe
final loggerProvider = Provider.family<Logger, LoggerType>((ref, type) {
  return AppLogger.getLogger(type);
});

/// Provider untuk network logger
final networkLoggerProvider = Provider<Logger>((ref) {
  return AppLogger.getLogger(LoggerType.network);
});

/// Provider untuk auth logger
final authLoggerProvider = Provider<Logger>((ref) {
  return AppLogger.getLogger(LoggerType.auth);
});

/// Provider untuk database logger
final databaseLoggerProvider = Provider<Logger>((ref) {
  return AppLogger.getLogger(LoggerType.database);
});

/// Provider untuk UI logger
final uiLoggerProvider = Provider<Logger>((ref) {
  return AppLogger.getLogger(LoggerType.ui);
});

/// Provider untuk business logger
final businessLoggerProvider = Provider<Logger>((ref) {
  return AppLogger.getLogger(LoggerType.business);
});

/// Provider untuk general logger
final generalLoggerProvider = Provider<Logger>((ref) {
  return AppLogger.getLogger(LoggerType.general);
});

/// Provider untuk AppLogger service
final appLoggerServiceProvider = Provider<AppLogger>((ref) {
  // Inisialisasi logger saat pertama kali dipanggil
  AppLogger.initialize();
  return AppLogger();
});

/// State notifier untuk mengelola konfigurasi logging
class LoggerConfigNotifier extends StateNotifier<LoggerConfig> {
  LoggerConfigNotifier() : super(const LoggerConfig());

  /// Mengatur level global untuk semua logger
  void setGlobalLevel(Level level) {
    AppLogger.reinitializeWithLevel(level);
    state = state.copyWith(globalLevel: level);
  }

  /// Mengatur level untuk logger tertentu
  void setLoggerLevel(LoggerType type, Level level) {
    AppLogger.reinitializeLoggerWithLevel(type, level);
    final newLevels = Map<LoggerType, Level>.from(state.loggerLevels);
    newLevels[type] = level;
    state = state.copyWith(loggerLevels: newLevels);
  }

  /// Reset ke konfigurasi default
  void resetToDefault() {
    AppLogger.initialize();
    state = const LoggerConfig();
  }
}

/// Provider untuk logger config notifier
final loggerConfigProvider =
    StateNotifierProvider<LoggerConfigNotifier, LoggerConfig>((ref) {
      return LoggerConfigNotifier();
    });

/// Model untuk konfigurasi logger
class LoggerConfig {
  final Level globalLevel;
  final Map<LoggerType, Level> loggerLevels;
  final bool isInitialized;

  const LoggerConfig({
    this.globalLevel = Level.debug,
    this.loggerLevels = const {},
    this.isInitialized = false,
  });

  LoggerConfig copyWith({
    Level? globalLevel,
    Map<LoggerType, Level>? loggerLevels,
    bool? isInitialized,
  }) {
    return LoggerConfig(
      globalLevel: globalLevel ?? this.globalLevel,
      loggerLevels: loggerLevels ?? this.loggerLevels,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

/// Extension untuk memudahkan penggunaan logger melalui ref
extension LoggerRefExtension on WidgetRef {
  /// Mendapatkan network logger
  Logger get networkLogger => read(networkLoggerProvider);

  /// Mendapatkan auth logger
  Logger get authLogger => read(authLoggerProvider);

  /// Mendapatkan database logger
  Logger get databaseLogger => read(databaseLoggerProvider);

  /// Mendapatkan UI logger
  Logger get uiLogger => read(uiLoggerProvider);

  /// Mendapatkan business logger
  Logger get businessLogger => read(businessLoggerProvider);

  /// Mendapatkan general logger
  Logger get generalLogger => read(generalLoggerProvider);

  /// Mendapatkan logger berdasarkan tipe
  Logger getLogger(LoggerType type) => read(loggerProvider(type));
}

/// Extension untuk memudahkan penggunaan logger melalui ref di provider
extension LoggerProviderRefExtension on Ref {
  /// Mendapatkan network logger
  Logger get networkLogger => read(networkLoggerProvider);

  /// Mendapatkan auth logger
  Logger get authLogger => read(authLoggerProvider);

  /// Mendapatkan database logger
  Logger get databaseLogger => read(databaseLoggerProvider);

  /// Mendapatkan UI logger
  Logger get uiLogger => read(uiLoggerProvider);

  /// Mendapatkan business logger
  Logger get businessLogger => read(businessLoggerProvider);

  /// Mendapatkan general logger
  Logger get generalLogger => read(generalLoggerProvider);

  /// Mendapatkan logger berdasarkan tipe
  Logger getLogger(LoggerType type) => read(loggerProvider(type));
}
