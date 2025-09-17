import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/repository_providers.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/delete_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcement_statistics_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/update_announcement_usecase.dart';
import 'package:tires/features/business_information/domain/usecases/get_business_information_usecase.dart';
import 'package:tires/features/business_information/domain/usecases/get_public_business_information_usecase.dart';
import 'package:tires/features/business_information/domain/usecases/update_business_information_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/get_current_auth_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/set_new_password_usecase.dart';
import 'package:tires/features/customer_management/domain/usecases/get_current_user_dashboard_usecase.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';
import 'package:tires/features/inquiry/domain/usecases/create_inquiry_usecase.dart';
import 'package:tires/features/menu/domain/usecases/create_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/delete_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_admin_menus_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_menus_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_menu_statistics_usecase.dart';
import 'package:tires/features/menu/domain/usecases/update_menu_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_current_user_reservations_cursor_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_available_hours_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_calendar_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_cursor_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/update_reservation_usecase.dart';
import 'package:tires/features/user/domain/usecases/delete_current_user_account_usecase.dart';
import 'package:tires/features/user/domain/usecases/get_current_user_usecase.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_password_usecase.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_usecase.dart';
import 'package:tires/features/dashboard/domain/usecases/get_dashboard_usecase.dart';

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

final getMenusCursorUsecaseProvider = Provider<GetMenusCursorUsecase>((ref) {
  final _menuRepository = ref.watch(menuRepoProvider);
  return GetMenusCursorUsecase(_menuRepository);
});

final getAdminMenusCursorUsecaseProvider = Provider<GetAdminMenusCursorUsecase>(
  (ref) {
    final _menuRepository = ref.watch(menuRepoProvider);
    return GetAdminMenusCursorUsecase(_menuRepository);
  },
);

final createMenuUsecaseProvider = Provider<CreateMenuUsecase>((ref) {
  final _menuRepository = ref.watch(menuRepoProvider);
  return CreateMenuUsecase(_menuRepository);
});

final updateMenuUsecaseProvider = Provider<UpdateMenuUsecase>((ref) {
  final _menuRepository = ref.watch(menuRepoProvider);
  return UpdateMenuUsecase(_menuRepository);
});

final deleteMenuUsecaseProvider = Provider<DeleteMenuUsecase>((ref) {
  final _menuRepository = ref.watch(menuRepoProvider);
  return DeleteMenuUsecase(_menuRepository);
});

final getMenuStatisticsUsecaseProvider = Provider<GetMenuStatisticsUsecase>((
  ref,
) {
  final _menuRepository = ref.watch(menuRepoProvider);
  return GetMenuStatisticsUsecase(_menuRepository);
});

final getCustomerCursorUsecaseProvider = Provider<GetCustomerCursorUsecase>((
  ref,
) {
  final _customerRepository = ref.watch(customerRepoProvider);
  return GetCustomerCursorUsecase(_customerRepository);
});

// User Usecase Providers
final getCurrentUserUsecaseProvider = Provider<GetCurrentUserUsecase>((ref) {
  final _userRepository = ref.watch(userRepoProvider);
  return GetCurrentUserUsecase(_userRepository);
});

final updateCurrentUserUsecaseProvider = Provider<UpdateCurrentUserUsecase>((
  ref,
) {
  final _userRepository = ref.watch(userRepoProvider);
  return UpdateCurrentUserUsecase(_userRepository);
});

final updateCurrentUserPasswordUsecaseProvider =
    Provider<UpdateCurrentUserPasswordUsecase>((ref) {
      final _userRepository = ref.watch(userRepoProvider);
      return UpdateCurrentUserPasswordUsecase(_userRepository);
    });

final getCurrentUserReservationsCursorUsecaseProvider =
    Provider<GetCurrentUserReservationsCursorUsecase>((ref) {
      final _reservationRepository = ref.watch(reservationRepoProvider);
      return GetCurrentUserReservationsCursorUsecase(_reservationRepository);
    });

final deleteCurrentUserAccountUsecaseProvider =
    Provider<DeleteCurrentUserAccountUsecase>((ref) {
      final _userRepository = ref.watch(userRepoProvider);
      return DeleteCurrentUserAccountUsecase(_userRepository);
    });

final getCurrentUserDashboardUsecaseProvider =
    Provider<GetCurrentUserDashboardUsecase>((ref) {
      final _customerRepository = ref.watch(customerRepoProvider);
      return GetCurrentUserDashboardUsecase(_customerRepository);
    });

