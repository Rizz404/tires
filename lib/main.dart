import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/di/common_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:tires/l10n_generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // * Storage
    const secureStorage = FlutterSecureStorage();
    final preferencesWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(allowList: {}),
    );
    final preferences = await SharedPreferences.getInstance();

    runApp(
      ProviderScope(
        overrides: [
          secureStorageProvider.overrideWithValue(secureStorage),
          sharedPreferencesWithCacheProvider.overrideWithValue(
            preferencesWithCache,
          ),
          sharedPreferencesProvider.overrideWithValue(preferences),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    runApp(
      ProviderScope(
        child: MaterialApp(
          // Add localization support even in error case
          localizationsDelegates: const [
            L10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.supportedLocales,
          home: const Scaffold(
            body: Center(child: Text('Error initializing app')),
          ),
        ),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final currentLocale = ref.watch(localeProvider);
    // final themeMode = ref.watch(themeProvider);
    final botToastBuilder = BotToastInit();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Test App",
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      builder: (context, child) => botToastBuilder(context, child),
      routerConfig: appRouter.config(
        navigatorObservers: () => [BotToastNavigatorObserver()],
      ),

      // * Localization Configuration
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.supportedLocales,
      locale: currentLocale,

      // * Locale Resolution Strategy
      localeResolutionCallback: (locale, supportedLocales) {
        // If device locale is supported, use it
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }

          // If exact match not found, try language code only
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }

        // Fallback to first supported locale (should be 'en')
        return supportedLocales.first;
      },
    );
  }
}
