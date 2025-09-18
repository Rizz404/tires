// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AdminDashboardScreen]
class AdminDashboardRoute extends PageRouteInfo<void> {
  const AdminDashboardRoute({List<PageRouteInfo>? children})
    : super(AdminDashboardRoute.name, initialChildren: children);

  static const String name = 'AdminDashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminDashboardScreen();
    },
  );
}

/// generated route for
/// [AdminEditBusinessInformationScreen]
class AdminEditBusinessInformationRoute
    extends PageRouteInfo<AdminEditBusinessInformationRouteArgs> {
  AdminEditBusinessInformationRoute({
    Key? key,
    required BusinessInformation businessInformation,
    List<PageRouteInfo>? children,
  }) : super(
         AdminEditBusinessInformationRoute.name,
         args: AdminEditBusinessInformationRouteArgs(
           key: key,
           businessInformation: businessInformation,
         ),
         initialChildren: children,
       );

  static const String name = 'AdminEditBusinessInformationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AdminEditBusinessInformationRouteArgs>();
      return AdminEditBusinessInformationScreen(
        key: args.key,
        businessInformation: args.businessInformation,
      );
    },
  );
}

class AdminEditBusinessInformationRouteArgs {
  const AdminEditBusinessInformationRouteArgs({
    this.key,
    required this.businessInformation,
  });

  final Key? key;

  final BusinessInformation businessInformation;

  @override
  String toString() {
    return 'AdminEditBusinessInformationRouteArgs{key: $key, businessInformation: $businessInformation}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AdminEditBusinessInformationRouteArgs) return false;
    return key == other.key && businessInformation == other.businessInformation;
  }

  @override
  int get hashCode => key.hashCode ^ businessInformation.hashCode;
}

/// generated route for
/// [AdminListAnnouncementScreen]
class AdminListAnnouncementRoute extends PageRouteInfo<void> {
  const AdminListAnnouncementRoute({List<PageRouteInfo>? children})
    : super(AdminListAnnouncementRoute.name, initialChildren: children);

  static const String name = 'AdminListAnnouncementRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminListAnnouncementScreen();
    },
  );
}

/// generated route for
/// [AdminListAvailabilityScreen]
class AdminListAvailabilityRoute extends PageRouteInfo<void> {
  const AdminListAvailabilityRoute({List<PageRouteInfo>? children})
    : super(AdminListAvailabilityRoute.name, initialChildren: children);

  static const String name = 'AdminListAvailabilityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminListAvailabilityScreen();
    },
  );
}

/// generated route for
/// [AdminListBlockedPeriodScreen]
class AdminListBlockedPeriodRoute extends PageRouteInfo<void> {
  const AdminListBlockedPeriodRoute({List<PageRouteInfo>? children})
    : super(AdminListBlockedPeriodRoute.name, initialChildren: children);

  static const String name = 'AdminListBlockedPeriodRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminListBlockedPeriodScreen();
    },
  );
}

/// generated route for
/// [AdminListBusinessInformationScreen]
class AdminListBusinessInformationRoute extends PageRouteInfo<void> {
  const AdminListBusinessInformationRoute({List<PageRouteInfo>? children})
    : super(AdminListBusinessInformationRoute.name, initialChildren: children);

  static const String name = 'AdminListBusinessInformationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminListBusinessInformationScreen();
    },
  );
}

/// generated route for
/// [AdminListCalendarScreen]
class AdminListCalendarRoute extends PageRouteInfo<void> {
  const AdminListCalendarRoute({List<PageRouteInfo>? children})
    : super(AdminListCalendarRoute.name, initialChildren: children);

  static const String name = 'AdminListCalendarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminListCalendarScreen();
    },
  );
}

/// generated route for
/// [AdminListContactScreen]
class AdminListContactRoute extends PageRouteInfo<void> {
  const AdminListContactRoute({List<PageRouteInfo>? children})
    : super(AdminListContactRoute.name, initialChildren: children);

  static const String name = 'AdminListContactRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminListContactScreen();
    },
  );
}

/// generated route for
/// [AdminListCustomerManagementScreen]
class AdminListCustomerManagementRoute extends PageRouteInfo<void> {
  const AdminListCustomerManagementRoute({List<PageRouteInfo>? children})
    : super(AdminListCustomerManagementRoute.name, initialChildren: children);

  static const String name = 'AdminListCustomerManagementRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminListCustomerManagementScreen();
    },
  );
}

/// generated route for
/// [AdminListMenuScreen]
class AdminListMenuRoute extends PageRouteInfo<void> {
  const AdminListMenuRoute({List<PageRouteInfo>? children})
    : super(AdminListMenuRoute.name, initialChildren: children);

  static const String name = 'AdminListMenuRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminListMenuScreen();
    },
  );
}

/// generated route for
/// [AdminTabScreen]
class AdminTabRoute extends PageRouteInfo<void> {
  const AdminTabRoute({List<PageRouteInfo>? children})
    : super(AdminTabRoute.name, initialChildren: children);