// Inquiry Usecase Providers
final createInquiryUsecaseProvider = Provider<CreateInquiryUsecase>((ref) {
  final _inquiryRepository = ref.watch(inquiryRepoProvider);
  return CreateInquiryUsecase(_inquiryRepository);
});

// Reservation Usecase Providers
final getReservationCursorUsecaseProvider =
    Provider<GetReservationCursorUsecase>((ref) {
      final _reservationRepository = ref.watch(reservationRepoProvider);
      return GetReservationCursorUsecase(_reservationRepository);
    });

final createReservationUsecaseProvider = Provider<CreateReservationUsecase>((
  ref,
) {
  final _reservationRepository = ref.watch(reservationRepoProvider);
  return CreateReservationUsecase(_reservationRepository);
});

final updateReservationUsecaseProvider = Provider<UpdateReservationUsecase>((
  ref,
) {
  final _reservationRepository = ref.watch(reservationRepoProvider);
  return UpdateReservationUsecase(_reservationRepository);
});

final deleteReservationUsecaseProvider = Provider<DeleteReservationUsecase>((
  ref,
) {
  final _reservationRepository = ref.watch(reservationRepoProvider);
  return DeleteReservationUsecase(_reservationRepository);
});

final getReservationCalendarUsecaseProvider =
    Provider<GetReservationCalendarUsecase>((ref) {
      final _reservationRepository = ref.watch(reservationRepoProvider);
      return GetReservationCalendarUsecase(_reservationRepository);
    });

final getReservationAvailableHoursUsecaseProvider =
    Provider<GetReservationAvailableHoursUsecase>((ref) {
      final _reservationRepository = ref.watch(reservationRepoProvider);
      return GetReservationAvailableHoursUsecase(_reservationRepository);
    });

final getAnnouncementsCursorUsecaseProvider =
    Provider<GetAnnouncementsCursorUsecase>((ref) {
      final _announcementRepository = ref.watch(announcementRepoProvider);
      return GetAnnouncementsCursorUsecase(_announcementRepository);
    });

final createAnnouncementUsecaseProvider = Provider<CreateAnnouncementUsecase>((
  ref,
) {
  final _announcementRepository = ref.watch(announcementRepoProvider);
  return CreateAnnouncementUsecase(_announcementRepository);
});

final updateAnnouncementUsecaseProvider = Provider<UpdateAnnouncementUsecase>((
  ref,
) {
  final _announcementRepository = ref.watch(announcementRepoProvider);
  return UpdateAnnouncementUsecase(_announcementRepository);
});

final deleteAnnouncementUsecaseProvider = Provider<DeleteAnnouncementUsecase>((
  ref,
) {
  final _announcementRepository = ref.watch(announcementRepoProvider);
  return DeleteAnnouncementUsecase(_announcementRepository);
});

final getAnnouncementStatisticsUsecaseProvider =
    Provider<GetAnnouncementStatisticsUsecase>((ref) {
      final _announcementRepository = ref.watch(announcementRepoProvider);
      return GetAnnouncementStatisticsUsecase(_announcementRepository);
    });

final getDashboardUsecaseProvider = Provider<GetDashboardUsecase>((ref) {
  final _dashboardRepository = ref.watch(dashboardRepoProvider);
  return GetDashboardUsecase(_dashboardRepository);
});

// Business Information Usecase Providers
final getBusinessInformationUsecaseProvider =
    Provider<GetBusinessInformationUsecase>((ref) {
      final _businessInformationRepository = ref.watch(
        businessInformationRepoProvider,
      );
      return GetBusinessInformationUsecase(_businessInformationRepository);
    });

final getPublicBusinessInformationUsecaseProvider =
    Provider<GetPublicBusinessInformationUsecase>((ref) {
      final _businessInformationRepository = ref.watch(
        businessInformationRepoProvider,
      );
      return GetPublicBusinessInformationUsecase(
        _businessInformationRepository,
      );
    });

final updateBusinessInformationUsecaseProvider =
    Provider<UpdateBusinessInformationUsecase>((ref) {
      final _businessInformationRepository = ref.watch(
        businessInformationRepoProvider,
      );
      return UpdateBusinessInformationUsecase(_businessInformationRepository);
    });
