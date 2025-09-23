# Price Field Fix Documentation

## Problem
The menu upsert screen was encountering errors when trying to parse price values because the AppTextField with type `AppTextFieldType.priceJP` formats the input with commas (e.g., "5,000"), but the parsing logic was trying to use `int.parse()` directly on the formatted string, which doesn't handle commas.

## Solution

### 1. Updated MenuValidators.price()
- Added custom validation logic that removes formatting characters before validation
- Handles commas, currency symbols (¥, $), and spaces
- Provides better error messages

```dart
static FormFieldValidator<String> price(BuildContext context) {
  return FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Price is required'),
    (value) {
      if (value == null || value.isEmpty) return null;

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
    },
  ]);
}
```

### 2. Updated AdminUpsertMenuScreen._handleSubmit()
- Added helper method `_parseFormattedNumber()` to clean formatted numbers
- Updated price parsing to use the helper method
- Handles Japanese price format (¥5,000) correctly

```dart
/// Helper method to clean formatted numbers before parsing
int _parseFormattedNumber(String value) {
  final cleanValue = value.replaceAll(RegExp(r'[,¥$\s]'), '');
  return int.parse(cleanValue);
}

// In _handleSubmit():
final priceString = values['price'] as String;
final price = _parseFormattedNumber(priceString);
```

### 3. Updated AdminUpsertMenuScreen._populateForm()
- Fixed price population by converting to string for proper formatting
- Ensures existing menu prices are displayed correctly in edit mode

```dart
'price': menu.price.amount.toString(), // Convert to string for proper formatting
```

### 4. Updated MenuValidators.requiredTime()
- Applied similar validation pattern for consistency
- Better error handling for time inputs

## Supported Price Formats
The system now properly handles:
- `5000` → 5000
- `5,000` → 5000
- `¥5,000` → 5000
- `100,000` → 100000
- `1,000,000` → 1000000

## Testing
Added comprehensive unit tests in `test/unit/price_parsing_test.dart` to verify:
- Price parsing from various formatted inputs
- Validation logic for both valid and invalid cases
- Required time validation

## Benefits
1. **User Experience**: Users can input prices naturally with automatic formatting
2. **Data Integrity**: Proper parsing ensures correct values are saved
3. **Validation**: Better error messages guide users to correct input
4. **Consistency**: Same approach applied to all numeric fields
5. **Internationalization**: Supports both Japanese (¥) and US ($) currency formats
