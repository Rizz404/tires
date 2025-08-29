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
  String get adminListCustomerManagementTitle => '顧客管理';

  @override
  String get adminListCustomerManagementDescription => '顧客データと予約履歴を管理します。';

  @override
  String get adminListCustomerManagementStatsFirstTime => '新規顧客';

  @override
  String get adminListCustomerManagementStatsRepeat => 'リピーター';

  @override
  String get adminListCustomerManagementStatsDormant => '休眠顧客';

  @override
  String get adminListCustomerManagementFiltersSearchPlaceholder =>
      '名前、メールアドレス、電話番号で検索...';

  @override
  String get adminListCustomerManagementFiltersAllTypes => 'すべての顧客タイプ';

  @override
  String get adminListCustomerManagementFiltersFirstTime => '新規顧客';

  @override
  String get adminListCustomerManagementFiltersRepeat => 'リピート顧客';

  @override
  String get adminListCustomerManagementFiltersDormant => '休眠顧客';

  @override
  String get adminListCustomerManagementFiltersReset => 'リセット';

  @override
  String get adminListCustomerManagementTableHeaderCustomer => '顧客';

  @override
  String get adminListCustomerManagementTableHeaderContactInfo => '連絡先情報';

  @override
  String get adminListCustomerManagementTableHeaderStatus => 'ステータス';

  @override
  String get adminListCustomerManagementTableHeaderReservations => '予約';

  @override
  String get adminListCustomerManagementTableHeaderTotalAmount => '合計金額';

  @override
  String get adminListCustomerManagementTableHeaderLastReservation => '最終予約';

  @override
  String get adminListCustomerManagementTableHeaderActions => '操作';

  @override
  String get adminListCustomerManagementTableStatusBadgeRegistered => '登録済み';

  @override
  String get adminListCustomerManagementTableStatusBadgeGuest => 'ゲスト';

  @override
  String get adminListCustomerManagementTableTypeBadgeFirstTime => '新規';

  @override
  String get adminListCustomerManagementTableTypeBadgeRepeat => 'リピート';

  @override
  String get adminListCustomerManagementTableTypeBadgeDormant => '休眠';

  @override
  String get adminListCustomerManagementTableReservationsCount => ':count 回';

  @override
  String get adminListCustomerManagementTableActionsTooltipViewDetails =>
      '詳細を表示';

  @override
  String get adminListCustomerManagementTableActionsTooltipSendMessage =>
      'メッセージを送信';

  @override
  String get adminListCustomerManagementTableEmptyTitle => '顧客が見つかりません';

  @override
  String get adminListCustomerManagementTableEmptyDescription =>
      '登録されている、または選択されたフィルターに一致する顧客がいません。';

  @override
  String get adminListCustomerManagementPaginationPrevious => '前へ';

  @override
  String get adminListCustomerManagementPaginationNext => '次へ';

  @override
  String get adminListCustomerManagementModalTitle => 'メッセージを送信';

  @override
  String get adminListCustomerManagementModalSubject => '件名';

  @override
  String get adminListCustomerManagementModalSubjectPlaceholder =>
      '件名を入力してください';

  @override
  String get adminListCustomerManagementModalMessage => 'メッセージ';

  @override
  String get adminListCustomerManagementModalMessagePlaceholder =>
      'メッセージ本文を入力してください';

  @override
  String get adminListCustomerManagementModalCancel => 'キャンセル';

  @override
  String get adminListCustomerManagementModalSend => '送信';

  @override
  String get adminListCustomerManagementAlertsValidationError =>
      '件名とメッセージの両方を入力してください';

  @override
  String get adminListCustomerManagementAlertsSendSuccess =>
      'メッセージが正常に送信されました！';

  @override
  String get adminListCustomerManagementAlertsSendError => 'メッセージの送信に失敗しました';

  @override
  String get adminUpsertCustomerManagementHeaderTitle => '顧客詳細';

  @override
  String get adminUpsertCustomerManagementHeaderSubtitle => '顧客の詳細情報と履歴を表示します。';

  @override
  String get adminUpsertCustomerManagementHeaderSendMessageButton => 'メッセージを送信';

  @override
  String get adminUpsertCustomerManagementHeaderExportButton => 'エクスポート';

  @override
  String get adminUpsertCustomerManagementStatsTotalReservations => '総予約数';

  @override
  String get adminUpsertCustomerManagementStatsTotalAmount => '合計金額';

  @override
  String get adminUpsertCustomerManagementStatsTireStorage => 'タイヤ保管';

  @override
  String get adminUpsertCustomerManagementSidebarStatusRegistered => '登録済み';

  @override
  String get adminUpsertCustomerManagementSidebarStatusGuest => 'ゲスト';

  @override
  String get adminUpsertCustomerManagementSidebarEmail => 'メールアドレス';

  @override
  String get adminUpsertCustomerManagementSidebarPhone => '電話番号';

  @override
  String get adminUpsertCustomerManagementSidebarCompany => '会社名';

  @override
  String get adminUpsertCustomerManagementSidebarDepartment => '部署';

  @override
  String get adminUpsertCustomerManagementSidebarDob => '生年月日';

  @override
  String get adminUpsertCustomerManagementSidebarGender => '性別';

  @override
  String get adminUpsertCustomerManagementSidebarGuestInfoTitle => 'ゲスト顧客';

  @override
  String get adminUpsertCustomerManagementSidebarGuestInfoBody =>
      'この顧客はゲストとして予約を行いました。利用可能な情報は限られています。';

  @override
  String get adminUpsertCustomerManagementTabsCustomerInfo => '顧客情報';

  @override
  String get adminUpsertCustomerManagementTabsReservationHistory => '予約履歴';

  @override
  String get adminUpsertCustomerManagementTabsTireStorage => 'タイヤ保管';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoTitle =>
      '顧客情報';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoFullName =>
      '氏名';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoFullNameKana =>
      '氏名（カナ）';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoEmail =>
      'メールアドレス';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoPhoneNumber =>
      '電話番号';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoCompanyName =>
      '会社名';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoDepartment =>
      '部署';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoDob => '生年月日';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoGender => '性別';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoAddressesTitle =>
      '住所';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoCompanyAddress =>
      '会社住所';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoHomeAddress =>
      '自宅住所';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoGuestTitle =>
      'ゲスト顧客';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoGuestBody =>
      'この顧客はゲストとして予約を行いました。基本的な予約情報のみが利用可能です。';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestNameLabel =>
      '名前：';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestNameKanaLabel =>
      '名前（カナ）：';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestEmailLabel =>
      'メール：';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestPhoneLabel =>
      '電話：';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryTitle =>
      '予約履歴';

  @override
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryCountText =>
      '予約 :count件';

  @override
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryDateTime =>
      '日時：';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryPeople =>
      '人数：';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryMenu =>
      'メニュー：';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryAmount =>
      '金額：';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryNotes =>
      '備考：';

  @override
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryViewDetailsLink =>
      '詳細を見る';

  @override
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryNoRecords =>
      '予約履歴が見つかりません。';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageTitle =>
      'タイヤ保管';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageCountText =>
      '保管記録 :count件';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageStartDate =>
      '開始日：';

  @override
  String get adminUpsertCustomerManagementMainContentTireStoragePlannedEnd =>
      '終了予定日：';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageStorageFee =>
      '保管料：';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageDaysRemaining =>
      '残り日数：';

  @override
  String
  get adminUpsertCustomerManagementMainContentTireStorageDaysRemainingText =>
      ':days日';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageNotes => '備考：';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageNoRecords =>
      'タイヤ保管記録が見つかりません。';

  @override
  String get adminUpsertCustomerManagementModalTitle => ':name にメッセージを送信';

  @override
  String get adminUpsertCustomerManagementModalSubjectLabel => '件名';

  @override
  String get adminUpsertCustomerManagementModalSubjectPlaceholder =>
      '件名を入力してください';

  @override
  String get adminUpsertCustomerManagementModalMessageLabel => 'メッセージ';

  @override
  String get adminUpsertCustomerManagementModalMessagePlaceholder =>
      'メッセージを入力してください';

  @override
  String get adminUpsertCustomerManagementModalCancelButton => 'キャンセル';

  @override
  String get adminUpsertCustomerManagementModalSendButton => 'メッセージを送信';

  @override
  String get adminUpsertCustomerManagementJsAlertsFillFields =>
      '件名とメッセージの両方を入力してください';

  @override
  String get adminUpsertCustomerManagementJsAlertsSendSuccess =>
      'メッセージが正常に送信されました！';

  @override
  String get adminUpsertCustomerManagementJsAlertsSendFailed =>
      'メッセージの送信に失敗しました';

  @override
  String get adminUpsertCustomerManagementJsAlertsExportPlaceholder =>
      'エクスポート機能は後ほど実装されます';

  @override
  String get adminDashboardAnnouncementCloseTooltip => 'お知らせを閉じる';

  @override
  String get adminDashboardTodoTitle => 'To Do';

  @override
  String get adminDashboardTodoTodayReservations => '本日の予約';

  @override
  String get adminDashboardTodoContacts => 'お問い合わせ';

  @override
  String get adminDashboardTodoCasesUnit => '件';

  @override
  String get adminDashboardContactTitle => 'お問い合わせ';

  @override
  String get adminDashboardContactReceivedAt => '受信日時';

  @override
  String get adminDashboardContactCustomerName => '顧客名';

  @override
  String get adminDashboardContactSubject => '件名';

  @override
  String get adminDashboardContactNoPending => '未対応のお問い合わせはありません';

  @override
  String get adminDashboardContactSeeMore => 'もっと見る';

  @override
  String get adminDashboardReservationTitle => '本日の予約';

  @override
  String get adminDashboardReservationTime => '時間';

  @override
  String get adminDashboardReservationService => 'サービス';

  @override
  String get adminDashboardReservationCustomerName => '顧客名';

  @override
  String get adminDashboardReservationNoReservationsToday => '本日の予約はありません';

  @override
  String get adminDashboardStatusTitle => '予約・顧客状況（:date）';

  @override
  String get adminDashboardStatusReservations => '予約数';

  @override
  String get adminDashboardStatusNewCustomers => '新規顧客数';

  @override
  String get adminDashboardStatusCasesUnit => '件';

  @override
  String get adminDashboardJavascriptConfirmCloseAnnouncement =>
      'このお知らせを閉じてもよろしいですか？';

  @override
  String get adminDashboardJavascriptDeactivationError =>
      'お知らせの非表示中にエラーが発生しました。';

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
  String get profileLabelCompany => '会社名';

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
  String get profileButtonUpdateProfile => 'プロフィールを更新';

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
  String confirmReservationWelcomeBack(String name) {
    return '$nameさん、ようこそ！';
  }

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
  String get myReservationPageTitle => 'マイ予約';

  @override
  String get myReservationSubtitle => 'すべての予約をこのページで管理・確認できます';

  @override
  String get myReservationTotalReservations => '予約総数';

  @override
  String get myReservationPending => '保留中';

  @override
  String get myReservationConfirmed => '確定済み';

  @override
  String get myReservationNewReservation => '新規予約';

  @override
  String get myReservationRequiredTime => ':time 分';

  @override
  String get myReservationDate => '日付';

  @override
  String get myReservationTime => '時間';

  @override
  String get myReservationPeopleLabel => '人数';

  @override
  String get myReservationPeopleCount => ':count 名';

  @override
  String get myReservationNotes => '備考:';

  @override
  String get myReservationCancelButton => 'キャンセル';

  @override
  String get myReservationNoReservationsTitle => '現在、予約はありません';

  @override
  String get myReservationNoReservationsBody =>
      'まだ予約がありません。まずは初めての予約を作成して、当店のサービスをご利用ください。';

  @override
  String get myReservationCreateFirstReservation => '最初の予約を作成する';

  @override
  String get myReservationModalCancelTitle => '予約をキャンセル';

  @override
  String get myReservationModalCancelBody =>
      'この予約をキャンセルしてもよろしいですか？この操作は元に戻せません。';

  @override
  String get myReservationModalKeepButton => '予約を維持';

  @override
  String get myReservationModalConfirmCancelButton => 'はい、キャンセルします';

  @override
  String get myReservationModalFeatureSoonTitle => '機能は近日公開予定';

  @override
  String get myReservationModalFeatureSoonBody => '予約キャンセル機能は近日中に実装される予定です。';

  @override
  String get myReservationModalGotItButton => '了解しました';

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