  static const String name = 'AdminTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminTabScreen();
    },
  );
}

/// generated route for
/// [AdminUpsertAnnouncementScreen]
class AdminUpsertAnnouncementRoute
    extends PageRouteInfo<AdminUpsertAnnouncementRouteArgs> {
  AdminUpsertAnnouncementRoute({
    Key? key,
    Announcement? announcement,
    List<PageRouteInfo>? children,
  }) : super(
         AdminUpsertAnnouncementRoute.name,
         args: AdminUpsertAnnouncementRouteArgs(
           key: key,
           announcement: announcement,
         ),
         initialChildren: children,
       );

  static const String name = 'AdminUpsertAnnouncementRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AdminUpsertAnnouncementRouteArgs>(
        orElse: () => const AdminUpsertAnnouncementRouteArgs(),
      );
      return AdminUpsertAnnouncementScreen(
        key: args.key,
        announcement: args.announcement,
      );
    },
  );
}

class AdminUpsertAnnouncementRouteArgs {
  const AdminUpsertAnnouncementRouteArgs({this.key, this.announcement});

  final Key? key;

  final Announcement? announcement;

  @override
  String toString() {
    return 'AdminUpsertAnnouncementRouteArgs{key: $key, announcement: $announcement}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AdminUpsertAnnouncementRouteArgs) return false;
    return key == other.key && announcement == other.announcement;
  }

  @override
  int get hashCode => key.hashCode ^ announcement.hashCode;
}

/// generated route for
/// [AdminUpsertBlockedPeriodScreen]
class AdminUpsertBlockedPeriodRoute
    extends PageRouteInfo<AdminUpsertBlockedPeriodRouteArgs> {
  AdminUpsertBlockedPeriodRoute({
    Key? key,
    BlockedPeriod? blockedPeriod,
    List<PageRouteInfo>? children,
  }) : super(
         AdminUpsertBlockedPeriodRoute.name,
         args: AdminUpsertBlockedPeriodRouteArgs(
           key: key,
           blockedPeriod: blockedPeriod,
         ),
         initialChildren: children,
       );

  static const String name = 'AdminUpsertBlockedPeriodRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AdminUpsertBlockedPeriodRouteArgs>(
        orElse: () => const AdminUpsertBlockedPeriodRouteArgs(),
      );
      return AdminUpsertBlockedPeriodScreen(
        key: args.key,
        blockedPeriod: args.blockedPeriod,
      );
    },
  );
}

class AdminUpsertBlockedPeriodRouteArgs {
  const AdminUpsertBlockedPeriodRouteArgs({this.key, this.blockedPeriod});

  final Key? key;

  final BlockedPeriod? blockedPeriod;

  @override
  String toString() {
    return 'AdminUpsertBlockedPeriodRouteArgs{key: $key, blockedPeriod: $blockedPeriod}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AdminUpsertBlockedPeriodRouteArgs) return false;
    return key == other.key && blockedPeriod == other.blockedPeriod;
  }

  @override
  int get hashCode => key.hashCode ^ blockedPeriod.hashCode;
}

/// generated route for
/// [AdminUpsertCalendarScreen]
class AdminUpsertCalendarRoute extends PageRouteInfo<void> {
  const AdminUpsertCalendarRoute({List<PageRouteInfo>? children})
    : super(AdminUpsertCalendarRoute.name, initialChildren: children);

  static const String name = 'AdminUpsertCalendarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminUpsertCalendarScreen();
    },
  );
}

/// generated route for
/// [AdminUpsertContactScreen]
class AdminUpsertContactRoute
    extends PageRouteInfo<AdminUpsertContactRouteArgs> {
  AdminUpsertContactRoute({
    Key? key,
    Contact? contact,
    List<PageRouteInfo>? children,
  }) : super(
         AdminUpsertContactRoute.name,
         args: AdminUpsertContactRouteArgs(key: key, contact: contact),
         initialChildren: children,
       );

  static const String name = 'AdminUpsertContactRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AdminUpsertContactRouteArgs>(
        orElse: () => const AdminUpsertContactRouteArgs(),
      );
      return AdminUpsertContactScreen(key: args.key, contact: args.contact);
    },
  );
}

class AdminUpsertContactRouteArgs {
  const AdminUpsertContactRouteArgs({this.key, this.contact});

  final Key? key;

  final Contact? contact;

  @override
  String toString() {
    return 'AdminUpsertContactRouteArgs{key: $key, contact: $contact}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AdminUpsertContactRouteArgs) return false;
    return key == other.key && contact == other.contact;
  }

  @override
  int get hashCode => key.hashCode ^ contact.hashCode;
}

/// generated route for
/// [AdminUpsertCustomerManagementScreen]
class AdminUpsertCustomerManagementRoute extends PageRouteInfo<void> {
  const AdminUpsertCustomerManagementRoute({List<PageRouteInfo>? children})
    : super(AdminUpsertCustomerManagementRoute.name, initialChildren: children);

  static const String name = 'AdminUpsertCustomerManagementRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminUpsertCustomerManagementScreen();
    },
  );
}

