import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/repository_providers.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/delete_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcement_statistics_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/update_announcement_usecase.dart';
import 'package:tires/features/blocked_period/domain/usecases/create_blocked_period_usecase.dart';
import 'package:tires/features/blocked_period/domain/usecases/delete_blocked_period_usecase.dart';
import 'package:tires/features/blocked_period/domain/usecases/get_blocked_periods_cursor_usecase.dart';
import 'package:tires/features/blocked_period/domain/usecases/get_blocked_period_statistics_usecase.dart';
import 'package:tires/features/blocked_period/domain/usecases/update_blocked_period_usecase.dart';
import 'package:tires/features/contact/domain/usecases/create_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/delete_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/get_contacts_cursor_usecase.dart';
import 'package:tires/features/contact/domain/usecases/get_contact_statistics_usecase.dart';
import 'package:tires/features/contact/domain/usecases/update_contact_usecase.dart';
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
import 'package:tires/features/customer_management/domain/usecases/get_customers_cursor_usecase.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_statistics_usecase.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_detail_usecase.dart';
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
import 'package:tires/features/user/domain/usecases/get_users_cursor_usecase.dart';
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

final getCustomersCursorUsecaseProvider = Provider<GetCustomersCursorUsecase>((
  ref,
) {
  final _customerRepository = ref.watch(customerRepoProvider);
  return GetCustomersCursorUsecase(_customerRepository);
});

final getCustomerStatisticsUsecaseProvider =
    Provider<GetCustomerStatisticsUsecase>((ref) {
      final _customerRepository = ref.watch(customerRepoProvider);
      return GetCustomerStatisticsUsecase(_customerRepository);
    });

final getCustomerDetailUsecaseProvider = Provider<GetCustomerDetailUsecase>((
  ref,
) {
  final _customerRepository = ref.watch(customerRepoProvider);
  return GetCustomerDetailUsecase(_customerRepository);
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

final getUsersCursorUsecaseProvider = Provider<GetUsersCursorUsecase>((ref) {
  final _usersRepository = ref.watch(usersRepoProvider);
  return GetUsersCursorUsecase(_usersRepository);
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

// Blocked Period Usecase Providers
final getBlockedPeriodsCursorUsecaseProvider =
    Provider<GetBlockedPeriodsCursorUsecase>((ref) {
      final _blockedPeriodRepository = ref.watch(blockedPeriodRepoProvider);
      return GetBlockedPeriodsCursorUsecase(_blockedPeriodRepository);
    });

final createBlockedPeriodUsecaseProvider = Provider<CreateBlockedPeriodUsecase>(
  (ref) {
    final _blockedPeriodRepository = ref.watch(blockedPeriodRepoProvider);
    return CreateBlockedPeriodUsecase(_blockedPeriodRepository);
  },
);

final updateBlockedPeriodUsecaseProvider = Provider<UpdateBlockedPeriodUsecase>(
  (ref) {
    final _blockedPeriodRepository = ref.watch(blockedPeriodRepoProvider);
    return UpdateBlockedPeriodUsecase(_blockedPeriodRepository);
  },
);

final deleteBlockedPeriodUsecaseProvider = Provider<DeleteBlockedPeriodUsecase>(
  (ref) {
    final _blockedPeriodRepository = ref.watch(blockedPeriodRepoProvider);
    return DeleteBlockedPeriodUsecase(_blockedPeriodRepository);
  },
);

final getBlockedPeriodStatisticsUsecaseProvider =
    Provider<GetBlockedPeriodStatisticsUsecase>((ref) {
      final _blockedPeriodRepository = ref.watch(blockedPeriodRepoProvider);
      return GetBlockedPeriodStatisticsUsecase(_blockedPeriodRepository);
    });

// Contact Usecase Providers
final getContactsCursorUsecaseProvider = Provider<GetContactsCursorUsecase>((
  ref,
) {
  final _contactRepository = ref.watch(contactRepoProvider);
  return GetContactsCursorUsecase(_contactRepository);
});

final createContactUsecaseProvider = Provider<CreateContactUsecase>((ref) {
  final _contactRepository = ref.watch(contactRepoProvider);
  return CreateContactUsecase(_contactRepository);
});

final updateContactUsecaseProvider = Provider<UpdateContactUsecase>((ref) {
  final _contactRepository = ref.watch(contactRepoProvider);
  return UpdateContactUsecase(_contactRepository);
});

final deleteContactUsecaseProvider = Provider<DeleteContactUsecase>((ref) {
  final _contactRepository = ref.watch(contactRepoProvider);
  return DeleteContactUsecase(_contactRepository);
});

final getContactStatisticsUsecaseProvider =
    Provider<GetContactStatisticsUsecase>((ref) {
      final _contactRepository = ref.watch(contactRepoProvider);
      return GetContactStatisticsUsecase(_contactRepository);
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
