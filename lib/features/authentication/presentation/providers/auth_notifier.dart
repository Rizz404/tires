import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RegisterUsecase _registerUsecase;
  final LoginUsecase _loginUsecase;
  final LogoutUsecase _logoutUsecase;

  AuthNotifier(this._loginUsecase, this._registerUsecase, this._logoutUsecase)
    : super(AuthState(status: AuthStatus.initial));

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
          user: success.data,
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
        state = state.copyWith(status: AuthStatus.unauthenticated);
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
        state = state.copyWith(status: AuthStatus.unauthenticated);
      },
    );
  }
}
