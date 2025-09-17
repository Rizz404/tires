import 'package:logger/logger.dart';

/// Enum untuk mendefinisikan jenis-jenis logger
enum LoggerType {
  /// Logger untuk network requests
  network,

  /// Logger untuk authentication
  auth,

  /// Logger untuk database operations
  database,

  /// Logger untuk UI events
  ui,

  /// Logger untuk business logic/use cases
  business,

  /// Logger untuk general/default logging
  general,
}

/// Service untuk logging yang dapat digunakan di seluruh aplikasi
/// dengan konfigurasi berbeda untuk setiap usecase
class AppLogger {
  static final Map<LoggerType, Logger> _loggers = {};

  /// Inisialisasi logger dengan konfigurasi default
  static void initialize() {
    // Network Logger - untuk request/response API
    _loggers[LoggerType.network] = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
        levelEmojis: {
          Level.trace: '🔍',
          Level.debug: '🌐',
          Level.info: '📡',
          Level.warning: '⚠️',
          Level.error: '❌',
          Level.fatal: '💥',
        },
      ),
      output: ConsoleOutput(),
      level: Level.debug,
    );

    // Auth Logger - untuk authentication & authorization
    _loggers[LoggerType.auth] = Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 5,
        lineLength: 100,
        colors: true,
        printEmojis: true,
        printTime: true,
        levelEmojis: {
          Level.trace: '🔐',
          Level.debug: '🔑',
          Level.info: '👤',
          Level.warning: '🚨',
          Level.error: '🛡️',
          Level.fatal: '⛔',
        },
      ),
      output: ConsoleOutput(),
      level: Level.info,
    );

    // Database Logger - untuk operasi database
    _loggers[LoggerType.database] = Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 6,
        lineLength: 80,
        colors: true,
        printEmojis: true,
        printTime: true,
        levelEmojis: {
          Level.trace: '🗃️',
          Level.debug: '💾',
          Level.info: '📊',
          Level.warning: '⚠️',
          Level.error: '🔥',
          Level.fatal: '💀',
        },
      ),
      output: ConsoleOutput(),
      level: Level.debug,
    );

    // UI Logger - untuk events UI dan navigation
    _loggers[LoggerType.ui] = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 3,
        lineLength: 60,
        colors: true,
        printEmojis: true,
        printTime: false,
        levelEmojis: {
          Level.trace: '👁️',
          Level.debug: '🎨',
          Level.info: '📱',
          Level.warning: '⚡',
          Level.error: '💢',
          Level.fatal: '🚫',
        },
      ),
      output: ConsoleOutput(),
      level: Level.info,
    );

    // Business Logger - untuk business logic dan use cases
    _loggers[LoggerType.business] = Logger(
      printer: PrettyPrinter(
        methodCount: 3,
        errorMethodCount: 8,
        lineLength: 100,
        colors: true,
        printEmojis: true,
        printTime: true,
        levelEmojis: {
          Level.trace: '🔍',
          Level.debug: '⚙️',
          Level.info: '💼',
          Level.warning: '⚠️',
          Level.error: '❗',
          Level.fatal: '🆘',
        },
      ),
      output: ConsoleOutput(),
      level: Level.debug,
    );

    // General Logger - untuk keperluan umum
    _loggers[LoggerType.general] = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 5,
        lineLength: 80,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      output: ConsoleOutput(),
      level: Level.debug,
    );
  }

  /// Mendapatkan logger berdasarkan tipe
  static Logger getLogger(LoggerType type) {
    if (_loggers.isEmpty) {
      initialize();
    }
    return _loggers[type] ?? _loggers[LoggerType.general]!;
  }

  /// Network Logger methods
  static void networkTrace(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.network,
    ).t(message, error: error, stackTrace: stackTrace);
  }

  static void networkDebug(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.network,
    ).d(message, error: error, stackTrace: stackTrace);
  }

  static void networkInfo(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.network,
    ).i(message, error: error, stackTrace: stackTrace);
  }

  static void networkWarning(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.network,
    ).w(message, error: error, stackTrace: stackTrace);
  }

  static void networkError(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.network,
    ).e(message, error: error, stackTrace: stackTrace);
  }

  static void networkFatal(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.network,
    ).f(message, error: error, stackTrace: stackTrace);
  }

  /// Auth Logger methods
  static void authTrace(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(LoggerType.auth).t(message, error: error, stackTrace: stackTrace);
  }

  static void authDebug(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(LoggerType.auth).d(message, error: error, stackTrace: stackTrace);
  }

  static void authInfo(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(LoggerType.auth).i(message, error: error, stackTrace: stackTrace);
  }

  static void authWarning(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(LoggerType.auth).w(message, error: error, stackTrace: stackTrace);
  }

  static void authError(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(LoggerType.auth).e(message, error: error, stackTrace: stackTrace);
  }

  static void authFatal(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(LoggerType.auth).f(message, error: error, stackTrace: stackTrace);
  }

  /// Database Logger methods
  static void databaseTrace(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.database,
    ).t(message, error: error, stackTrace: stackTrace);
  }

  static void databaseDebug(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.database,
    ).d(message, error: error, stackTrace: stackTrace);
  }

  static void databaseInfo(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.database,
    ).i(message, error: error, stackTrace: stackTrace);
  }

  static void databaseWarning(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.database,
    ).w(message, error: error, stackTrace: stackTrace);
  }

  static void databaseError(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.database,
    ).e(message, error: error, stackTrace: stackTrace);
  }

  static void databaseFatal(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.database,
    ).f(message, error: error, stackTrace: stackTrace);
  }

  /// UI Logger methods
  static void uiTrace(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(LoggerType.ui).t(message, error: error, stackTrace: stackTrace);
  }

  static void uiDebug(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(LoggerType.ui).d(message, error: error, stackTrace: stackTrace);
  }

  static void uiInfo(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(LoggerType.ui).i(message, error: error, stackTrace: stackTrace);
  }

  static void uiWarning(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(LoggerType.ui).w(message, error: error, stackTrace: stackTrace);
  }

  static void uiError(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(LoggerType.ui).e(message, error: error, stackTrace: stackTrace);
  }

  static void uiFatal(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(LoggerType.ui).f(message, error: error, stackTrace: stackTrace);
  }

  /// Business Logger methods
  static void businessTrace(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.business,
    ).t(message, error: error, stackTrace: stackTrace);
  }

  static void businessDebug(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.business,
    ).d(message, error: error, stackTrace: stackTrace);
  }

  static void businessInfo(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.business,
    ).i(message, error: error, stackTrace: stackTrace);
  }

  static void businessWarning(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.business,
    ).w(message, error: error, stackTrace: stackTrace);
  }

  static void businessError(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.business,
    ).e(message, error: error, stackTrace: stackTrace);
  }

  static void businessFatal(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    getLogger(
      LoggerType.business,
    ).f(message, error: error, stackTrace: stackTrace);
  }

  /// General Logger methods
  static void trace(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(
      LoggerType.general,
    ).t(message, error: error, stackTrace: stackTrace);
  }

  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(
      LoggerType.general,
    ).d(message, error: error, stackTrace: stackTrace);
  }

  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(
      LoggerType.general,
    ).i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(
      LoggerType.general,
    ).w(message, error: error, stackTrace: stackTrace);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(
      LoggerType.general,
    ).e(message, error: error, stackTrace: stackTrace);
  }

  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    getLogger(
      LoggerType.general,
    ).f(message, error: error, stackTrace: stackTrace);
  }

  /// Utility method untuk logging dengan context tambahan
  static void logWithContext({
    required LoggerType type,
    required Level level,
    required String message,
    Map<String, dynamic>? context,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final logger = getLogger(type);
    String formattedMessage = message;

    if (context != null && context.isNotEmpty) {
      final contextString = context.entries
          .map((e) => '${e.key}: ${e.value}')
          .join(', ');
      formattedMessage = '$message | Context: {$contextString}';
    }

    switch (level) {
      case Level.trace:
        logger.t(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.debug:
        logger.d(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.info:
        logger.i(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.warning:
        logger.w(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.error:
        logger.e(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.fatal:
        logger.f(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      default:
        logger.i(formattedMessage, error: error, stackTrace: stackTrace);
    }
  }

  /// Method untuk mengatur level logging untuk semua logger
  /// Note: Level harus diatur saat inisialisasi logger
  static void reinitializeWithLevel(Level level) {
    _loggers.clear();
    _initializeLoggersWithLevel(level);
  }

  /// Method untuk reinisialisasi logger tertentu dengan level baru
  static void reinitializeLoggerWithLevel(LoggerType type, Level level) {
    _loggers.remove(type);
    _initializeSpecificLogger(type, level);
  }

  /// Helper method untuk inisialisasi semua logger dengan level tertentu
  static void _initializeLoggersWithLevel(Level level) {
    for (final loggerType in LoggerType.values) {
      _initializeSpecificLogger(loggerType, level);
    }
  }

  /// Helper method untuk inisialisasi logger spesifik dengan level tertentu
  static void _initializeSpecificLogger(LoggerType type, Level level) {
    switch (type) {
      case LoggerType.network:
        _loggers[LoggerType.network] = Logger(
          printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
            printTime: true,
            levelEmojis: {
              Level.trace: '🔍',
              Level.debug: '🌐',
              Level.info: '📡',
              Level.warning: '⚠️',
              Level.error: '❌',
              Level.fatal: '💥',
            },
          ),
          output: ConsoleOutput(),
          level: level,
        );
        break;
      case LoggerType.auth:
        _loggers[LoggerType.auth] = Logger(
          printer: PrettyPrinter(
            methodCount: 1,
            errorMethodCount: 5,
            lineLength: 100,
            colors: true,
            printEmojis: true,
            printTime: true,
            levelEmojis: {
              Level.trace: '🔐',
              Level.debug: '🔑',
              Level.info: '👤',
              Level.warning: '🚨',
              Level.error: '🛡️',
              Level.fatal: '⛔',
            },
          ),
          output: ConsoleOutput(),
          level: level,
        );
        break;
      case LoggerType.database:
        _loggers[LoggerType.database] = Logger(
          printer: PrettyPrinter(
            methodCount: 1,
            errorMethodCount: 6,
            lineLength: 80,
            colors: true,
            printEmojis: true,
            printTime: true,
            levelEmojis: {
              Level.trace: '🗃️',
              Level.debug: '💾',
              Level.info: '📊',
              Level.warning: '⚠️',
              Level.error: '🔥',
              Level.fatal: '💀',
            },
          ),
          output: ConsoleOutput(),
          level: level,
        );
        break;
      case LoggerType.ui:
        _loggers[LoggerType.ui] = Logger(
          printer: PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 3,
            lineLength: 60,
            colors: true,
            printEmojis: true,
            printTime: false,
            levelEmojis: {
              Level.trace: '👁️',
              Level.debug: '🎨',
              Level.info: '📱',
              Level.warning: '⚡',
              Level.error: '💢',
              Level.fatal: '🚫',
            },
          ),
          output: ConsoleOutput(),
          level: level,
        );
        break;
      case LoggerType.business:
        _loggers[LoggerType.business] = Logger(
          printer: PrettyPrinter(
            methodCount: 3,
            errorMethodCount: 8,
            lineLength: 100,
            colors: true,
            printEmojis: true,
            printTime: true,
            levelEmojis: {
              Level.trace: '🔍',
              Level.debug: '⚙️',
              Level.info: '💼',
              Level.warning: '⚠️',
              Level.error: '❗',
              Level.fatal: '🆘',
            },
          ),
          output: ConsoleOutput(),
          level: level,
        );
        break;
      case LoggerType.general:
        _loggers[LoggerType.general] = Logger(
          printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 5,
            lineLength: 80,
            colors: true,
            printEmojis: true,
            printTime: true,
          ),
          output: ConsoleOutput(),
          level: level,
        );
        break;
    }
  }

  /// Method untuk menutup semua logger (cleanup)
  static void dispose() {
    for (final logger in _loggers.values) {
      logger.close();
    }
    _loggers.clear();
  }
}
