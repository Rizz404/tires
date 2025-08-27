import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/datasource_providers.dart';
import 'package:tires/di/service_providers.dart';
import 'package:tires/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';
import 'package:tires/features/availability/data/repositories/availability_repository_impl.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';
import 'package:tires/features/customer_management/data/datasources/customer_repository_impl.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';
import 'package:tires/features/menu/data/datasources/menu_repository_impl.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  final _authRemoteDatasource = ref.watch(authRemoteDatasourceProvider);
  final _sessionStorageService = ref.watch(sessionStorageServiceProvider);
  return AuthRepositoryImpl(_authRemoteDatasource, _sessionStorageService);
});

final menuRepoProvider = Provider<MenuRepository>((ref) {
  final _menuRemoteDatasource = ref.watch(menuRemoteDatasourceProvider);

  return MenuRepositoryImpl(_menuRemoteDatasource);
});

final customerRepoProvider = Provider<CustomerRepository>((ref) {
  final _customerRemoteDatasource = ref.watch(customerRemoteDatasourceProvider);

  return CustomerRepositoryImpl(_customerRemoteDatasource);
});

final availabilityRepoProvider = Provider<AvailabilityRepository>((ref) {
  final _availabilityRemoteDatasource = ref.watch(
    availabilityRemoteDatasourceProvider,
  );
  return AvailabilityRepositoryImpl(_availabilityRemoteDatasource);
});
