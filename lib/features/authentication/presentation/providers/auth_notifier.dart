import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/get_current_auth_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/set_new_password_usecase.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {
  late RegisterUsecase _registerUsecase;
  late LoginUsecase _loginUsecase;
  late ForgotPasswordUsecase _forgotPasswordUsecase;
  late SetNewPasswordUsecase _setNewPasswordUsecase;
  late LogoutUsecase _logoutUsecase;
  late GetCurrentAuthUsecase _getCurrentAuthUsecase;

  @override
  AuthState build() {
    _loginUsecase = ref.watch(loginUsecaseProvider);
    _registerUsecase = ref.watch(registerUsecaseProvider);
    _forgotPasswordUsecase = ref.watch(forgotPasswordUsecaseProvider);
    _setNewPasswordUsecase = ref.watch(setNewPasswordUsecaseProvider);
    _logoutUsecase = ref.watch(logoutUsecaseProvider);
    _getCurrentAuthUsecase = ref.watch(getCurrentAuthUsecaseProvider);
    Future.microtask(() => checkAuthenticationStatus());
    return AuthState(status: AuthStatus.initial);
  }

  Future<void> checkAuthenticationStatus() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      final result = await _getCurrentAuthUsecase(NoParams());

      result.fold(
        (failure) {
          state = state.copyWith(
            status: AuthStatus.unauthenticated,
            user: null,
          );
        },
        (success) {
          if (success.data?.user != null) {
            state = state.copyWith(
              status: AuthStatus.authenticated,
              user: success.data!.user,
            );
          } else {
            state = state.copyWith(
              status: AuthStatus.unauthenticated,
              user: null,
            );
          }
        },
      );
    } catch (e) {
      state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
    }
  }

  Future<void> register(RegisterParams params) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _registerUsecase(params);
    result.fold(
      (failure) {
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: success.data?.user,
        );
      },
    );
  }

  Future<void> login(LoginParams params) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _loginUsecase(params);
    result.fold(
      (failure) {
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: success.data?.user,
        );
      },
    );
  }

  Future<void> forgotPassword(ForgotPasswordParams params) async {
    state = state.copyWith(status: AuthStatus.loading);
    final result = await _forgotPasswordUsecase(params);

    result.fold(
      (failure) {
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        state = state.copyWith(status: AuthStatus.passwordResetEmailSent);
      },
    );
  }

  Future<void> setNewPassword(SetNewPasswordParams params) async {
    state = state.copyWith(status: AuthStatus.loading);
    final result = await _setNewPasswordUsecase(params);

    result.fold(
      (failure) {
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        state = state.copyWith(
          status: AuthStatus.passwordResetSuccess,
          user: null,
        );
      },
    );
  }

  Future<void> logout(NoParams params) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _logoutUsecase(params);
    result.fold(
      (failure) {
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
      },
    );
  }

  Future<void> refreshAuthenticationStatus() async {
    await checkAuthenticationStatus();
  }
}
