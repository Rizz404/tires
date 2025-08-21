import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/get_current_auth_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/set_new_password_usecase.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RegisterUsecase _registerUsecase;
  final LoginUsecase _loginUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final SetNewPasswordUsecase _setNewPasswordUsecase;
  final LogoutUsecase _logoutUsecase;
  final GetCurrentAuthUsecase _getCurrentAuthUsecase;

  AuthNotifier(
    this._loginUsecase,
    this._registerUsecase,
    this._forgotPasswordUsecase,
    this._setNewPasswordUsecase,
    this._logoutUsecase,
    this._getCurrentAuthUsecase,
  ) : super(AuthState(status: AuthStatus.initial)) {
    checkAuthenticationStatus();
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
