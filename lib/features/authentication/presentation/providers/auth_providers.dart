import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/service_providers.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_notifier.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final loginUsecase = ref.watch(loginUsecaseProvider);
  final registerUsecase = ref.watch(registerUsecaseProvider);
  final logoutUsecase = ref.watch(logoutUsecaseProvider);
  final sessionStorageService = ref.watch(
    sessionStorageServiceProvider,
  ); // Add this line

  return AuthNotifier(
    loginUsecase,
    registerUsecase,
    logoutUsecase,
    sessionStorageService, // Add this parameter
  );
});
