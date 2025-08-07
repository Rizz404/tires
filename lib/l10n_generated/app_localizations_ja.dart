// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get registerBrandName => 'RESERVATION ID';

  @override
  String get registerTitle => 'アカウントを作成する';

  @override
  String get registerLabelFullName => '氏名（必須）';

  @override
  String get registerLabelFullNameKana => '氏名（カナ）（必須）';

  @override
  String get registerLabelEmail => 'メールアドレス（必須）';

  @override
  String get registerLabelPhoneNumber => '電話番号（必須）';

  @override
  String get registerLabelCompanyName => '会社名';

  @override
  String get registerLabelDepartment => '部署名';

  @override
  String get registerLabelCompanyAddress => '会社住所';

  @override
  String get registerLabelHomeAddress => '自宅住所';

  @override
  String get registerLabelDateOfBirth => '生年月日';

  @override
  String get registerLabelGender => '性別';

  @override
  String get registerLabelPassword => 'パスワード（必須）';

  @override
  String get registerLabelConfirmPassword => 'パスワードの確認（必須）';

  @override
  String get registerPlaceholderFullName => '例：John Doe（ジョン・ドウ）';

  @override
  String get registerPlaceholderFullNameKana => '例：ジョン ドウ';

  @override
  String get registerPlaceholderEmail => 'example@reservation.be';

  @override
  String get registerPlaceholderPhoneNumber => '例：08012345678';

  @override
  String get registerPlaceholderCompanyName => '例：Acme株式会社';

  @override
  String get registerPlaceholderDepartment => '例：営業部';

  @override
  String get registerPlaceholderCompanyAddress => '会社の住所を入力してください';

  @override
  String get registerPlaceholderHomeAddress => '自宅の住所を入力してください';

  @override
  String get registerPlaceholderPassword => '※8文字以上';

  @override
  String get registerPlaceholderConfirmPassword => '確認のためもう一度入力してください';

  @override
  String get registerGenderSelect => '性別を選択してください';

  @override
  String get registerGenderMale => '男性';

  @override
  String get registerGenderFemale => '女性';

  @override
  String get registerGenderOther => 'その他';

  @override
  String get registerButton => '登録する';

  @override
  String get registerAlreadyHaveAccount => 'すでにRESERVATIONアカウントをお持ちですか？';

  @override
  String get registerSignInLink => 'こちらからサインイン';

  @override
  String get registerTermsAgreement =>
      '※登録することで、[利用規約] および [プライバシーポリシー] に同意したものとみなされます。';

  @override
  String get registerTermsOfServiceLink => '利用規約';

  @override
  String get registerPrivacyPolicyLink => 'プライバシーポリシー';

  @override
  String get registerContactUsLink => 'お問い合わせ';

  @override
  String get registerCopyright => '© RESERVATION';

  @override
  String get loginTitle => 'RESERVATION ID';

  @override
  String get loginEmailLabel => 'メールアドレス（必須）';

  @override
  String get loginEmailPlaceholder => 'example@reservation.be';

  @override
  String get loginPasswordLabel => 'パスワード（必須）';

  @override
  String get loginPasswordPlaceholder => '••••••••';

  @override
  String get loginRememberMe => '次回から自動ログイン（ログイン情報を記憶する）';

  @override
  String get loginForgotPassword => 'パスワードをお忘れですか？';

  @override
  String get loginButton => 'ログイン';

  @override
  String get loginNoAccountPrompt => 'RESERVATIONアカウントをお持ちでない方へ';

  @override
  String get loginSignupLink => '今すぐ会員登録する';

  @override
  String get inquirySidebarLocation => '所在地';

  @override
  String get inquirySidebarOpeningHours => '営業時間';

  @override
  String get inquirySidebarClosed => '休業日';

  @override
  String get inquirySidebarAboutUs => '会社概要';

  @override
  String get inquirySidebarTermsOfUse => '利用規約';

  @override
  String get inquiryDayMonday => '月曜';

  @override
  String get inquiryDayTuesday => '火曜';

  @override
  String get inquiryDayWednesday => '水曜';

  @override
  String get inquiryDayThursday => '木曜';

  @override
  String get inquiryDayFriday => '金曜';

  @override
  String get inquiryDaySaturday => '土曜';

  @override
  String get inquiryDaySunday => '日曜';

  @override
  String get inquiryFormTitle => 'お名前（必須）';

  @override
  String get inquiryFormName => 'お名前 *';

  @override
  String get inquiryFormEmail => 'メールアドレス（必須）';

  @override
  String get inquiryFormPhone => '電話番号';

  @override
  String get inquiryFormSubject => '件名（必須）';

  @override
  String get inquiryFormInquiryContent => 'お問い合わせ内容（必須）';

  @override
  String get inquiryFormSubmitButton => 'お問い合わせを送信する';

  @override
  String get inquiryPlaceholderName => '東京 太郎';

  @override
  String get inquiryPlaceholderEmail => 'your@email.com';

  @override
  String get inquiryPlaceholderPhone => '00-0000-0000';

  @override
  String get inquiryPlaceholderMessage => 'お問い合わせ内容をご入力ください';

  @override
  String get inquirySuccessMessage => 'お問い合わせが正常に送信されました！';

  @override
  String get inquiryErrorMessage => 'お問い合わせの送信中にエラーが発生しました。後でもう一度お試しください。';

  @override
  String get profileShowTitle => 'マイプロフィール';

  @override
  String get profileEditTitle => 'プロフィール編集';

  @override
  String get profileSuccessMessage => 'プロフィールは正常に更新されました！';

  @override
  String get profilePersonalInfoTitle => '個人情報';

  @override
  String get profileLabelFullName => '氏名';

  @override
  String get profileLabelFullNameKana => '氏名 (フリガナ)';

  @override
  String get profileLabelEmail => 'メールアドレス';

  @override
  String get profileLabelPhone => '電話番号';

  @override
  String get profileLabelDob => '生年月日';

  @override
  String get profileLabelAddress => '住所';

  @override
  String get profileChangePasswordTitle => 'パスワードの変更';

  @override
  String get profileLabelCurrentPassword => '現在のパスワード';

  @override
  String get profileLabelNewPassword => '新しいパスワード';

  @override
  String get profileLabelConfirmPassword => '新しいパスワード（確認）';

  @override
  String get profileButtonEdit => 'プロフィールを編集';

  @override
  String get profileButtonChangePassword => 'パスワードを変更する';

  @override
  String get profileButtonCancel => 'キャンセル';

  @override
  String get profileButtonSaveChanges => '変更を保存';

  @override
  String get appName => 'タイヤ取付予約';

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
