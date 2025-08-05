// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get bottomNavHome => 'ホーム';

  @override
  String get bottomNavReservations => '予約';

  @override
  String get bottomNavProfile => 'プロフィール';

  @override
  String get drawerHeaderTitle => 'メインメニュー';

  @override
  String get drawerGuestUser => 'ゲストユーザー';

  @override
  String get drawerGuestLoginPrompt => '続行するにはログインしてください';

  @override
  String get drawerItemFoods => '食品';

  @override
  String get drawerItemOrders => '注文';

  @override
  String get drawerItemLanguage => '言語';

  @override
  String get drawerActionLogin => 'ログイン';

  @override
  String get drawerActionLogout => 'ログアウト';

  @override
  String get drawerLogoutDialogTitle => 'ログアウトの確認';

  @override
  String get drawerLogoutDialogContent => '本当にログアウトしますか？';

  @override
  String get drawerActionCancel => 'キャンセル';

  @override
  String get dialogTitleSelectLanguage => '言語を選択';
}
