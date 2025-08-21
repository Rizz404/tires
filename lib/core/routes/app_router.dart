import 'package:auto_route/auto_route.dart';
import 'package:tires/core/routes/auth_guard.dart';
import 'package:tires/core/routes/duplicate_guard.dart';
import 'package:tires/features/announcement/presentation/screens/admin_list_announcement_screen.dart';
import 'package:tires/features/announcement/presentation/screens/admin_upsert_announcement_screen.dart';
import 'package:tires/features/authentication/presentation/screens/login_screen.dart';
import 'package:tires/features/authentication/presentation/screens/register_screen.dart';
import 'package:tires/features/availability/presentation/screens/admin_list_availability_screen.dart';
import 'package:tires/features/blocked/presentation/screens/admin_list_blocked_screen.dart';
import 'package:tires/features/blocked/presentation/screens/admin_upsert_blocked_screen.dart';
import 'package:tires/features/bussiness_information/presentation/screens/admin_list_bussiness_information_screen.dart';
import 'package:tires/features/bussiness_information/presentation/screens/admin_upsert_bussiness_information_screen.dart';
import 'package:tires/features/calendar/presentation/screens/admin_upsert_calendar_screen.dart';
import 'package:tires/features/calendar/presentation/screens/admin_list_calendar_screen.dart';
import 'package:tires/features/contact/presentation/screens/admin_list_contact_screen.dart';
import 'package:tires/features/contact/presentation/screens/admin_upsert_contact_screen.dart';
import 'package:tires/features/customer_management/presentation/screens/admin_list_customer_management_screen.dart';
import 'package:tires/features/customer_management/presentation/screens/admin_upsert_customer_management_screen.dart';
import 'package:tires/features/dashboard/presentation/screens/admin_dasboard_screen.dart';
import 'package:tires/features/home/presentation/screens/home_screen.dart';
import 'package:tires/features/inquiry/presentation/screens/inquiry_screen.dart';
import 'package:tires/features/menu/presentation/screens/admin_list_menu_screen.dart';
import 'package:tires/features/menu/presentation/screens/admin_upsert_menu_screen.dart';
import 'package:tires/features/profile/presentation/screens/profile_screen.dart';
import 'package:tires/features/reservation/presentation/screens/confirm_reservation_screen.dart';
import 'package:tires/features/reservation/presentation/screens/confirmed_reservation_screen.dart';
import 'package:tires/features/reservation/presentation/screens/create_reservation_screen.dart';
import 'package:tires/features/reservation/presentation/screens/my_reservations_screen.dart';
import 'package:tires/features/reservation/presentation/screens/reservation_summary_screen.dart';
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
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),

    // * User inquiry routes
    AutoRoute(page: InquiryRoute.page, guards: [_authGuard]),

    // * User reservation routes
    AutoRoute(page: CreateReservationRoute.page, guards: [_authGuard]),
    AutoRoute(page: ConfirmReservationRoute.page, guards: [_authGuard]),
    AutoRoute(page: ReservationSummaryRoute.page, guards: [_authGuard]),
    AutoRoute(page: ConfirmedReservationRoute.page, guards: [_authGuard]),

    // * Admin Dashboard
    AutoRoute(page: AdminDasboardRoute.page, guards: [_authGuard]),

    // * Admin Announcement Management
    AutoRoute(page: AdminListAnnouncementRoute.page, guards: [_authGuard]),
    AutoRoute(page: AdminUpsertAnnouncementRoute.page, guards: [_authGuard]),

    // * Admin Availability Management
    AutoRoute(page: AdminListAvailabilityRoute.page, guards: [_authGuard]),

    // * Admin Blocked Management
    AutoRoute(page: AdminListBlockedRoute.page, guards: [_authGuard]),
    AutoRoute(page: AdminUpsertBlockedRoute.page, guards: [_authGuard]),

    // * Admin Business Information Management
    AutoRoute(
      page: AdminListBussinessInformationRoute.page,
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminUpsertBussinessInformationRoute.page,
      guards: [_authGuard],
    ),

    // * Admin Calendar Management
    AutoRoute(page: AdminListCalendarRoute.page, guards: [_authGuard]),
    AutoRoute(page: AdminUpsertCalendarRoute.page, guards: [_authGuard]),

    // * Admin Contact Management
    AutoRoute(page: AdminListContactRoute.page, guards: [_authGuard]),
    AutoRoute(page: AdminUpsertContactRoute.page, guards: [_authGuard]),

    // * Admin Customer Management
    AutoRoute(
      page: AdminListCustomerManagementRoute.page,
      guards: [_authGuard],
    ),
    AutoRoute(
      page: AdminUpsertCustomerManagementRoute.page,
      guards: [_authGuard],
    ),

    // * Admin Menu Management
    AutoRoute(page: AdminListMenuRoute.page, guards: [_authGuard]),
    AutoRoute(page: AdminUpsertMenuRoute.page, guards: [_authGuard]),

    // * User tab navigation (main app flow)
    AutoRoute(
      page: UserTabRoute.page,
      initial: true,
      guards: [_authGuard],
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: MyReservationsRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
  ];
}
