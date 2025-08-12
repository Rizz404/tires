import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PlatformOverride { android, ios, system }

class PlatformOverrideNotifier extends StateNotifier<PlatformOverride> {
  PlatformOverrideNotifier() : super(PlatformOverride.system);

  void setPlatform(PlatformOverride platform) {
    state = platform;
  }
}

final platformOverrideProvider =
    StateNotifierProvider<PlatformOverrideNotifier, PlatformOverride>((ref) {
      return PlatformOverrideNotifier();
    });

final isIOSThemeProvider = Provider<bool>((ref) {
  final platformOverride = ref.watch(platformOverrideProvider);

  switch (platformOverride) {
    case PlatformOverride.ios:
      return true;
    case PlatformOverride.android:
      return false;
    case PlatformOverride.system:
      return defaultTargetPlatform == TargetPlatform.iOS;
  }
});

extension PlatformX on Object {
  static bool get isIOS {
    return Platform.isIOS;
  }

  static bool get isAndroid {
    return Platform.isAndroid;
  }
}

bool isIOSPlatform(WidgetRef ref) {
  return ref.watch(isIOSThemeProvider);
}

bool isAndroidPlatform(WidgetRef ref) {
  return !ref.watch(isIOSThemeProvider);
}
