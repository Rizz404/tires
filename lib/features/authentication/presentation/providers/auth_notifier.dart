import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';
import 'package:tires/core/storage/session_storage_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RegisterUsecase _registerUsecase;
  final LoginUsecase _loginUsecase;
  final LogoutUsecase _logoutUsecase;
  final SessionStorageService _sessionStorageService;

  AuthNotifier(
    this._loginUsecase,
    this._registerUsecase,
    this._logoutUsecase,
    this._sessionStorageService,
  ) : super(AuthState(status: AuthStatus.initial)) {
    // Automatically check authentication status when notifier is created
    checkAuthenticationStatus();
  }

  /// Check if user is already authenticated by looking for stored token and user data
  Future<void> checkAuthenticationStatus() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);

      // Check if access token exists
      final accessToken = await _sessionStorageService.getAccessToken();

      // Check if user data exists
      final user = await _sessionStorageService.getUser();

      if (accessToken != null && user != null) {
        // Both token and user exist, user is authenticated
        state = state.copyWith(status: AuthStatus.authenticated, user: user);
      } else {
        // Either token or user is missing, user is not authenticated
        state = state.copyWith(status: AuthStatus.unauthenticated, user: null);

        // Clean up any partial data
        if (accessToken == null) {
          await _sessionStorageService.deleteUser();
        }
        if (user == null) {
          await _sessionStorageService.deleteAccessToken();
        }
      }
    } catch (e) {
      // If there's an error checking authentication, assume unauthenticated
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
        // Fixed: Should be authenticated after successful login, not unauthenticated
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: success.data?.user, // Assuming success contains user data
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
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null, // Clear user data on logout
        );
      },
    );
  }

  /// Force refresh authentication status
  Future<void> refreshAuthenticationStatus() async {
    await checkAuthenticationStatus();
  }
}
