# Shared Widgets

This directory contains reusable widgets used throughout the application.

## AppSearchableDropdown

A highly customizable dropdown widget with search functionality and infinite scroll support.

### Features

- **Search functionality**: Real-time search with debouncing
- **Infinite scroll**: Load more items as user scrolls
- **Customizable appearance**: Theme-aware with Material Design 3
- **Form integration**: Works with FormBuilder
- **Accessibility**: Proper screen reader support
- **Logging**: Integrated with AppLogger for debugging

### Usage

```dart
AppSearchableDropdown<String>(
  name: 'country',
  label: 'Select Country',
  hintText: 'Choose a country',
  searchHintText: 'Search countries...',
  items: countries,
  onSearch: (query) async {
    // Implement search logic
    return await searchCountries(query);
  },
  onLoadMore: () async {
    // Implement infinite scroll logic
    return await loadMoreCountries();
  },
  enableInfiniteScroll: true,
  onChanged: (value) {
    // Handle selection
  },
)
```

### Parameters

- `name`: Form field name (required)
- `items`: Initial list of items (required)
- `onSearch`: Async function for search functionality
- `onLoadMore`: Async function for infinite scroll
- `enableInfiniteScroll`: Enable infinite scroll (default: false)
- `debounceTime`: Search debounce time in milliseconds (default: 300)
- `maxHeight`: Maximum height of dropdown (default: 300)
- `emptySearchResult`: Custom widget for empty search results
- `loadingIndicator`: Custom widget for loading state

### AppSearchableDropdownItem

Represents an item in the dropdown:

```dart
AppSearchableDropdownItem<String>(
  value: 'us',
  label: 'United States',
  searchKey: 'usa america', // Optional additional search terms
  icon: Icon(Icons.flag), // Optional icon
)
```

## Other Widgets

### AppButton
Custom button with multiple variants (filled, outlined, text) and sizes.

### AppTextField
Themed text field with validation support.

### AppSearchField
Search field with clear button functionality.

### AppDropdown
Standard dropdown without search functionality.

### AppText
Themed text widget with predefined styles.

## Theme Integration

All widgets use the project's theme extensions:

```dart
import 'package:tires/core/extensions/theme_extension.dart';
import 'package:tires/core/extensions/localization_extension.dart';

// Access theme
context.colorScheme.primary
context.textTheme.bodyMedium

// Access localization
context.l10n.ok
context.isEnglish
```

## Logging

All widgets use AppLogger for consistent logging:

```dart
import 'package:tires/core/services/app_logger.dart';

AppLogger.uiInfo('User interaction');
AppLogger.networkError('API call failed', error, stackTrace);
