// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class L10nId extends L10n {
  L10nId([String locale = 'id']) : super(locale);

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
  String get createReservationNotesTitle => 'Reservation Notes';

  @override
  String get createReservationNotesContent1 =>
      'The work time is an approximate guide';

  @override
  String get createReservationNotesContent2 =>
      'Please note that it may take some time depending on the work content';

  @override
  String get createReservationNotesContent3 =>
      'Reservation deadline: Until 23:59 one day before';

  @override
  String get createReservationNotesContent4 =>
      'Cancellation not allowed after confirmation';

  @override
  String get confirmReservationBannerTitle => 'Booking Information';

  @override
  String get confirmReservationBannerSubtitle =>
      'Please choose how you would like to proceed with your reservation.';

  @override
  String get confirmReservationWelcomeBack => 'Welcome back, Rizz!';

  @override
  String get confirmReservationLoggedInAs =>
      'You are logged in as a RESERVA member.';

  @override
  String get confirmReservationInfoUsageWarning =>
      'Your member information will be used for this reservation.';

  @override
  String get confirmReservationContinueButton => 'Continue with This Account';

  @override
  String get reservationSummaryBannerTitle => 'Final Confirmation';

  @override
  String get reservationSummaryBannerSubtitle =>
      'Please review your reservation details carefully before completing the booking.';

  @override
  String get reservationSummaryServiceDetailsTitle => 'Service Details';

  @override
  String get reservationSummaryCustomerInfoTitle => 'Customer Information';

  @override
  String get reservationSummaryLabelService => 'Service';

  @override
  String get reservationSummaryLabelDuration => 'Duration';

  @override
  String get reservationSummaryLabelDate => 'Date';

  @override
  String get reservationSummaryLabelTime => 'Time';

  @override
  String get reservationSummaryLabelName => 'Name';

  @override
  String get reservationSummaryLabelNameKana => 'Name (Kana)';

  @override
  String get reservationSummaryLabelEmail => 'Email';

  @override
  String get reservationSummaryLabelPhone => 'Phone Number';

  @override
  String get reservationSummaryLabelStatus => 'Status';

  @override
  String get reservationSummaryNotesTitle => 'Important Notes';

  @override
  String get reservationSummaryNotesContent1 =>
      'Please arrive 5 minutes before your scheduled time.';

  @override
  String get reservationSummaryNotesContent2 =>
      'Cancellation is not allowed after confirmation.';

  @override
  String get reservationSummaryNotesContent3 =>
      'Changes to the reservation must be made at least 24 hours in advance.';

  @override
  String get reservationSummaryNotesContent4 =>
      'Please bring a valid ID for verification if necessary.';

  @override
  String get reservationSummaryTermsAndCondition =>
      'I agree to the Terms and Conditions ';

  @override
  String get reservationSummaryPrivacyPolicy => 'and Privacy Policy';

  @override
  String get confirmedReservationBannerTitle => 'Booking Confirmed!';

  @override
  String get confirmedReservationBannerSubtitle =>
      'Your reservation has been successfully submitted.';

  @override
  String get confirmedReservationYourReservationNumber =>
      'Your Reservation Number';

  @override
  String get confirmedReservationWhatsNextTitle => 'What\'s Next?';

  @override
  String get confirmedReservationWhatsNext1 =>
      'A confirmation email has been sent to your email address.';

  @override
  String get confirmedReservationWhatsNext2 =>
      'Please arrive 5 minutes before your scheduled time.';

  @override
  String get confirmedReservationWhatsNext3 =>
      'Bring a valid ID for verification.';

  @override
  String get confirmedReservationWhatsNext4 =>
      'Contact us if you need to make any changes.';

  @override
  String get confirmedReservationViewMyReservationsButton =>
      'View My Reservations';

  @override
  String get confirmedReservationBackToHomeButton => 'Back to Home';

  @override
  String get menuBookButton => 'Book';

  @override
  String get menuUnavailableStatus => 'Currently Unavailable';

  @override
  String get timeHour => 'hour';

  @override
  String get timeHours => 'hours';

  @override
  String get timeMinute => 'minute';

  @override
  String get timeMinutes => 'minutes';

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
  String get drawerItemInquiry => 'Inquiry';

  @override
  String get dialogTitleSelectLanguage => 'Select Language';
}
