import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/features/announcement/data/datasources/announcement_remote_datasource.dart';
import 'package:tires/features/business_information/data/datasources/business_information_remote_datasource.dart';
import 'package:tires/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:tires/features/availability/data/datasources/availability_remote_datasource.dart';
import 'package:tires/features/customer_management/data/datasources/customer_remote_datasource.dart';
import 'package:tires/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:tires/features/inquiry/data/datasources/inquiry_remote_datasource.dart';
import 'package:tires/features/menu/data/datasources/menu_remote_datasource.dart';
import 'package:tires/features/reservation/data/datasources/reservation_remote_datasource.dart';
import 'package:tires/features/user/data/datasources/current_user_remote_datasource.dart';
import 'package:tires/features/user/data/datasources/users_remote_datasource.dart';

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

final userRemoteDatasourceProvider = Provider<CurrentUserRemoteDatasource>((
  ref,
) {
  final _dioClient = ref.watch(dioClientProvider);
  return CurrentUserRemoteDatasourceImpl(_dioClient);
});

final usersRemoteDatasourceProvider = Provider<UsersRemoteDatasource>((ref) {
  final _dioClient = ref.watch(dioClientProvider);
  return UsersRemoteDatasourceImpl(_dioClient);
});

final inquiryRemoteDatasourceProvider = Provider<InquiryRemoteDatasource>((
  ref,
) {
  final _dioClient = ref.watch(dioClientProvider);
  return InquiryRemoteDatasourceImpl(_dioClient);
});

final reservationRemoteDatasourceProvider =
    Provider<ReservationRemoteDatasource>((ref) {
      final _dioClient = ref.watch(dioClientProvider);
      return ReservationRemoteDatasourceImpl(_dioClient);
    });

final announcementRemoteDatasourceProvider =
    Provider<AnnouncementRemoteDatasource>((ref) {
      final _dioClient = ref.watch(dioClientProvider);
      return AnnouncementRemoteDatasourceImpl(_dioClient);
    });

final dashboardRemoteDatasourceProvider = Provider<DashboardRemoteDataSource>((
  ref,
) {
  final _dioClient = ref.watch(dioClientProvider);
  return DashboardRemoteDataSourceImpl(_dioClient);
});

final businessInformationRemoteDatasourceProvider =
    Provider<BusinessInformationRemoteDatasource>((ref) {
      final _dioClient = ref.watch(dioClientProvider);
      return BusinessInformationRemoteDatasourceImpl(_dioClient);
    });
