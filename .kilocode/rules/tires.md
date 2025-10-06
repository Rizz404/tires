# Sigma Track - Flutter Development Rules

## Extensions (Mandatory)
Always import and use project extensions for theme and localization:
```dart
import 'package:sigma_track/core/extensions/theme_extension.dart';
import 'package:sigma_track/core/extensions/localization_extension.dart';
```

Access theme via: `context.theme`, `context.textTheme`, `context.colorScheme`, `context.isDarkMode`, etc

Access localization via: `context.l10n`, `context.locale`, `context.isEnglish`, `context.isIndonesian`, `context.isJapanese`

## Theming Standards
NEVER use hardcoded colors or styles. Always use theme-aware values:

✅ **DO:**
- `context.colorScheme.primary`
- `context.colors.surface`
- `context.textTheme.bodyMedium`

❌ **DON'T:**
- `Color(0xFF...)`
- `Colors.red`
- Any hardcoded color values

**Example:**
```dart
Container(
  color: context.colors.surface,
  child: Text(
    context.l10n.ok,
    style: context.textTheme.bodyMedium,
  ),
)
```

## Logging

Replace ALL `print()` and `debugPrint()` with the project's centralized `AppLogger` service. This ensures consistent, configurable, and context-aware logging across the application.

```dart
import 'package:sigma_track/core/services/app_logger.dart';
```

Use the specific static methods based on the context of the log. Each method is tied to a `LoggerType` with its own unique configuration (emojis, colors, etc.).

  - **Network Operations:** Use `AppLogger.network...` for API calls, responses, and status.

    ```dart
    AppLogger.networkInfo('Fetching user profile...');
    AppLogger.networkError('Failed to fetch data', error, stackTrace);
    ```

  - **Authentication:** Use `AppLogger.auth...` for login, logout, token management, and authorization.

    ```dart
    AppLogger.authInfo('User authenticated successfully: $userId');
    AppLogger.authWarning('User permission denied for admin area');
    ```

  - **Database Operations:** Use `AppLogger.database...` for local storage, cache, or any database interaction.

    ```dart
    AppLogger.databaseDebug('Saving settings to local storage');
    ```

  - **UI Events:** Use `AppLogger.ui...` for widget lifecycles, user interactions, and navigation events.

    ```dart
    AppLogger.uiInfo('Navigated to SettingsScreen');
    AppLogger.uiDebug('Submit button tapped');
    ```

  - **Business Logic:** Use `AppLogger.business...` for use cases, state changes, and core domain logic.

    ```dart
    AppLogger.businessDebug('Validating order form');
    AppLogger.businessInfo('Order placement process started');
    ```

  - **General Purpose:** Use the shorthand methods (`AppLogger.info`, `AppLogger.error`, etc.) for logs that don't fit a specific category.

    ```dart
    AppLogger.info('Service initialized');
    AppLogger.error('An unexpected error occurred', e, s);
    ```

**Example:**

```dart
class ExampleService {
  void processOrder() {
    AppLogger.businessInfo('Process started');
    try {
      // API call to the server
      AppLogger.networkDebug('Submitting order to API...');
      // logic
      AppLogger.businessDebug('Validation OK');
    } catch (e, s) {
      AppLogger.businessError('Process failed', e, s);
    }
  }
}
```

## Code Comments
Use Better Comments format for VS Code:
- `// TODO: task to be done`
- `// FIXME: bug that needs fixing`
- `// ! critical warning or breaking change`
- `// ? question or needs clarification`
- `// * important implementation note`

Keep inline comments to 1-2 lines maximum. Code should be self-explanatory.

## Const Usage
Always use `const` for compile-time constants:
- `const SizedBox(height: 16)`
- `const Duration(milliseconds: 300)`
- `const EdgeInsets.all(8)`
- Any static widget without dynamic variables

## Shared Widgets
ALWAYS use existing shared widgets from `lib/shared/widgets/` instead of creating new ones or using raw Material/Cupertino widgets:

**Available widgets:**
- **Buttons:** `AppButton` (primary/secondary/text variants)
- **Text inputs:** `AppTextField`, `AppSearchField`
- **Form controls:** `AppDropdown`, `AppCheckbox`, `AppRadioGroup`
- **Date/Time:** `AppDateTimePicker`, `AppTimePicker`
- **Text:** `AppText` (themed text widget)
- **Layout:** `AdminAppBar`, `UserAppBar`, `ScreenWrapper`
- **Navigation:** `AppEndDrawer`

✅ **DO:** Use `AppTextField` instead of raw `TextField`
❌ **DON'T:** Create new button widgets when `AppButton` exists

**Example:**
```dart
Column(
  children: [
    AppTextField(
      label: context.l10n.email,
      controller: emailController,
    ),
    AppButton(
      text: context.l10n.submit,
      onPressed: onSubmit,
    ),
  ],
)
```

## Documentation
- NO separate `.md` documentation files unless explicitly requested
- Keep explanations brief and in comments
- Code should be self-documenting
- Only add doc comments for complex public APIs

## Response Format
When providing code changes or suggestions:
- Be brief and to the point
- Only mention what changed, added, or removed
- No lengthy explanations unless requested
- Show minimal diffs, not entire files

## Terminal Commands
When suggesting terminal operations, ALWAYS use modern CLI tools:

**File Operations:**
- `eza -la` instead of `ls` or `dir`
- `fd "*.dart"` instead of `find`
- `rg "TODO"` instead of `grep` or `findstr`
- `bat file.dart` instead of `cat` or `type`
- `sd "old" "new"` instead of `sed`

**Navigation:**
- `cd` for navigation
- `fzf` for fuzzy finding (Ctrl+R, Ctrl+T)
- `yazi` for file manager TUI

**Development:**
- `glow README.md` for markdown preview
- `jq '.data'` for JSON parsing
- `tldr git` for command examples
- `micro` for quick text editing

**Monitoring:**
- `btm` for system monitoring
- `procs dart` for process filtering

**Example workflows:**
```bash
# Find TODOs in Dart files
fd -e dart | rg "TODO"

# Show project structure
eza --tree -L 3 lib/

# Jump to project directory
cd sigma

# Interactive git operations
lazygit
```

❌ **NEVER suggest:** `dir`, `findstr`, `find`, `grep`, `cat`, manual `cd` paths
