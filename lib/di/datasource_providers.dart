import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:tires/features/availability/data/datasources/availability_remote_datasource.dart';
import 'package:tires/features/availability/data/datasources/availability_remote_datasource_impl.dart';
import 'package:tires/features/customer_management/data/datasources/customer_remote_datasource.dart';
import 'package:tires/features/menu/data/datasources/menu_remote_datasource.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  final _dioClient = ref.watch(dioClientProvider);
  return AuthRemoteDatasourceImpl(_dioClient);
});

final menuRemoteDatasourceProvider = Provider<MenuRemoteDatasource>((ref) {
  final _dioClient = ref.watch(dioClientProvider);
  return MenuRemoteDatasourceImpl(_dioClient);
});

final customerRemoteDatasourceProvider = Provider<CustomerRemoteDatasource>((
  ref,
) {
  final _dioClient = ref.watch(dioClientProvider);
  return CustomerRemoteDatasourceImpl(_dioClient);
});

final availabilityRemoteDatasourceProvider =
    Provider<AvailabilityRemoteDatasource>((ref) {
      final _dioClient = ref.watch(dioClientProvider);
      return AvailabilityRemoteDatasourceImpl(_dioClient);
    });
