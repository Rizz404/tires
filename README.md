<div align="center">

# Tires

Modern multi-module Flutter application with clean architecture, feature-based foldering, Riverpod state management, robust networking (Dio), internationalization, and automated routing (auto_route).

</div>

## Table of Contents
1. Overview
2. Architecture & Folder Structure
3. Tech Stack
4. Features (Implemented / In-Progress)
5. State Management Strategy
6. Networking Layer
7. Dependency Injection
8. Routing & Navigation
9. Localization (i18n)
10. Theming
11. Error & Exception Handling
12. Provider Invalidation Lifecycle
13. Development Workflow
14. Code Generation
15. Testing Guidelines
16. Environment & Configuration
17. Security Considerations
18. Common Commands
19. Roadmap / Possible Enhancements
20. License

---

## 1. Overview
Tires is a production-oriented Flutter app structured around feature modules (announcement, authentication, reservation, calendar, menu, user, etc.). It emphasizes:
* Separation of concerns (data / domain / presentation layers inside each feature)
* Predictable state management with Riverpod 2.x
* Typed & guarded navigation via auto_route
* Scalable API integration with Dio + interceptors (auth, locale, logging)
* Multi-locale support (EN, ID, JA) with generated localization files
* Secure session persistence (FlutterSecureStorage + SharedPreferencesWithCache)

## 2. Architecture & Folder Structure
```
lib/
	main.dart                  -> App bootstrap (splash, DI overrides, localization, router)
	core/                      -> Cross-cutting concerns
		constants/               -> Static values (e.g. API constants)
		network/                 -> Dio client, interceptors, API response models
		storage/                 -> Session + language storage services
		services/                -> Logging & provider invalidation service
		routes/                  -> Router + guards
		theme/                   -> Theme, colors
		error/                   -> Exceptions & failure abstractions
		domain/                  -> Generic domain response wrappers
		extensions/              -> UI / string / localization extensions
		usecases/                -> Base use case abstraction
	di/                        -> Riverpod providers wiring (data sources, repos, use cases)
	features/                  -> Each feature has data/domain/presentation/l10n separation
	shared/                    -> Shared widgets / presentation utilities
	l10n_generated/            -> Generated localization arb + dart files
```

Layering inside a feature (example):
```
features/<feature_name>/
	data/      -> Models, DTOs, mappers, remote/local data sources
	domain/    -> Entities, repositories (interfaces), use cases
	presentation/ -> Screens, widgets, controllers/state notifiers
	l10n/      -> Feature-specific localized strings (if any)
```

Benefits:
* Feature isolation improves maintainability
* Explicit boundaries ease refactoring
* Modular providers enable fine-grained invalidation

## 3. Tech Stack
| Concern              | Library / Tool |
|---------------------|----------------|
| State Management     | flutter_riverpod |
| Navigation           | auto_route |
| HTTP Client          | dio |
| Functional Helpers   | fpdart |
| Forms & Validation   | flutter_form_builder, form_builder_validators |
| Persistence          | flutter_secure_storage, shared_preferences |
| Caching / Images     | cached_network_image, flutter_cache_manager |
| Rich Text Editor     | flutter_quill |
| Charts               | fl_chart |
| Localization         | intl + generated ARB files |
| Splash               | flutter_native_splash |
| Logging              | logger |
| Toast / Overlay      | bot_toast |
| Media / Files        | image_picker, file_saver, path_provider |
| Permissions          | permission_handler |
| Calendar UI          | table_calendar |

## 4. Features (High-Level)
Implemented / present modules include (depth varies):
* Authentication (login, register, password reset, set new password)
* Announcement management (admin CRUD)
* Availability & blocked period scheduling
* Business information administration
* Calendar data & reservation management (create, confirm, summary, detail, my list)
* Contact management (admin)
* Customer management (listing, detail)
* Menu management (CRUD, filtering active menus)
* Static pages (Terms of Service, Privacy Policy)
* Home & Profile tabs for end users

## 5. State Management Strategy
Riverpod providers categorize into:
* Core singletons: `secureStorageProvider`, `sharedPreferencesProvider`, `appRouterProvider`
* Feature notifiers: (e.g. `menuNotifierProvider`, `customersNotifierProvider`)
* Derived/computed providers: (e.g. `activeMenusProvider`)

Provider invalidation is centrally orchestrated via `setupProviderInvalidation` (see `core/services/provider_invalidation_setup.dart`) to clear user-scoped state on session changes (logout, token expiry, etc.).

