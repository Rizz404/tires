import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/repository_providers.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_menus_usecase.dart';

final registerUsecaseProvider = Provider<RegisterUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return RegisterUsecase(_authRepository);
});

final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return LoginUsecase(_authRepository);
});

final logoutUsecaseProvider = Provider<LogoutUsecase>((ref) {
  final _authRepository = ref.watch(authRepoProvider);
  return LogoutUsecase(_authRepository);
});

final getMenuCursorUsecaseProvider = Provider<GetMenusUsecase>((ref) {
  final _menuRepository = ref.watch(menuRepoProvider);
  return GetMenusUsecase(_menuRepository);
});
