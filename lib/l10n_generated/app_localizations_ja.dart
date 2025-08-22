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
  String get forgotPasswordTitle => 'パスワードをお忘れですか？';

  @override
  String get forgotPasswordSubtitle =>
      'ご心配なく！メールアドレスを入力していただければ、リセット用のリンクをお送りします。';

  @override
  String get forgotPasswordEmailLabel => 'メールアドレス';

  @override
  String get forgotPasswordEmailPlaceholder => 'メールアドレスを入力してください';

  @override
  String get forgotPasswordButton => 'リセットリンクを送信';

  @override
  String get forgotPasswordSuccessMessage =>
      'パスワードリセット用のリンクが記載されたメールを送信しました。受信トレイをご確認ください。';

  @override
  String get forgotPasswordFormError => 'フォームのエラーを修正してください。';

  @override
  String get forgotPasswordRemembered => 'パスワードを思い出しましたか？';

  @override
  String get forgotPasswordBackToLogin => 'ログインに戻る';

  @override
  String get homePrimaryTitle => '私たちのサービス';

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
  String get createReservationNotesTitle => '予約に関する注意事項';

  @override
  String get createReservationNotesContent1 => '作業時間はあくまで目安です';

  @override
  String get createReservationNotesContent2 => '作業内容によっては時間がかかる場合があります';

  @override
  String get createReservationNotesContent3 => '予約の締め切り：前日の23:59まで';

  @override
  String get createReservationNotesContent4 => '確認後のキャンセルはできません';

  @override
  String get confirmReservationBannerTitle => '予約情報の確認';

  @override
  String get confirmReservationBannerSubtitle => '予約手続きの進め方を選択してください。';

  @override
  String get confirmReservationWelcomeBack => 'Rizzさん、ようこそ！';

  @override
  String get confirmReservationLoggedInAs => 'RESERVA会員としてログインしています。';

  @override
  String get confirmReservationInfoUsageWarning => 'この予約にはあなたの会員情報が使用されます。';

  @override
  String get confirmReservationContinueButton => 'このアカウントで続ける';

  @override
  String get reservationSummaryBannerTitle => '最終確認';

  @override
  String get reservationSummaryBannerSubtitle => '予約を完了する前に、詳細をよくご確認ください。';

  @override
  String get reservationSummaryServiceDetailsTitle => 'サービス詳細';

  @override
  String get reservationSummaryCustomerInfoTitle => 'お客様情報';

  @override
  String get reservationSummaryLabelService => 'サービス';

  @override
  String get reservationSummaryLabelDuration => '所要時間';

  @override
  String get reservationSummaryLabelDate => '日付';

  @override
  String get reservationSummaryLabelTime => '時間';

  @override
  String get reservationSummaryLabelName => '氏名';

  @override
  String get reservationSummaryLabelNameKana => '氏名 (カナ)';

  @override
  String get reservationSummaryLabelEmail => 'メールアドレス';

  @override
  String get reservationSummaryLabelPhone => '電話番号';

  @override
  String get reservationSummaryLabelStatus => 'ステータス';

  @override
  String get reservationSummaryNotesTitle => '重要事項';

  @override
  String get reservationSummaryNotesContent1 => '予約時間の5分前までにお越しください。';

  @override
  String get reservationSummaryNotesContent2 => '確定後のキャンセルはできません。';

  @override
  String get reservationSummaryNotesContent3 => '予約の変更は、少なくとも24時間前までにお願いします。';

  @override
  String get reservationSummaryNotesContent4 =>
      '必要に応じて、本人確認のため有効な身分証明書をご持参ください。';

  @override
  String get reservationSummaryTermsAndCondition => '利用規約に同意します ';

  @override
  String get reservationSummaryPrivacyPolicy => 'そしてプライバシーポリシー';

  @override
  String get confirmedReservationBannerTitle => '予約が確定しました！';

  @override
  String get confirmedReservationBannerSubtitle => 'ご予約が正常に送信されました。';

  @override
  String get confirmedReservationYourReservationNumber => 'あなたの予約番号';

  @override
  String get confirmedReservationWhatsNextTitle => '次のステップ';

  @override
  String get confirmedReservationWhatsNext1 => '確認メールがあなたのメールアドレスに送信されました。';

  @override
  String get confirmedReservationWhatsNext2 => '予約時間の5分前にはお越しください。';

  @override
  String get confirmedReservationWhatsNext3 => '本人確認のため、有効な身分証明書をご持参ください。';

  @override
  String get confirmedReservationWhatsNext4 => '変更が必要な場合は、お問い合わせください。';

  @override
  String get confirmedReservationViewMyReservationsButton => '予約一覧を見る';

  @override
  String get confirmedReservationBackToHomeButton => 'ホームに戻る';

  @override
  String get menuBookButton => '予約する';

  @override
  String get menuUnavailableStatus => '現在利用不可';

  @override
  String get timeHour => '時間';

  @override
  String get timeHours => '時間';

  @override
  String get timeMinute => '分';

  @override
  String get timeMinutes => '分';

  @override
  String get reservationStatusConfirmed => '確定済み';

  @override
  String get reservationStatusPending => '保留中';

  @override
  String get reservationStatusCompleted => '完了';

  @override
  String get reservationStatusCancelled => 'キャンセル済み';

  @override
  String get reservationItemLabelDate => '日付';

  @override
  String get reservationItemLabelTime => '時間';

  @override
  String get reservationItemLabelPeople => '人数';

  @override
  String get reservationItemLabelNotes => '備考';

  @override
  String get reservationItemPeopleUnit => '名';

  @override
  String get reservationItemCancelButton => '予約をキャンセル';

  @override
  String get dateToday => '今日';

  @override
  String get dateTomorrow => '明日';

  @override
  String get myReservationMainTitle => 'マイ予約';

  @override
  String get myReservationMainSubTitle => 'すべての予約を一か所で管理・確認できます。';

  @override
  String get appName => 'タイヤ取付予約';

  @override
  String get appBarCalendar => 'カレンダー';

  @override
  String get appBarInquiry => 'お問い合わせ';

  @override
  String get appBarLogin => 'ログイン';

  @override
  String get appBarReservations => '予約';

  @override
  String get appBarProfile => 'プロフィール';

  @override
  String get appBarLogout => 'ログアウト';

  @override
  String get appBarHome => 'ホーム';

  @override
  String get appBarCreateReservation => '予約作成';

  @override
  String get appBarConfirmReservation => '予約確認';

  @override
  String get appBarConfirmedReservation => '予約確定';

  @override
  String get appBarMyReservations => 'マイ予約';

  @override
  String get appBarReservationSummary => '予約概要';

  @override
  String get appBarRegister => '登録';

  @override
  String get userBottomNavHome => 'ホーム';

  @override
  String get userBottomNavReservations => '予約';

  @override
  String get userBottomNavProfile => 'プロフィール';

  @override
  String get drawerHeaderTitle => 'メインメニュー';

  @override
  String get adminDrawerHeaderTitle => '管理者メニュー';

  @override
  String get drawerGuestUser => 'ゲストユーザー';

  @override
  String get drawerGuestLoginPrompt => '続行するにはログインしてください';

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
  String get drawerItemInquiry => 'お問い合わせ';

  @override
  String get dialogTitleSelectLanguage => '言語を選択';

  @override
  String get adminBottomNavDashboard => 'ダッシュボード';

  @override
  String get adminBottomNavCalendar => 'カレンダー';

  @override
  String get adminBottomNavAnnouncements => 'お知らせ';

  @override
  String get adminDrawerItemAvailability => '空き状況管理';

  @override
  String get adminDrawerItemBlocked => 'ブロック管理';

  @override
  String get adminDrawerItemBusinessInformation => 'ビジネス情報';

  @override
  String get adminDrawerItemContact => '連絡先管理';

  @override
  String get adminDrawerItemCustomerManagement => '顧客管理';

  @override
  String get adminDrawerItemMenu => 'メニュー管理';

  @override
  String get pressAgainToExit => 'もう一度押すと終了します';
}
