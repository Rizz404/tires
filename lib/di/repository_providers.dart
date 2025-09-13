import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/datasource_providers.dart';
import 'package:tires/di/service_providers.dart';
import 'package:tires/features/announcement/data/repositories/announcement_repository_impl.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/business_information/data/repositories/business_information_repository_impl.dart';
import 'package:tires/features/business_information/domain/repositories/business_information_repository.dart';
import 'package:tires/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';
import 'package:tires/features/availability/data/repositories/availability_repository_impl.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';
import 'package:tires/features/customer_management/data/repositories/customer_repository_impl.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';
import 'package:tires/features/inquiry/data/repositories/inquiry_repository_impl.dart';
import 'package:tires/features/inquiry/domain/repositories/inquiry_repository.dart';
import 'package:tires/features/menu/data/datasources/menu_repository_impl.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';
import 'package:tires/features/reservation/data/repositories/reservation_repository_impl.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:tires/features/user/data/repositories/current_user_repository_impl.dart';
import 'package:tires/features/user/domain/repositories/current_user_repository.dart';
import 'package:tires/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:tires/features/dashboard/domain/repositories/dashboard_repository.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  final _authRemoteDatasource = ref.watch(authRemoteDatasourceProvider);
  final _sessionStorageService = ref.watch(sessionStorageServiceProvider);
  final _providerInvalidationService = ref.watch(
    providerInvalidationServiceProvider,
  );
  return AuthRepositoryImpl(
    _authRemoteDatasource,
    _sessionStorageService,
    _providerInvalidationService,
  );
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

final userRepoProvider = Provider<CurrentUserRepository>((ref) {
  final _userRemoteDatasource = ref.watch(userRemoteDatasourceProvider);
  final _sessionStorageService = ref.watch(sessionStorageServiceProvider);
  return CurrentUserRepositoryImpl(
    _userRemoteDatasource,
    _sessionStorageService,
  );
});

final inquiryRepoProvider = Provider<InquiryRepository>((ref) {
  final _inquiryRemoteDatasource = ref.watch(inquiryRemoteDatasourceProvider);
  return InquiryRepositoryImpl(_inquiryRemoteDatasource);
});

final reservationRepoProvider = Provider<ReservationRepository>((ref) {
  final _reservationRemoteDatasource = ref.watch(
    reservationRemoteDatasourceProvider,
  );
  return ReservationRepositoryImpl(_reservationRemoteDatasource);
});

final announcementRepoProvider = Provider<AnnouncementRepository>((ref) {
  final _announcementRemoteDatasource = ref.watch(
    announcementRemoteDatasourceProvider,
  );
  return AnnouncementRepositoryImpl(_announcementRemoteDatasource);
});

final dashboardRepoProvider = Provider<DashboardRepository>((ref) {
  final _dashboardRemoteDatasource = ref.watch(
    dashboardRemoteDatasourceProvider,
  );
  return DashboardRepositoryImpl(_dashboardRemoteDatasource);
});

final businessInformationRepoProvider = Provider<BusinessInformationRepository>(
  (ref) {
    final _businessInformationRemoteDatasource = ref.watch(
      businessInformationRemoteDatasourceProvider,
    );
    return BusinessInformationRepositoryImpl(
      _businessInformationRemoteDatasource,
    );
  },
);
