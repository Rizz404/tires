import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/services/logger_provider.dart';

/// Contoh penggunaan AppLogger dalam berbagai scenario
class LoggerUsageExamples {
  /// Contoh penggunaan untuk network/API calls
  static void networkExample() {
    // Cara 1: Menggunakan static methods dari AppLogger
    AppLogger.networkInfo('Starting API request to /users');
    AppLogger.networkDebug('Request headers: {Authorization: Bearer token}');

    try {
      // Simulate API call
      AppLogger.networkInfo('API request successful');
    } catch (error, stackTrace) {
      AppLogger.networkError('API request failed', error, stackTrace);
    }
  }

  /// Contoh penggunaan untuk authentication
  static void authExample() {
    AppLogger.authInfo('User login attempt');
    AppLogger.authDebug('Validating credentials...');

    try {
      // Simulate auth logic
      AppLogger.authInfo('User authenticated successfully');
    } catch (error, stackTrace) {
      AppLogger.authError('Authentication failed', error, stackTrace);
    }
  }

  /// Contoh penggunaan untuk database operations
  static void databaseExample() {
    AppLogger.databaseInfo('Executing database query');
    AppLogger.databaseDebug('Query: SELECT * FROM users WHERE id = ?');

    try {
      // Simulate database operation
      AppLogger.databaseInfo('Query executed successfully');
    } catch (error, stackTrace) {
      AppLogger.databaseError('Database query failed', error, stackTrace);
    }
  }

  /// Contoh penggunaan untuk UI events
  static void uiExample() {
    AppLogger.uiInfo('User tapped login button');
    AppLogger.uiDebug('Navigating to home screen');
    AppLogger.uiInfo('Screen transition completed');
  }

  /// Contoh penggunaan untuk business logic
  static void businessExample() {
    AppLogger.businessInfo('Processing user order');
    AppLogger.businessDebug('Calculating total price with discounts');

    try {
      // Simulate business logic
      AppLogger.businessInfo('Order processed successfully');
    } catch (error, stackTrace) {
      AppLogger.businessError('Order processing failed', error, stackTrace);
    }
  }

  /// Contoh penggunaan dengan context tambahan
  static void contextExample() {
    AppLogger.logWithContext(
      type: LoggerType.business,
      level: Level.info,
      message: 'User action performed',
      context: {
        'userId': '12345',
        'action': 'purchase',
        'amount': 99.99,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}

/// Widget contoh penggunaan logger dengan Riverpod
class LoggerExampleWidget extends ConsumerWidget {
  const LoggerExampleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Cara menggunakan logger melalui provider
    final networkLogger = ref.networkLogger;
    final authLogger = ref.authLogger;

    // Atau menggunakan extension method
    final uiLogger = ref.getLogger(LoggerType.ui);

    return Scaffold(
      appBar: AppBar(title: const Text('Logger Example')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              uiLogger.i('Network test button pressed');
              networkLogger.i('Simulating network request...');

              // Simulate async operation
              Future.delayed(const Duration(seconds: 1), () {
                networkLogger.i('Network request completed');
              });
            },
            child: const Text('Test Network Logger'),
          ),
          ElevatedButton(
            onPressed: () {
              uiLogger.i('Auth test button pressed');
              authLogger.i('Testing authentication...');

              try {
                // Simulate auth process
                authLogger.i('Authentication successful');
              } catch (error, stackTrace) {
                authLogger.e(
                  'Auth failed',
                  error: error,
                  stackTrace: stackTrace,
                );
              }
            },
            child: const Text('Test Auth Logger'),
          ),
          ElevatedButton(
            onPressed: () {
              // Menggunakan static methods langsung
              AppLogger.businessInfo('Business logic test started');
              AppLogger.databaseDebug('Querying user data...');
              AppLogger.uiInfo('UI updated with new data');
            },
            child: const Text('Test All Loggers'),
          ),
          ElevatedButton(
            onPressed: () {
              // Test logger dengan context
              AppLogger.logWithContext(
                type: LoggerType.ui,
                level: Level.info,
                message: 'Button interaction',
                context: {
                  'buttonType': 'test',
                  'screenName': 'LoggerExample',
                  'timestamp': DateTime.now().millisecondsSinceEpoch,
                },
              );
            },
            child: const Text('Test Context Logger'),
          ),
        ],
      ),
    );
  }
}

/// Provider contoh yang menggunakan logger
final exampleServiceProvider = Provider<ExampleService>((ref) {
  return ExampleService(ref);
});

class ExampleService {
  final Ref _ref;

  ExampleService(this._ref);

  Future<String> fetchData() async {
    final logger = _ref.networkLogger;

    logger.i('Starting data fetch...');

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      logger.i('Data fetched successfully');
      return 'Sample data';
    } catch (error, stackTrace) {
      logger.e('Failed to fetch data', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  void processBusinessLogic(Map<String, dynamic> data) {
    final logger = _ref.businessLogger;

    logger.i('Processing business logic...');
    logger.d('Input data: $data');

    try {
      // Simulate processing
      logger.i('Business logic processed successfully');
    } catch (error, stackTrace) {
      logger.e('Business logic failed', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
