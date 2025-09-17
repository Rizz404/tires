import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
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
      AppLogger.uiInfo('Checking authentication status');
      state = state.copyWith(status: AuthStatus.loading);
      final result = await _getCurrentAuthUsecase(NoParams());

      result.fold(
        (failure) {
          AppLogger.uiError('Failed to check authentication status', failure);
          state = state.copyWith(
            status: AuthStatus.unauthenticated,
            user: null,
          );
        },
        (success) {
          if (success.data?.user != null) {
            AppLogger.uiInfo('User authenticated successfully');
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
    AppLogger.uiInfo('Registering user');
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _registerUsecase(params);
    result.fold(
      (failure) {
        AppLogger.uiError('Failed to register user', failure);
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        AppLogger.uiInfo('User registered successfully');
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: success.data?.user,
        );
      },
    );
  }

  Future<void> login(LoginParams params) async {
    AppLogger.uiInfo('Logging in user');
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _loginUsecase(params);
    result.fold(
      (failure) {
        AppLogger.uiError('Failed to login user', failure);
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        AppLogger.uiInfo('User logged in successfully');
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: success.data?.user,
        );
      },
    );
  }

  Future<void> forgotPassword(ForgotPasswordParams params) async {
    AppLogger.uiInfo('Sending forgot password email');
    state = state.copyWith(status: AuthStatus.loading);
    final result = await _forgotPasswordUsecase(params);

    result.fold(
      (failure) {
        AppLogger.uiError('Failed to send forgot password email', failure);
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        AppLogger.uiInfo('Forgot password email sent successfully');
        state = state.copyWith(status: AuthStatus.passwordResetEmailSent);
      },
    );
  }

  Future<void> setNewPassword(SetNewPasswordParams params) async {
    AppLogger.uiInfo('Setting new password');
    state = state.copyWith(status: AuthStatus.loading);
    final result = await _setNewPasswordUsecase(params);

    result.fold(
      (failure) {
        AppLogger.uiError('Failed to set new password', failure);
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        AppLogger.uiInfo('New password set successfully');
        state = state.copyWith(
          status: AuthStatus.passwordResetSuccess,
          user: null,
        );
      },
    );
  }

  Future<void> logout(NoParams params) async {
    AppLogger.uiInfo('Logging out user');
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _logoutUsecase(params);
    result.fold(
      (failure) {
        AppLogger.uiError('Failed to logout user', failure);
        state = state.copyWith(status: AuthStatus.error, failure: failure);
      },
      (success) {
        AppLogger.uiInfo('User logged out successfully');
        state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
      },
    );
  }

  Future<void> refreshAuthenticationStatus() async {
    AppLogger.uiInfo('Refreshing authentication status');
    await checkAuthenticationStatus();
  }
}