## 6. Networking Layer
`DioClient` wraps Dio with:
* Base configuration (timeouts, JSON responseType, base URL from `ApiConstants`)
* Interceptors:
	* `AuthInterceptor` attaches bearer tokens from `SessionStorageService`
	* `LocaleInterceptor` injects Accept-Language header based on current locale
	* `LoggerInterceptor` (debug only) pretty-prints requests/responses
* Unified response parsing:
	* `ApiResponse<T>` standard single data payload
	* `ApiOffsetPaginationResponse<T>` offset-based pagination
	* `ApiCursorPaginationResponse<T>` cursor-based pagination
* HTML mismatch protection (detects accidental non-JSON server output)
* Normalized error mapping to `ApiErrorResponse`

## 7. Dependency Injection
Riverpod providers in `di/` compose:
1. Low-level services (storage, network)
2. Data sources (remote/local)
3. Repositories (implement domain contracts)
4. Use cases (application logic wrappers)

Override examples in `main.dart` allow swapping implementations (useful for tests or platform distinctions).

## 8. Routing & Navigation
Using `auto_route` with generated file `app_router.gr.dart`.
Highlights:
* Authenticated & public route separation
* Guard types:
	* `AuthGuard` ensures authenticated access
	* `DuplicateGuard` (likely to prevent duplicate navigation actions)
* Nested tab navigation:
	* `AdminTabRoute` (dashboard, calendar, announcements)
	* `UserTabRoute` (home, reservations, profile)
* Strongly typed routes reduce runtime navigation errors

To regenerate routes after changes:
```
dart run build_runner build --delete-conflicting-outputs
```

## 9. Localization (i18n)
Generated files in `l10n_generated/` with ARB sources:
* `app_en.arb`, `app_id.arb`, `app_ja.arb`
Configured via `l10n.yaml` and enabled using Flutter's localization delegates plus `FlutterQuillLocalizations`.
Locale resolution logic:
1. Exact language + country match
2. Language-only match
3. Fallback to first supported (EN)

Add a new language:
1. Duplicate an existing ARB file (e.g. `app_en.arb` -> `app_es.arb`)
2. Translate values
3. Run code generation (if applicable)
4. Update tests if any locale-dependent assertions exist

## 10. Theming
`AppTheme.lightTheme` (and optional dark theme) defined in `core/theme/` controlling colors, typography (GoogleFonts), and component theming. Use custom theme extensions where appropriate for domain-specific styling.

## 11. Error & Exception Handling
* Network errors normalized via `_handleError` in `DioClient`
* Domain / repository errors likely mapped to `Failure` classes (see `core/error/`)
* UI layers should react to typed failures to show friendly messages or retry actions

## 12. Provider Invalidation Lifecycle
`providerInvalidationService` sets a callback invalidating user-scoped providers:
* Current user & mutations
* Customer & menu state
* Reservation selection state (selected date/time/menu)
Ensures stale data is cleared on logout / token refresh events.

## 13. Development Workflow
1. Create or modify feature modules inside `features/<name>/`
2. Add models + mappers (data layer)
3. Define entities + repository contracts (domain layer)
4. Implement repository using data sources
5. Wire providers (data sources, repository, use cases) in `di/`
6. Create presentation providers (notifiers) and screens
7. Add routes & regenerate with build_runner
8. Write/update tests in `test/`

## 14. Code Generation
Tools used:
* `auto_route_generator` for router artifacts
* (Potential) JSON serialization / freezed (not currently visible; add as needed)

Run generation:
```
dart run build_runner build --delete-conflicting-outputs
```
Or watch mode:
```
dart run build_runner watch --delete-conflicting-outputs
```

## 15. Environment & Configuration
Currently `ApiConstants` centralizes the base URL & timeouts. For multi-environment support consider:
* Dart-define flags: `--dart-define=BASE_URL=https://api.example.com`
* Environment-specific flavors (Android/iOS build configs)
* Separate `api_constants_dev.dart` / `api_constants_prod.dart` with conditional imports

## 16. Security Considerations
* Access tokens stored in `FlutterSecureStorage`
* User model cached via `SharedPreferencesWithCache` (non-sensitive) with allowlist to limit cache scope
* Interceptors ensure tokens not leaked in logs (verify logger configuration before production)
* Consider adding certificate pinning (dio interceptors) for improved transport security

## 17. Common Commands
| Action | Command |
|--------|---------|
| Fetch dependencies | `flutter pub get` |
| Generate code | `dart run build_runner build --delete-conflicting-outputs` |
| Run app (debug) | `flutter run` |
| Run tests | `flutter test` |
| Analyze | `dart analyze` |
| Format | `dart format .` |

### Quick Start
```
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

If you encounter HTML-instead-of-JSON API errors, verify the backend endpoint and CORS / auth configuration.
