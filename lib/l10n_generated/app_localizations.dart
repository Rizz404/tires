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

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tire Installation Reservation'**
  String get appName;

  /// No description provided for @bottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomNavHome;

  /// No description provided for @bottomNavReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get bottomNavReservations;

  /// No description provided for @bottomNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavProfile;

  /// No description provided for @drawerHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get drawerHeaderTitle;

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

  /// No description provided for @drawerItemFoods.
  ///
  /// In en, this message translates to:
  /// **'Foods'**
  String get drawerItemFoods;

  /// No description provided for @drawerItemOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get drawerItemOrders;

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

  /// No description provided for @dialogTitleSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get dialogTitleSelectLanguage;
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
