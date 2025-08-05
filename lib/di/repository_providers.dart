import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/datasource_providers.dart';
import 'package:tires/di/service_providers.dart';
import 'package:tires/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  final _authRemoteDatasource = ref.watch(authRemoteDatasourceProvider);
  final _sessionStorageService = ref.watch(sessionStorageServiceProvider);
  return AuthRepositoryImpl(_authRemoteDatasource, _sessionStorageService);
});
