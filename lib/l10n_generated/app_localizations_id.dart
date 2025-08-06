// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class L10nId extends L10n {
  L10nId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Tire Installation Reservation';

  @override
  String get bottomNavHome => 'Home';

  @override
  String get bottomNavReservations => 'Reservations';

  @override
  String get bottomNavProfile => 'Profile';

  @override
  String get drawerHeaderTitle => 'Main Menu';

  @override
  String get drawerGuestUser => 'Guest User';

  @override
  String get drawerGuestLoginPrompt => 'Please login to continue';

  @override
  String get drawerItemFoods => 'Foods';

  @override
  String get drawerItemOrders => 'Orders';

  @override
  String get drawerItemLanguage => 'Language';

  @override
  String get drawerActionLogin => 'Login';

  @override
  String get drawerActionLogout => 'Logout';

  @override
  String get drawerLogoutDialogTitle => 'Logout Confirmation';

  @override
  String get drawerLogoutDialogContent => 'Are you sure you want to logout?';

  @override
  String get drawerActionCancel => 'Cancel';

  @override
  String get dialogTitleSelectLanguage => 'Select Language';
}
