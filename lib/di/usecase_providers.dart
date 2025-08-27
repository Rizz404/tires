import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/repository_providers.dart';
import 'package:tires/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/get_current_auth_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/set_new_password_usecase.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_menu_cursor_usecase.dart';

final registerUsecaseProvider = Provider<RegisterUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return RegisterUsecase(_authRepository);
});

final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return LoginUsecase(_authRepository);
});

final forgotPasswordUsecaseProvider = Provider<ForgotPasswordUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return ForgotPasswordUsecase(_authRepository);
});

final setNewPasswordUsecaseProvider = Provider<SetNewPasswordUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return SetNewPasswordUsecase(_authRepository);
});

final logoutUsecaseProvider = Provider<LogoutUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return LogoutUsecase(_authRepository);
});

final getCurrentAuthUsecaseProvider = Provider<GetCurrentAuthUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return GetCurrentAuthUsecase(_authRepository);
});

final getMenuCursorUsecaseProvider = Provider<GetMenuCursorUsecase>((ref) {
  final _menuRepository = ref.watch(menuRepoProvider);
  return GetMenuCursorUsecase(_menuRepository);
});

final getCustomerCursorUsecaseProvider = Provider<GetCustomerCursorUsecase>((
  ref,
) {
  final _customerRepository = ref.watch(customerRepoProvider);
  return GetCustomerCursorUsecase(_customerRepository);
});
