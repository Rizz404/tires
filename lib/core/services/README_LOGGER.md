# App Logger

Sistem logging yang komprehensif untuk aplikasi Flutter dengan konfigurasi berbeda untuk setiap usecase.

## Features

- 🎨 **Design berbeda untuk setiap usecase** - Network, Auth, Database, UI, Business Logic, dan General
- 🔧 **Konfigurasi yang mudah** - Static methods dan Riverpod providers
- 📱 **Flutter-friendly** - Terintegrasi dengan Riverpod state management
- 🎯 **Context logging** - Dukungan untuk logging dengan metadata tambahan
- 🌈 **Visual distinguishable** - Emoji dan warna berbeda untuk setiap logger
- ⚡ **Performance optimized** - Level logging yang dapat dikonfigurasi

## Logger Types

### 1. Network Logger (🌐)
Untuk logging request/response API dan operasi network.
- Emoji: 🔍 🌐 📡 ⚠️ ❌ 💥
- Level default: Debug
- Method count: 2

### 2. Auth Logger (🔐)
Untuk logging authentication dan authorization.
- Emoji: 🔐 🔑 👤 🚨 🛡️ ⛔
- Level default: Info
- Method count: 1

### 3. Database Logger (💾)
Untuk logging operasi database.
- Emoji: 🗃️ 💾 📊 ⚠️ 🔥 💀
- Level default: Debug
- Method count: 1

### 4. UI Logger (📱)
Untuk logging events UI dan navigation.
- Emoji: 👁️ 🎨 📱 ⚡ 💢 🚫
- Level default: Info
- Method count: 0 (no stack trace untuk UI events)

### 5. Business Logger (💼)
Untuk logging business logic dan use cases.
- Emoji: 🔍 ⚙️ 💼 ⚠️ ❗ 🆘
- Level default: Debug
- Method count: 3

### 6. General Logger
Untuk keperluan umum dan default logging.
- Level default: Debug
- Method count: 2

## Cara Penggunaan

### 1. Static Methods (Recommended untuk simplicitas)

```dart
import 'package:tires/core/services/app_logger.dart';

// Network logging
AppLogger.networkInfo('API request started');
AppLogger.networkError('API failed', error, stackTrace);

// Auth logging
AppLogger.authInfo('User login attempt');
AppLogger.authError('Login failed', error, stackTrace);

// Database logging
AppLogger.databaseDebug('Executing query: SELECT * FROM users');
AppLogger.databaseError('Query failed', error, stackTrace);

// UI logging
AppLogger.uiInfo('User navigated to home screen');
AppLogger.uiDebug('Button pressed');

// Business logging
AppLogger.businessInfo('Processing user order');
AppLogger.businessError('Order processing failed', error, stackTrace);

// General logging
AppLogger.info('General information');
AppLogger.error('General error', error, stackTrace);
```

### 2. Riverpod Providers (Recommended untuk dependency injection)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/logger_provider.dart';

// Dalam ConsumerWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkLogger = ref.networkLogger;
    final authLogger = ref.authLogger;

    // Atau menggunakan extension method
    final uiLogger = ref.getLogger(LoggerType.ui);

    return ElevatedButton(
      onPressed: () {
        uiLogger.i('Button pressed');
        networkLogger.i('Making API call...');
      },
      child: Text('Test'),
    );
  }
}

// Dalam Provider
final myServiceProvider = Provider<MyService>((ref) {
  return MyService(ref);
});

class MyService {
  final Ref _ref;

  MyService(this._ref);

  Future<void> doSomething() async {
    final logger = _ref.businessLogger;

    logger.i('Starting business operation...');

    try {
      // Business logic here
      logger.i('Operation completed');
    } catch (error, stackTrace) {
      logger.e('Operation failed', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
```

### 3. Context Logging (Untuk metadata tambahan)

```dart
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
```

### 4. Logger Configuration

```dart
// Mengatur level untuk semua logger
AppLogger.reinitializeWithLevel(Level.warning);

// Mengatur level untuk logger tertentu
AppLogger.reinitializeLoggerWithLevel(LoggerType.network, Level.error);

// Melalui provider (dengan state management)
final loggerConfig = ref.read(loggerConfigProvider.notifier);
loggerConfig.setGlobalLevel(Level.warning);
loggerConfig.setLoggerLevel(LoggerType.network, Level.error);
```

## Log Levels

- **Trace**: Informasi sangat detail untuk debugging
- **Debug**: Informasi debugging untuk development
- **Info**: Informasi umum tentang aplikasi
- **Warning**: Peringatan yang tidak critical
- **Error**: Error yang perlu perhatian
- **Fatal**: Error critical yang bisa menyebabkan crash

## Best Practices

### 1. Pilih Logger Type yang Tepat
```dart
// ✅ Benar - Gunakan network logger untuk API calls
AppLogger.networkInfo('GET /api/users');

// ❌ Salah - Jangan gunakan general logger untuk network
AppLogger.info('GET /api/users');
```

### 2. Include Context yang Relevan
```dart
// ✅ Benar - Include context yang berguna
AppLogger.networkError('API call failed', {
  'endpoint': '/api/users',
  'statusCode': 500,
  'userId': currentUserId,
}, error, stackTrace);

// ❌ Salah - Context tidak jelas
AppLogger.networkError('Failed', error, stackTrace);
```

### 3. Gunakan Level yang Appropriate
```dart
// ✅ Benar - Info untuk flow normal
AppLogger.authInfo('User logged in successfully');

// ✅ Benar - Debug untuk detail development
AppLogger.authDebug('Validating JWT token...');

// ✅ Benar - Error untuk exceptions
AppLogger.authError('Invalid credentials', error, stackTrace);
```

### 4. Jangan Log Sensitive Information
```dart
// ❌ Salah - Jangan log password atau token
AppLogger.authDebug('Password: $password');

// ✅ Benar - Log tanpa sensitive data
AppLogger.authDebug('Authentication attempt for user: $username');
```

## Integration dengan Existing Code

Logger ini sudah terintegrasi dengan:
- Riverpod state management
- Dependency injection system
- Error handling di core layer

Untuk menggunakan di usecase atau repository, cukup inject melalui provider:

```dart
final myUseCaseProvider = Provider<MyUseCase>((ref) {
  return MyUseCase(
    repository: ref.read(myRepositoryProvider),
    logger: ref.businessLogger, // atau ref.getLogger(LoggerType.business)
  );
});
```

## File Structure

```
lib/core/services/
├── app_logger.dart              # Main logger class
├── logger_provider.dart         # Riverpod providers dan extensions
└── logger_usage_examples.dart   # Contoh penggunaan
```

## Dependencies

- `logger: ^2.6.1` - Package logger utama
- `flutter_riverpod: ^2.6.1` - State management dan DI
