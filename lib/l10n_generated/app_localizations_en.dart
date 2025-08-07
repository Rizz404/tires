// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get registerBrandName => 'RESERVATION ID';

  @override
  String get registerTitle => 'Create Your Account';

  @override
  String get registerLabelFullName => 'Full Name';

  @override
  String get registerLabelFullNameKana => 'Full Name (Kana)';

  @override
  String get registerLabelEmail => 'Email Address';

  @override
  String get registerLabelPhoneNumber => 'Phone Number';

  @override
  String get registerLabelCompanyName => 'Company Name';

  @override
  String get registerLabelDepartment => 'Department';

  @override
  String get registerLabelCompanyAddress => 'Company Address';

  @override
  String get registerLabelHomeAddress => 'Home Address';

  @override
  String get registerLabelDateOfBirth => 'Date of Birth';

  @override
  String get registerLabelGender => 'Gender';

  @override
  String get registerLabelPassword => 'Password';

  @override
  String get registerLabelConfirmPassword => 'Confirm Password';

  @override
  String get registerPlaceholderFullName => 'e.g., John Doe';

  @override
  String get registerPlaceholderFullNameKana => 'e.g., JOHN DOE';

  @override
  String get registerPlaceholderEmail => 'example@reservation.be';

  @override
  String get registerPlaceholderPhoneNumber => 'e.g., 08012345678';

  @override
  String get registerPlaceholderCompanyName => 'e.g., Acme Corporation';

  @override
  String get registerPlaceholderDepartment => 'e.g., Sales';

  @override
  String get registerPlaceholderCompanyAddress => 'Enter company address';

  @override
  String get registerPlaceholderHomeAddress => 'Enter home address';

  @override
  String get registerPlaceholderPassword => 'Minimum 8 characters';

  @override
  String get registerPlaceholderConfirmPassword => 'Confirm your password';

  @override
  String get registerGenderSelect => 'Select gender';

  @override
  String get registerGenderMale => 'Male';

  @override
  String get registerGenderFemale => 'Female';

  @override
  String get registerGenderOther => 'Other';

  @override
  String get registerButton => 'Register';

  @override
  String get registerAlreadyHaveAccount =>
      'Already have a RESERVATION account?';

  @override
  String get registerSignInLink => 'Sign in here';

  @override
  String get registerTermsAgreement =>
      'By registering, you agree to our terms of service and privacy policy.';

  @override
  String get registerTermsOfServiceLink => 'Terms of Service';

  @override
  String get registerPrivacyPolicyLink => 'Privacy Policy';

  @override
  String get registerContactUsLink => 'Contact Us';

  @override
  String get registerCopyright => '© RESERVATION';

  @override
  String get loginTitle => 'RESERVATION ID';

  @override
  String get loginEmailLabel => 'Email Address*';

  @override
  String get loginEmailPlaceholder => 'example@reservation.be';

  @override
  String get loginPasswordLabel => 'Password*';

  @override
  String get loginPasswordPlaceholder => '••••••••';

  @override
  String get loginRememberMe => 'Remember me';

  @override
  String get loginForgotPassword => 'Forgot your password?';

  @override
  String get loginButton => 'Login';

  @override
  String get loginNoAccountPrompt => 'Don\'t have a RESERVATION account?';

  @override
  String get loginSignupLink => 'Sign up now';

  @override
  String get inquirySidebarLocation => 'Location';

  @override
  String get inquirySidebarOpeningHours => 'Opening Hours';

  @override
  String get inquirySidebarClosed => 'Closed';

  @override
  String get inquirySidebarAboutUs => 'About Us';

  @override
  String get inquirySidebarTermsOfUse => 'Terms of Use';

  @override
  String get inquiryDayMonday => 'Monday';

  @override
  String get inquiryDayTuesday => 'Tuesday';

  @override
  String get inquiryDayWednesday => 'Wednesday';

  @override
  String get inquiryDayThursday => 'Thursday';

  @override
  String get inquiryDayFriday => 'Friday';

  @override
  String get inquiryDaySaturday => 'Saturday';

  @override
  String get inquiryDaySunday => 'Sunday';

  @override
  String get inquiryFormTitle => 'Inquiry';

  @override
  String get inquiryFormName => 'Name *';

  @override
  String get inquiryFormEmail => 'Email Address *';

  @override
  String get inquiryFormPhone => 'Phone Number';

  @override
  String get inquiryFormSubject => 'Subject *';

  @override
  String get inquiryFormInquiryContent => 'Inquiry Content *';

  @override
  String get inquiryFormSubmitButton => 'Submit Inquiry';

  @override
  String get inquiryPlaceholderName => 'Tokyo Taro Barang';

  @override
  String get inquiryPlaceholderEmail => 'your@email.com';

  @override
  String get inquiryPlaceholderPhone => '00-0000-0000';

  @override
  String get inquiryPlaceholderMessage =>
      'Please enter the content of your inquiry';

  @override
  String get inquirySuccessMessage =>
      'Your inquiry has been sent successfully!';

  @override
  String get inquiryErrorMessage =>
      'There was an error sending your inquiry. Please try again later.';

  @override
  String get profileShowTitle => 'My Profile';

  @override
  String get profileEditTitle => 'Edit Profile';

  @override
  String get profileSuccessMessage => 'Profile updated successfully!';

  @override
  String get profilePersonalInfoTitle => 'Personal Information';

  @override
  String get profileLabelFullName => 'Full Name';

  @override
  String get profileLabelFullNameKana => 'Full Name (Kana)';

  @override
  String get profileLabelEmail => 'Email Address';

  @override
  String get profileLabelPhone => 'Phone Number';

  @override
  String get profileLabelDob => 'Date of Birth';

  @override
  String get profileLabelAddress => 'Home Address';

  @override
  String get profileChangePasswordTitle => 'Change Password';

  @override
  String get profileLabelCurrentPassword => 'Current Password';

  @override
  String get profileLabelNewPassword => 'New Password';

  @override
  String get profileLabelConfirmPassword => 'Confirm New Password';

  @override
  String get profileButtonEdit => 'Edit Profile';

  @override
  String get profileButtonChangePassword => 'Change Password';

  @override
  String get profileButtonCancel => 'Cancel';

  @override
  String get profileButtonSaveChanges => 'Save Changes';

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
