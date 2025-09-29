import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/routes/auth_guard.dart';
import 'package:tires/core/routes/duplicate_guard.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/announcement/presentation/screens/admin_list_announcement_screen.dart';
import 'package:tires/features/announcement/presentation/screens/admin_upsert_announcement_screen.dart';
import 'package:tires/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:tires/features/authentication/presentation/screens/login_screen.dart';
import 'package:tires/features/authentication/presentation/screens/register_screen.dart';
import 'package:tires/features/authentication/presentation/screens/set_new_password_screen.dart';
import 'package:tires/features/availability/presentation/screens/admin_list_availability_screen.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/presentation/screens/admin_list_blocked_period_screen.dart';
import 'package:tires/features/blocked_period/presentation/screens/admin_upsert_blocked_period_screen.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';
import 'package:tires/features/business_information/presentation/screens/admin_edit_business_information_screen.dart';
import 'package:tires/features/business_information/presentation/screens/admin_list_business_information_screen.dart';
import 'package:tires/features/calendar/presentation/screens/admin_upsert_calendar_screen.dart';
import 'package:tires/features/calendar/presentation/screens/admin_list_calendar_screen.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/contact/presentation/screens/admin_list_contact_screen.dart';
import 'package:tires/features/contact/presentation/screens/admin_upsert_contact_screen.dart';
import 'package:tires/features/customer_management/presentation/screens/admin_list_customer_management_screen.dart';
import 'package:tires/features/customer_management/presentation/screens/admin_customer_detail_screen.dart';
import 'package:tires/features/dashboard/presentation/screens/admin_dashboard_screen.dart';
import 'package:tires/features/home/presentation/screens/home_screen.dart';
import 'package:tires/features/inquiry/presentation/screens/inquiry_screen.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/presentation/screens/admin_list_menu_screen.dart';
import 'package:tires/features/menu/presentation/screens/admin_upsert_menu_screen.dart';
import 'package:tires/features/profile/presentation/screens/profile_screen.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/presentation/screens/admin_upsert_reservation_screen.dart';
import 'package:tires/features/reservation/presentation/screens/confirm_reservation_screen.dart';
import 'package:tires/features/reservation/presentation/screens/confirmed_reservation_screen.dart';
import 'package:tires/features/reservation/presentation/screens/create_reservation_screen.dart';
import 'package:tires/features/reservation/presentation/screens/my_reservations_screen.dart';
import 'package:tires/features/reservation/presentation/screens/reservation_summary_screen.dart';
import 'package:tires/features/static/presentation/screens/privacy_policy_screen.dart';
import 'package:tires/features/static/presentation/screens/terms_of_service_screen.dart';
import 'package:tires/shared/presentation/widgets/admin_tab_screen.dart';
import 'package:tires/shared/presentation/widgets/user_tab_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  late final AuthGuard _authGuard;
  late final DuplicateGuard _duplicateGuard;

  AppRouter(this._authGuard, this._duplicateGuard);

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    // * Authentication routes
    AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
    AutoRoute(page: RegisterRoute.page, path: '/register'),
    AutoRoute(page: ForgotPasswordRoute.page, path: '/forgot-password'),
    AutoRoute(page: SetNewPasswordRoute.page, path: '/set-new-password'),

    // * Public
    AutoRoute(page: PrivacyPolicyRoute.page, path: "/privacy-policy"),
    AutoRoute(page: TermsOfServiceRoute.page, path: "/terms-of-service"),

    // * Standalone protected routes
    AutoRoute(page: InquiryRoute.page, path: '/inquiry', guards: [_authGuard]),
    AutoRoute(
      page: CreateReservationRoute.page,
      path: '/create-reservation',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: ConfirmReservationRoute.page,
      path: '/confirm-reservation',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: ReservationSummaryRoute.page,
      path: '/reservation-summary',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: ConfirmedReservationRoute.page,
      path: '/confirmed-reservation',
      guards: [_authGuard],
    ),

    // * Admin routes - ALL need authentication
    AutoRoute(
      page: AdminUpsertAnnouncementRoute.page,
      path: '/admin/announcement/upsert',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminListAvailabilityRoute.page,
      path: '/admin/availability',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminListBlockedPeriodRoute.page,
      path: '/admin/blocked',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminUpsertBlockedPeriodRoute.page,
      path: '/admin/blocked/upsert',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminListBusinessInformationRoute.page,
      path: '/admin/business-info',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminEditBusinessInformationRoute.page,
      path: '/admin/business-info/upsert',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminUpsertCalendarRoute.page,
      path: '/admin/calendar/upsert',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminUpsertReservationRoute.page,
      path: '/admin/reservation/upsert',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminListContactRoute.page,
      path: '/admin/contact',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminUpsertContactRoute.page,
      path: '/admin/contact/upsert',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminListCustomerManagementRoute.page,
      path: '/admin/customer',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminCustomerDetailRoute.page,
      path: '/admin/customer/:id',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminListMenuRoute.page,
      path: '/admin/menu',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminUpsertMenuRoute.page,
      path: '/admin/menu/upsert',
      guards: [_authGuard],
    ),

    // ! gak bisa pake auth guard di tab screen
    // * Admin tab navigation
    AutoRoute(
      page: AdminTabRoute.page,
      path: '/admin',
      guards: [_authGuard],
      children: [
        AutoRoute(page: AdminDashboardRoute.page, path: 'dashboard'),
        AutoRoute(page: AdminListCalendarRoute.page, path: 'calendar'),
        AutoRoute(page: AdminListAnnouncementRoute.page, path: 'announcements'),
      ],
    ),

    // * User tab navigation
    AutoRoute(
      page: UserTabRoute.page,
      path: '/',
      guards: [_authGuard],
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home'),
        AutoRoute(page: MyReservationsRoute.page, path: 'reservations'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),
  ];
}