/// generated route for
/// [AdminUpsertMenuScreen]
class AdminUpsertMenuRoute extends PageRouteInfo<AdminUpsertMenuRouteArgs> {
  AdminUpsertMenuRoute({Key? key, Menu? menu, List<PageRouteInfo>? children})
    : super(
        AdminUpsertMenuRoute.name,
        args: AdminUpsertMenuRouteArgs(key: key, menu: menu),
        initialChildren: children,
      );

  static const String name = 'AdminUpsertMenuRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AdminUpsertMenuRouteArgs>(
        orElse: () => const AdminUpsertMenuRouteArgs(),
      );
      return AdminUpsertMenuScreen(key: args.key, menu: args.menu);
    },
  );
}

class AdminUpsertMenuRouteArgs {
  const AdminUpsertMenuRouteArgs({this.key, this.menu});

  final Key? key;

  final Menu? menu;

  @override
  String toString() {
    return 'AdminUpsertMenuRouteArgs{key: $key, menu: $menu}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AdminUpsertMenuRouteArgs) return false;
    return key == other.key && menu == other.menu;
  }

  @override
  int get hashCode => key.hashCode ^ menu.hashCode;
}

/// generated route for
/// [ConfirmReservationScreen]
class ConfirmReservationRoute extends PageRouteInfo<void> {
  const ConfirmReservationRoute({List<PageRouteInfo>? children})
    : super(ConfirmReservationRoute.name, initialChildren: children);

  static const String name = 'ConfirmReservationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ConfirmReservationScreen();
    },
  );
}

/// generated route for
/// [ConfirmedReservationScreen]
class ConfirmedReservationRoute extends PageRouteInfo<void> {
  const ConfirmedReservationRoute({List<PageRouteInfo>? children})
    : super(ConfirmedReservationRoute.name, initialChildren: children);

  static const String name = 'ConfirmedReservationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ConfirmedReservationScreen();
    },
  );
}

/// generated route for
/// [CreateReservationScreen]
class CreateReservationRoute extends PageRouteInfo<CreateReservationRouteArgs> {
  CreateReservationRoute({
    Key? key,
    required Menu menu,
    List<PageRouteInfo>? children,
  }) : super(
         CreateReservationRoute.name,
         args: CreateReservationRouteArgs(key: key, menu: menu),
         initialChildren: children,
       );

  static const String name = 'CreateReservationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateReservationRouteArgs>();
      return CreateReservationScreen(key: args.key, menu: args.menu);
    },
  );
}

class CreateReservationRouteArgs {
  const CreateReservationRouteArgs({this.key, required this.menu});

  final Key? key;

  final Menu menu;

  @override
  String toString() {
    return 'CreateReservationRouteArgs{key: $key, menu: $menu}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateReservationRouteArgs) return false;
    return key == other.key && menu == other.menu;
  }

  @override
  int get hashCode => key.hashCode ^ menu.hashCode;
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [InquiryScreen]
class InquiryRoute extends PageRouteInfo<void> {
  const InquiryRoute({List<PageRouteInfo>? children})
    : super(InquiryRoute.name, initialChildren: children);

  static const String name = 'InquiryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InquiryScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MyReservationsScreen]
class MyReservationsRoute extends PageRouteInfo<void> {
  const MyReservationsRoute({List<PageRouteInfo>? children})
    : super(MyReservationsRoute.name, initialChildren: children);

  static const String name = 'MyReservationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MyReservationsScreen();
    },
  );
}

/// generated route for
/// [PrivacyPolicyScreen]
class PrivacyPolicyRoute extends PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PrivacyPolicyScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}

/// generated route for
/// [ReservationSummaryScreen]
class ReservationSummaryRoute extends PageRouteInfo<void> {
  const ReservationSummaryRoute({List<PageRouteInfo>? children})
    : super(ReservationSummaryRoute.name, initialChildren: children);

  static const String name = 'ReservationSummaryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReservationSummaryScreen();
    },
  );
}

/// generated route for
/// [SetNewPasswordScreen]
class SetNewPasswordRoute extends PageRouteInfo<void> {
  const SetNewPasswordRoute({List<PageRouteInfo>? children})
    : super(SetNewPasswordRoute.name, initialChildren: children);

  static const String name = 'SetNewPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SetNewPasswordScreen();
    },
  );
}

/// generated route for
/// [TermsOfServiceScreen]
class TermsOfServiceRoute extends PageRouteInfo<void> {
  const TermsOfServiceRoute({List<PageRouteInfo>? children})
    : super(TermsOfServiceRoute.name, initialChildren: children);

  static const String name = 'TermsOfServiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TermsOfServiceScreen();
    },
  );
}

/// generated route for
/// [UserTabScreen]
class UserTabRoute extends PageRouteInfo<void> {
  const UserTabRoute({List<PageRouteInfo>? children})
    : super(UserTabRoute.name, initialChildren: children);

  static const String name = 'UserTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserTabScreen();
    },
  );
}
