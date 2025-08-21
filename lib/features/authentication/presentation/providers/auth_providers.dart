import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_notifier.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final loginUsecase = ref.watch(loginUsecaseProvider);
  final registerUsecase = ref.watch(registerUsecaseProvider);
  final forgotPasswordUsecase = ref.watch(forgotPasswordUsecaseProvider);
  final setNewPasswordUsecase = ref.watch(setNewPasswordUsecaseProvider);
  final logoutUsecase = ref.watch(logoutUsecaseProvider);
  final getCurrentAuthUsecase = ref.watch(getCurrentAuthUsecaseProvider);

  return AuthNotifier(
    loginUsecase,
    registerUsecase,
    forgotPasswordUsecase,
    setNewPasswordUsecase,
    logoutUsecase,
    getCurrentAuthUsecase,
  );
});
