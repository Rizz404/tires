import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Price Parsing Tests', () {
    test('should parse formatted Japanese price correctly', () {
      // Test cases for parsing Japanese formatted prices
      final testCases = {
        '5000': 5000,
        '5,000': 5000,
        '10,000': 10000,
        '100,000': 100000,
        '1,000,000': 1000000,
        '¥5,000': 5000,
        '¥100,000': 100000,
      };

      for (final entry in testCases.entries) {
        final input = entry.key;
        final expected = entry.value;

        // Clean price value by removing commas and currency symbols before parsing
        final cleanValue = input.replaceAll(RegExp(r'[,¥$\s]'), '');
        final result = int.parse(cleanValue);

        expect(result, equals(expected), reason: 'Failed to parse: $input');
      }
    });

    test('should validate price format correctly', () {
      // Test custom price validator logic
      String? validatePrice(String? value) {
        if (value == null || value.isEmpty) return 'Price is required';

        // Remove commas and other formatting for validation
        final cleanValue = value.replaceAll(RegExp(r'[,¥$\s]'), '');
        final parsedValue = int.tryParse(cleanValue);

        if (parsedValue == null) {
          return 'Price must be a valid number';
        }

        if (parsedValue < 0) {
          return 'Price must be at least 0';
        }

        if (parsedValue > 999999) {
          return 'Price must be less than 999,999';
        }

        return null;
      }

      // Test valid cases
      expect(validatePrice('5000'), isNull);
      expect(validatePrice('5,000'), isNull);
      expect(validatePrice('¥5,000'), isNull);
      expect(validatePrice('999999'), isNull);
      expect(validatePrice('0'), isNull);

      // Test invalid cases
      expect(validatePrice(''), equals('Price is required'));
      expect(validatePrice('-100'), equals('Price must be at least 0'));
      expect(
        validatePrice('1000000'),
        equals('Price must be less than 999,999'),
      );
      expect(validatePrice('abc'), equals('Price must be a valid number'));
      expect(
        validatePrice('5,000,000'),
        equals('Price must be less than 999,999'),
      );
    });

    test('should parse required time correctly', () {
      String? validateRequiredTime(String? value) {
        if (value == null || value.isEmpty) return 'Required time is required';

        final parsedValue = int.tryParse(value);

        if (parsedValue == null) {
          return 'Required time must be a valid number';
        }

        if (parsedValue < 1) {
          return 'Required time must be at least 1 minute';
        }

        if (parsedValue > 1440) {
          // 24 hours in minutes
          return 'Required time must be less than 24 hours';
        }

        return null;
      }

      // Test valid cases
      expect(validateRequiredTime('60'), isNull);
      expect(validateRequiredTime('1'), isNull);
      expect(validateRequiredTime('1440'), isNull);

      // Test invalid cases
      expect(validateRequiredTime(''), equals('Required time is required'));
      expect(
        validateRequiredTime('0'),
        equals('Required time must be at least 1 minute'),
      );
      expect(
        validateRequiredTime('1441'),
        equals('Required time must be less than 24 hours'),
      );
      expect(
        validateRequiredTime('abc'),
        equals('Required time must be a valid number'),
      );
    });
  });
}
