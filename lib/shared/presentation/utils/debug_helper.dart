import 'dart:developer' as developer;

/// A comprehensive debugging utility for tracking null values and type casting issues
class DebugHelper {
  static const String _tag = 'DebugHelper';

  /// Logs detailed information about a Map to help identify null values
  static void logMapDetails(Map<String, dynamic> map, {String? title}) {
    developer.log('📋 ${title ?? 'Map Details'}', name: _tag);
    developer.log(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      name: _tag,
    );

    for (final entry in map.entries) {
      final key = entry.key;
      final value = entry.value;
      final type = value.runtimeType;
      final isNull = value == null;

      String statusIcon = isNull ? '❌' : '✅';
      String valueStr = isNull ? 'NULL' : value.toString();

      // Limit long strings for readability
      if (valueStr.length > 100) {
        valueStr = '${valueStr.substring(0, 100)}...';
      }

      developer.log('$statusIcon $key: ($type) $valueStr', name: _tag);
    }
    developer.log(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      name: _tag,
    );
  }

  /// Safely casts a value with detailed logging
  static T? safeCast<T>(dynamic value, String fieldName, {T? defaultValue}) {
    try {
      if (value == null) {
        developer.log(
          '⚠️ NULL value for $fieldName, using default: $defaultValue',
          name: _tag,
        );
        return defaultValue;
      }

      if (value is T) {
        developer.log(
          '✅ Successfully cast $fieldName: ${value.runtimeType} -> $T',
          name: _tag,
        );
        return value;
      }

      // Try to convert common types
      if (T == String && value != null) {
        final result = value.toString() as T;
        developer.log(
          '🔄 Converted $fieldName to String: ${value.runtimeType} -> String',
          name: _tag,
        );
        return result;
      }

      if (T == int && value != null) {
        if (value is num) {
          final result = value.toInt() as T;
          developer.log(
            '🔄 Converted $fieldName to int: ${value.runtimeType} -> int',
            name: _tag,
          );
          return result;
        }
        if (value is String) {
          final parsed = int.tryParse(value);
          if (parsed != null) {
            final result = parsed as T;
            developer.log(
              '🔄 Parsed $fieldName to int: String -> int',
              name: _tag,
            );
            return result;
          }
        }
      }

      if (T == double && value != null) {
        if (value is num) {
          final result = value.toDouble() as T;
          developer.log(
            '🔄 Converted $fieldName to double: ${value.runtimeType} -> double',
            name: _tag,
          );
          return result;
        }
        if (value is String) {
          final parsed = double.tryParse(value);
          if (parsed != null) {
            final result = parsed as T;
            developer.log(
              '🔄 Parsed $fieldName to double: String -> double',
              name: _tag,
            );
            return result;
          }
        }
      }

      developer.log(
        '❌ Cannot cast $fieldName: ${value.runtimeType} to $T, using default: $defaultValue',
        name: _tag,
      );
      return defaultValue;
    } catch (e, stackTrace) {
      developer.log('💥 Exception casting $fieldName: $e', name: _tag);
      developer.log('Stack trace: $stackTrace', name: _tag);
      return defaultValue;
    }
  }

  /// Safely extracts a nested map from another map
  static Map<String, dynamic> safeExtractMap(
    Map<String, dynamic> source,
    String key, {
    Map<String, dynamic>? defaultValue,
  }) {
    try {
      final value = source[key];
      if (value == null) {
        developer.log('⚠️ NULL nested map for $key, using default', name: _tag);
        return defaultValue ?? {};
      }

      if (value is Map<String, dynamic>) {
        developer.log('✅ Successfully extracted map for $key', name: _tag);
        return value;
      }

      if (value is Map) {
        final converted = Map<String, dynamic>.from(value);
        developer.log(
          '🔄 Converted Map to Map<String, dynamic> for $key',
          name: _tag,
        );
        return converted;
      }

      developer.log(
        '❌ Value for $key is not a Map: ${value.runtimeType}, using default',
        name: _tag,
      );
      return defaultValue ?? {};
    } catch (e, stackTrace) {
      developer.log('💥 Exception extracting map for $key: $e', name: _tag);
      developer.log('Stack trace: $stackTrace', name: _tag);
      return defaultValue ?? {};
    }
  }

  /// Safely parses a DateTime string
  static DateTime? safeParseDateTime(dynamic value, String fieldName) {
    try {
      if (value == null) {
        developer.log('⚠️ NULL datetime for $fieldName', name: _tag);
        return null;
      }

      if (value is DateTime) {
        developer.log('✅ Value is already DateTime for $fieldName', name: _tag);
        return value;
      }

      if (value is String) {
        final parsed = DateTime.parse(value);
        developer.log(
          '✅ Successfully parsed DateTime for $fieldName',
          name: _tag,
        );
        return parsed;
      }

      developer.log(
        '❌ Cannot parse DateTime for $fieldName: ${value.runtimeType}',
        name: _tag,
      );
      return null;
    } catch (e, stackTrace) {
      developer.log(
        '💥 Exception parsing DateTime for $fieldName: $e',
        name: _tag,
      );
      developer.log('Stack trace: $stackTrace', name: _tag);
      return null;
    }
  }

  /// Logs API response for debugging
  static void logApiResponse(
    Map<String, dynamic> response, {
    String? endpoint,
  }) {
    developer.log('🌐 API Response ${endpoint ?? ''}', name: _tag);
    developer.log(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      name: _tag,
    );

    // Log top-level structure
    logMapDetails(response, title: 'Response Structure');

    // If there's a data array, log the first item's structure
    if (response['data'] is List && (response['data'] as List).isNotEmpty) {
      final firstItem = (response['data'] as List).first;
      if (firstItem is Map<String, dynamic>) {
        logMapDetails(firstItem, title: 'First Data Item Structure');
      }
    }

    developer.log(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      name: _tag,
    );
  }

  /// Traces model creation process
  static void traceModelCreation(String modelName, Map<String, dynamic> data) {
    developer.log('🏗️ Creating $modelName', name: _tag);
    logMapDetails(data, title: '$modelName Source Data');
  }
}
