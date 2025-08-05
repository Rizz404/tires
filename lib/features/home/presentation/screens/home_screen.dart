import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/l10n/app_localizations.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context)!;

    return Scaffold(
      body: ScreenWrapper(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(l10n.homeScreenGreeting),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  ref.read(localeProvider.notifier).state = const Locale('id');
                },
                child: const Text('Ganti ke Bahasa Indonesia'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(localeProvider.notifier).state = const Locale('en');
                },
                child: const Text('Switch to English'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(localeProvider.notifier).state = const Locale('ja');
                },
                child: const Text('日本語に切り替える'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
