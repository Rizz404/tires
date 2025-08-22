import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n_generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
    Locale('ja'),
  ];

  /// No description provided for @registerBrandName.
  ///
  /// In en, this message translates to:
  /// **'RESERVATION ID'**
  String get registerBrandName;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get registerTitle;

  /// No description provided for @registerLabelFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get registerLabelFullName;

  /// No description provided for @registerLabelFullNameKana.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Kana)'**
  String get registerLabelFullNameKana;

  /// No description provided for @registerLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get registerLabelEmail;

  /// No description provided for @registerLabelPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get registerLabelPhoneNumber;

  /// No description provided for @registerLabelCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get registerLabelCompanyName;

  /// No description provided for @registerLabelDepartment.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get registerLabelDepartment;

  /// No description provided for @registerLabelCompanyAddress.
  ///
  /// In en, this message translates to:
  /// **'Company Address'**
  String get registerLabelCompanyAddress;

  /// No description provided for @registerLabelHomeAddress.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get registerLabelHomeAddress;

  /// No description provided for @registerLabelDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get registerLabelDateOfBirth;

  /// No description provided for @registerLabelGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get registerLabelGender;

  /// No description provided for @registerLabelPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registerLabelPassword;

  /// No description provided for @registerLabelConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registerLabelConfirmPassword;

  /// No description provided for @registerPlaceholderFullName.
  ///
  /// In en, this message translates to:
  /// **'e.g., John Doe'**
  String get registerPlaceholderFullName;

  /// No description provided for @registerPlaceholderFullNameKana.
  ///
  /// In en, this message translates to:
  /// **'e.g., JOHN DOE'**
  String get registerPlaceholderFullNameKana;

  /// No description provided for @registerPlaceholderEmail.
  ///
  /// In en, this message translates to:
  /// **'example@reservation.be'**
  String get registerPlaceholderEmail;

  /// No description provided for @registerPlaceholderPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'e.g., 08012345678'**
  String get registerPlaceholderPhoneNumber;

  /// No description provided for @registerPlaceholderCompanyName.
  ///
  /// In en, this message translates to:
  /// **'e.g., Acme Corporation'**
  String get registerPlaceholderCompanyName;

  /// No description provided for @registerPlaceholderDepartment.
  ///
  /// In en, this message translates to:
  /// **'e.g., Sales'**
  String get registerPlaceholderDepartment;

  /// No description provided for @registerPlaceholderCompanyAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter company address'**
  String get registerPlaceholderCompanyAddress;

  /// No description provided for @registerPlaceholderHomeAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter home address'**
  String get registerPlaceholderHomeAddress;

  /// No description provided for @registerPlaceholderPassword.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get registerPlaceholderPassword;

  /// No description provided for @registerPlaceholderConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get registerPlaceholderConfirmPassword;

  /// No description provided for @registerGenderSelect.
  ///
  /// In en, this message translates to:
  /// **'Select gender'**
  String get registerGenderSelect;

  /// No description provided for @registerGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get registerGenderMale;

  /// No description provided for @registerGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get registerGenderFemale;

  /// No description provided for @registerGenderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get registerGenderOther;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @registerAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have a RESERVATION account?'**
  String get registerAlreadyHaveAccount;

  /// No description provided for @registerSignInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in here'**
  String get registerSignInLink;

  /// No description provided for @registerTermsAgreement.
  ///
  /// In en, this message translates to:
  /// **'By registering, you agree to our terms of service and privacy policy.'**
  String get registerTermsAgreement;

  /// No description provided for @registerTermsOfServiceLink.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get registerTermsOfServiceLink;

  /// No description provided for @registerPrivacyPolicyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get registerPrivacyPolicyLink;

  /// No description provided for @registerContactUsLink.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get registerContactUsLink;

  /// No description provided for @registerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© RESERVATION'**
  String get registerCopyright;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'RESERVATION ID'**
  String get loginTitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address*'**
  String get loginEmailLabel;

  /// No description provided for @loginEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'example@reservation.be'**
  String get loginEmailPlaceholder;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password*'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get loginPasswordPlaceholder;

  /// No description provided for @loginRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get loginRememberMe;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get loginForgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginNoAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have a RESERVATION account?'**
  String get loginNoAccountPrompt;

  /// No description provided for @loginSignupLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up now'**
  String get loginSignupLink;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Your Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No worries! Enter your email and we will send you a reset link.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get forgotPasswordEmailLabel;

  /// No description provided for @forgotPasswordEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get forgotPasswordEmailPlaceholder;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get forgotPasswordButton;

  /// No description provided for @forgotPasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'An email with a password reset link has been sent. Please check your inbox.'**
  String get forgotPasswordSuccessMessage;

  /// No description provided for @forgotPasswordFormError.
  ///
  /// In en, this message translates to:
  /// **'Please correct the errors in the form.'**
  String get forgotPasswordFormError;

  /// No description provided for @forgotPasswordRemembered.
  ///
  /// In en, this message translates to:
  /// **'Remembered your password?'**
  String get forgotPasswordRemembered;

  /// No description provided for @forgotPasswordBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get forgotPasswordBackToLogin;

  /// No description provided for @homePrimaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Service'**
  String get homePrimaryTitle;

  /// No description provided for @inquirySidebarLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get inquirySidebarLocation;

  /// No description provided for @inquirySidebarOpeningHours.
  ///
  /// In en, this message translates to:
  /// **'Opening Hours'**
  String get inquirySidebarOpeningHours;

  /// No description provided for @inquirySidebarClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get inquirySidebarClosed;

  /// No description provided for @inquirySidebarAboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get inquirySidebarAboutUs;

  /// No description provided for @inquirySidebarTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get inquirySidebarTermsOfUse;

  /// No description provided for @inquiryDayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get inquiryDayMonday;

  /// No description provided for @inquiryDayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get inquiryDayTuesday;

  /// No description provided for @inquiryDayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get inquiryDayWednesday;

  /// No description provided for @inquiryDayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get inquiryDayThursday;

  /// No description provided for @inquiryDayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get inquiryDayFriday;

  /// No description provided for @inquiryDaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get inquiryDaySaturday;

  /// No description provided for @inquiryDaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get inquiryDaySunday;

  /// No description provided for @inquiryFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Inquiry'**
  String get inquiryFormTitle;

  /// No description provided for @inquiryFormName.
  ///
  /// In en, this message translates to:
  /// **'Name *'**
  String get inquiryFormName;

  /// No description provided for @inquiryFormEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address *'**
  String get inquiryFormEmail;

  /// No description provided for @inquiryFormPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get inquiryFormPhone;

  /// No description provided for @inquiryFormSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject *'**
  String get inquiryFormSubject;

  /// No description provided for @inquiryFormInquiryContent.
  ///
  /// In en, this message translates to:
  /// **'Inquiry Content *'**
  String get inquiryFormInquiryContent;

  /// No description provided for @inquiryFormSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Inquiry'**
  String get inquiryFormSubmitButton;

  /// No description provided for @inquiryPlaceholderName.
  ///
  /// In en, this message translates to:
  /// **'Tokyo Taro Barang'**
  String get inquiryPlaceholderName;

  /// No description provided for @inquiryPlaceholderEmail.
  ///
  /// In en, this message translates to:
  /// **'your@email.com'**
  String get inquiryPlaceholderEmail;

  /// No description provided for @inquiryPlaceholderPhone.
  ///
  /// In en, this message translates to:
  /// **'00-0000-0000'**
  String get inquiryPlaceholderPhone;

  /// No description provided for @inquiryPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter the content of your inquiry'**
  String get inquiryPlaceholderMessage;

  /// No description provided for @inquirySuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your inquiry has been sent successfully!'**
  String get inquirySuccessMessage;

  /// No description provided for @inquiryErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'There was an error sending your inquiry. Please try again later.'**
  String get inquiryErrorMessage;

  /// No description provided for @profileShowTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileShowTitle;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditTitle;

  /// No description provided for @profileSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileSuccessMessage;

  /// No description provided for @profilePersonalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get profilePersonalInfoTitle;

  /// No description provided for @profileLabelFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileLabelFullName;

  /// No description provided for @profileLabelFullNameKana.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Kana)'**
  String get profileLabelFullNameKana;

  /// No description provided for @profileLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get profileLabelEmail;

  /// No description provided for @profileLabelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profileLabelPhone;

  /// No description provided for @profileLabelDob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get profileLabelDob;

  /// No description provided for @profileLabelAddress.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get profileLabelAddress;

  /// No description provided for @profileChangePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileChangePasswordTitle;

  /// No description provided for @profileLabelCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get profileLabelCurrentPassword;

  /// No description provided for @profileLabelNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get profileLabelNewPassword;

  /// No description provided for @profileLabelConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get profileLabelConfirmPassword;

  /// No description provided for @profileButtonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileButtonEdit;

  /// No description provided for @profileButtonChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileButtonChangePassword;

  /// No description provided for @profileButtonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileButtonCancel;

  /// No description provided for @profileButtonSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profileButtonSaveChanges;

  /// No description provided for @createReservationNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation Notes'**
  String get createReservationNotesTitle;

  /// No description provided for @createReservationNotesContent1.
  ///
  /// In en, this message translates to:
  /// **'The work time is an approximate guide'**
  String get createReservationNotesContent1;

  /// No description provided for @createReservationNotesContent2.
  ///
  /// In en, this message translates to:
  /// **'Please note that it may take some time depending on the work content'**
  String get createReservationNotesContent2;

  /// No description provided for @createReservationNotesContent3.
  ///
  /// In en, this message translates to:
  /// **'Reservation deadline: Until 23:59 one day before'**
  String get createReservationNotesContent3;

  /// No description provided for @createReservationNotesContent4.
  ///
  /// In en, this message translates to:
  /// **'Cancellation not allowed after confirmation'**
  String get createReservationNotesContent4;

  /// No description provided for @confirmReservationBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Information'**
  String get confirmReservationBannerTitle;

  /// No description provided for @confirmReservationBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please choose how you would like to proceed with your reservation.'**
  String get confirmReservationBannerSubtitle;

  /// No description provided for @confirmReservationWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, Rizz!'**
  String get confirmReservationWelcomeBack;

  /// No description provided for @confirmReservationLoggedInAs.
  ///
  /// In en, this message translates to:
  /// **'You are logged in as a RESERVA member.'**
  String get confirmReservationLoggedInAs;

  /// No description provided for @confirmReservationInfoUsageWarning.
  ///
  /// In en, this message translates to:
  /// **'Your member information will be used for this reservation.'**
  String get confirmReservationInfoUsageWarning;

  /// No description provided for @confirmReservationContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue with This Account'**
  String get confirmReservationContinueButton;

  /// No description provided for @reservationSummaryBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Final Confirmation'**
  String get reservationSummaryBannerTitle;

  /// No description provided for @reservationSummaryBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please review your reservation details carefully before completing the booking.'**
  String get reservationSummaryBannerSubtitle;

  /// No description provided for @reservationSummaryServiceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get reservationSummaryServiceDetailsTitle;

  /// No description provided for @reservationSummaryCustomerInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get reservationSummaryCustomerInfoTitle;

  /// No description provided for @reservationSummaryLabelService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get reservationSummaryLabelService;

  /// No description provided for @reservationSummaryLabelDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get reservationSummaryLabelDuration;

  /// No description provided for @reservationSummaryLabelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reservationSummaryLabelDate;

  /// No description provided for @reservationSummaryLabelTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get reservationSummaryLabelTime;

  /// No description provided for @reservationSummaryLabelName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get reservationSummaryLabelName;

  /// No description provided for @reservationSummaryLabelNameKana.
  ///
  /// In en, this message translates to:
  /// **'Name (Kana)'**
  String get reservationSummaryLabelNameKana;

  /// No description provided for @reservationSummaryLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get reservationSummaryLabelEmail;

  /// No description provided for @reservationSummaryLabelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get reservationSummaryLabelPhone;

  /// No description provided for @reservationSummaryLabelStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get reservationSummaryLabelStatus;

  /// No description provided for @reservationSummaryNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Important Notes'**
  String get reservationSummaryNotesTitle;

  /// No description provided for @reservationSummaryNotesContent1.
  ///
  /// In en, this message translates to:
  /// **'Please arrive 5 minutes before your scheduled time.'**
  String get reservationSummaryNotesContent1;

  /// No description provided for @reservationSummaryNotesContent2.
  ///
  /// In en, this message translates to:
  /// **'Cancellation is not allowed after confirmation.'**
  String get reservationSummaryNotesContent2;

  /// No description provided for @reservationSummaryNotesContent3.
  ///
  /// In en, this message translates to:
  /// **'Changes to the reservation must be made at least 24 hours in advance.'**
  String get reservationSummaryNotesContent3;

  /// No description provided for @reservationSummaryNotesContent4.
  ///
  /// In en, this message translates to:
  /// **'Please bring a valid ID for verification if necessary.'**
  String get reservationSummaryNotesContent4;

  /// No description provided for @reservationSummaryTermsAndCondition.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and Conditions '**
  String get reservationSummaryTermsAndCondition;

  /// No description provided for @reservationSummaryPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'and Privacy Policy'**
  String get reservationSummaryPrivacyPolicy;

  /// No description provided for @confirmedReservationBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed!'**
  String get confirmedReservationBannerTitle;

  /// No description provided for @confirmedReservationBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your reservation has been successfully submitted.'**
  String get confirmedReservationBannerSubtitle;

  /// No description provided for @confirmedReservationYourReservationNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Reservation Number'**
  String get confirmedReservationYourReservationNumber;

  /// No description provided for @confirmedReservationWhatsNextTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s Next?'**
  String get confirmedReservationWhatsNextTitle;

  /// No description provided for @confirmedReservationWhatsNext1.
  ///
  /// In en, this message translates to:
  /// **'A confirmation email has been sent to your email address.'**
  String get confirmedReservationWhatsNext1;

  /// No description provided for @confirmedReservationWhatsNext2.
  ///
  /// In en, this message translates to:
  /// **'Please arrive 5 minutes before your scheduled time.'**
  String get confirmedReservationWhatsNext2;

  /// No description provided for @confirmedReservationWhatsNext3.
  ///
  /// In en, this message translates to:
  /// **'Bring a valid ID for verification.'**
  String get confirmedReservationWhatsNext3;

  /// No description provided for @confirmedReservationWhatsNext4.
  ///
  /// In en, this message translates to:
  /// **'Contact us if you need to make any changes.'**
  String get confirmedReservationWhatsNext4;

  /// No description provided for @confirmedReservationViewMyReservationsButton.
  ///
  /// In en, this message translates to:
  /// **'View My Reservations'**
  String get confirmedReservationViewMyReservationsButton;

  /// No description provided for @confirmedReservationBackToHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get confirmedReservationBackToHomeButton;

  /// No description provided for @menuBookButton.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get menuBookButton;

  /// No description provided for @menuUnavailableStatus.
  ///
  /// In en, this message translates to:
  /// **'Currently Unavailable'**
  String get menuUnavailableStatus;

  /// No description provided for @timeHour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get timeHour;

  /// No description provided for @timeHours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get timeHours;

  /// No description provided for @timeMinute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get timeMinute;

  /// No description provided for @timeMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get timeMinutes;

  /// No description provided for @reservationStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get reservationStatusConfirmed;

  /// No description provided for @reservationStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get reservationStatusPending;

  /// No description provided for @reservationStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get reservationStatusCompleted;

  /// No description provided for @reservationStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get reservationStatusCancelled;

  /// No description provided for @reservationItemLabelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reservationItemLabelDate;

  /// No description provided for @reservationItemLabelTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get reservationItemLabelTime;

  /// No description provided for @reservationItemLabelPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get reservationItemLabelPeople;

  /// No description provided for @reservationItemLabelNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get reservationItemLabelNotes;

  /// No description provided for @reservationItemPeopleUnit.
  ///
  /// In en, this message translates to:
  /// **'people'**
  String get reservationItemPeopleUnit;

  /// No description provided for @reservationItemCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel Reservation'**
  String get reservationItemCancelButton;

  /// No description provided for @dateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// No description provided for @dateTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get dateTomorrow;

  /// No description provided for @myReservationMainTitle.
  ///
  /// In en, this message translates to:
  /// **'My Reservations'**
  String get myReservationMainTitle;

  /// No description provided for @myReservationMainSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage and view all your reservations in one place.'**
  String get myReservationMainSubTitle;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tire Installation Reservation'**
  String get appName;

  /// No description provided for @appBarCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get appBarCalendar;

  /// No description provided for @appBarInquiry.
  ///
  /// In en, this message translates to:
  /// **'Inquiry'**
  String get appBarInquiry;

  /// No description provided for @appBarLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get appBarLogin;

  /// No description provided for @appBarReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get appBarReservations;

  /// No description provided for @appBarProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get appBarProfile;

  /// No description provided for @appBarLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get appBarLogout;

  /// No description provided for @appBarHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get appBarHome;

  /// No description provided for @appBarCreateReservation.
  ///
  /// In en, this message translates to:
  /// **'Create Reservation'**
  String get appBarCreateReservation;

  /// No description provided for @appBarConfirmReservation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Reservation'**
  String get appBarConfirmReservation;

  /// No description provided for @appBarConfirmedReservation.
  ///
  /// In en, this message translates to:
  /// **'Confirmed Reservation'**
  String get appBarConfirmedReservation;

  /// No description provided for @appBarMyReservations.
  ///
  /// In en, this message translates to:
  /// **'My Reservations'**
  String get appBarMyReservations;

  /// No description provided for @appBarReservationSummary.
  ///
  /// In en, this message translates to:
  /// **'Reservation Summary'**
  String get appBarReservationSummary;

  /// No description provided for @appBarRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get appBarRegister;

  /// No description provided for @userBottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get userBottomNavHome;

  /// No description provided for @userBottomNavReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get userBottomNavReservations;

  /// No description provided for @userBottomNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get userBottomNavProfile;

  /// No description provided for @drawerHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get drawerHeaderTitle;

  /// No description provided for @adminDrawerHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Menu'**
  String get adminDrawerHeaderTitle;

  /// No description provided for @drawerGuestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get drawerGuestUser;

  /// No description provided for @drawerGuestLoginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please login to continue'**
  String get drawerGuestLoginPrompt;

  /// No description provided for @drawerItemLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get drawerItemLanguage;

  /// No description provided for @drawerActionLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get drawerActionLogin;

  /// No description provided for @drawerActionLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get drawerActionLogout;

  /// No description provided for @drawerLogoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout Confirmation'**
  String get drawerLogoutDialogTitle;

  /// No description provided for @drawerLogoutDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get drawerLogoutDialogContent;

  /// No description provided for @drawerActionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get drawerActionCancel;

  /// No description provided for @drawerItemInquiry.
  ///
  /// In en, this message translates to:
  /// **'Inquiry'**
  String get drawerItemInquiry;

  /// No description provided for @dialogTitleSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get dialogTitleSelectLanguage;

  /// No description provided for @adminBottomNavDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get adminBottomNavDashboard;

  /// No description provided for @adminBottomNavCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get adminBottomNavCalendar;

  /// No description provided for @adminBottomNavAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get adminBottomNavAnnouncements;

  /// No description provided for @adminDrawerItemAvailability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get adminDrawerItemAvailability;

  /// No description provided for @adminDrawerItemBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked Management'**
  String get adminDrawerItemBlocked;

  /// No description provided for @adminDrawerItemBusinessInformation.
  ///
  /// In en, this message translates to:
  /// **'Business Info'**
  String get adminDrawerItemBusinessInformation;

  /// No description provided for @adminDrawerItemContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Management'**
  String get adminDrawerItemContact;

  /// No description provided for @adminDrawerItemCustomerManagement.
  ///
  /// In en, this message translates to:
  /// **'Customer Management'**
  String get adminDrawerItemCustomerManagement;

  /// No description provided for @adminDrawerItemMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu Management'**
  String get adminDrawerItemMenu;

  /// No description provided for @pressAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press Again To Exit'**
  String get pressAgainToExit;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'id':
      return L10nId();
    case 'ja':
      return L10nJa();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
