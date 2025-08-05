import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/routes/auth_guard.dart';
import 'package:tires/core/routes/duplicate_guard.dart';
import 'package:tires/features/authentication/presentation/screens/login_screen.dart';
import 'package:tires/features/authentication/presentation/screens/register_screen.dart';
import 'package:tires/features/home/presentation/screens/home_screen.dart';
import 'package:tires/features/profile/presentation/screens/profile_screen.dart';
import 'package:tires/features/reservation/presentation/screens/list_reservation_screen.dart';
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
    AutoRoute(
      page: UserTabRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ListReservationRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),

    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
