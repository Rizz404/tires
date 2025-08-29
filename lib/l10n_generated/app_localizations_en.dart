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
  String get forgotPasswordTitle => 'Forgot Your Password?';

  @override
  String get forgotPasswordSubtitle =>
      'No worries! Enter your email and we will send you a reset link.';

  @override
  String get forgotPasswordEmailLabel => 'Email Address';

  @override
  String get forgotPasswordEmailPlaceholder => 'Enter your email address';

  @override
  String get forgotPasswordButton => 'Send Reset Link';

  @override
  String get forgotPasswordSuccessMessage =>
      'An email with a password reset link has been sent. Please check your inbox.';

  @override
  String get forgotPasswordFormError =>
      'Please correct the errors in the form.';

  @override
  String get forgotPasswordRemembered => 'Remembered your password?';

  @override
  String get forgotPasswordBackToLogin => 'Back to Login';

  @override
  String get adminListCustomerManagementTitle => 'Customer Management';

  @override
  String get adminListCustomerManagementDescription =>
      'Manage customer data and their reservation history.';

  @override
  String get adminListCustomerManagementStatsFirstTime => 'First Time';

  @override
  String get adminListCustomerManagementStatsRepeat => 'Repeat';

  @override
  String get adminListCustomerManagementStatsDormant => 'Dormant';

  @override
  String get adminListCustomerManagementFiltersSearchPlaceholder =>
      'Search by name, email, or phone number...';

  @override
  String get adminListCustomerManagementFiltersAllTypes => 'All Customer Types';

  @override
  String get adminListCustomerManagementFiltersFirstTime => 'First Time';

  @override
  String get adminListCustomerManagementFiltersRepeat => 'Repeat Customer';

  @override
  String get adminListCustomerManagementFiltersDormant => 'Dormant';

  @override
  String get adminListCustomerManagementFiltersReset => 'Reset';

  @override
  String get adminListCustomerManagementTableHeaderCustomer => 'Customer';

  @override
  String get adminListCustomerManagementTableHeaderContactInfo =>
      'Contact Info';

  @override
  String get adminListCustomerManagementTableHeaderStatus => 'Status';

  @override
  String get adminListCustomerManagementTableHeaderReservations =>
      'Reservations';

  @override
  String get adminListCustomerManagementTableHeaderTotalAmount =>
      'Total Amount';

  @override
  String get adminListCustomerManagementTableHeaderLastReservation =>
      'Last Reservation';

  @override
  String get adminListCustomerManagementTableHeaderActions => 'Actions';

  @override
  String get adminListCustomerManagementTableStatusBadgeRegistered =>
      'Registered';

  @override
  String get adminListCustomerManagementTableStatusBadgeGuest => 'Guest';

  @override
  String get adminListCustomerManagementTableTypeBadgeFirstTime => 'First Time';

  @override
  String get adminListCustomerManagementTableTypeBadgeRepeat => 'Repeat';

  @override
  String get adminListCustomerManagementTableTypeBadgeDormant => 'Dormant';

  @override
  String get adminListCustomerManagementTableReservationsCount =>
      ':count times';

  @override
  String get adminListCustomerManagementTableActionsTooltipViewDetails =>
      'View Details';

  @override
  String get adminListCustomerManagementTableActionsTooltipSendMessage =>
      'Send Message';

  @override
  String get adminListCustomerManagementTableEmptyTitle => 'No customers found';

  @override
  String get adminListCustomerManagementTableEmptyDescription =>
      'There are no customers registered or matching the selected filters.';

  @override
  String get adminListCustomerManagementPaginationPrevious => 'Previous';

  @override
  String get adminListCustomerManagementPaginationNext => 'Next';

  @override
  String get adminListCustomerManagementModalTitle => 'Send Message';

  @override
  String get adminListCustomerManagementModalSubject => 'Subject';

  @override
  String get adminListCustomerManagementModalSubjectPlaceholder =>
      'Enter subject';

  @override
  String get adminListCustomerManagementModalMessage => 'Message';

  @override
  String get adminListCustomerManagementModalMessagePlaceholder =>
      'Enter your message';

  @override
  String get adminListCustomerManagementModalCancel => 'Cancel';

  @override
  String get adminListCustomerManagementModalSend => 'Send Message';

  @override
  String get adminListCustomerManagementAlertsValidationError =>
      'Please fill in both subject and message';

  @override
  String get adminListCustomerManagementAlertsSendSuccess =>
      'Message sent successfully!';

  @override
  String get adminListCustomerManagementAlertsSendError =>
      'Failed to send message';

  @override
  String get adminUpsertCustomerManagementHeaderTitle => 'Customer Detail';

  @override
  String get adminUpsertCustomerManagementHeaderSubtitle =>
      'View detailed customer information and history.';

  @override
  String get adminUpsertCustomerManagementHeaderSendMessageButton =>
      'Send Message';

  @override
  String get adminUpsertCustomerManagementHeaderExportButton => 'Export';

  @override
  String get adminUpsertCustomerManagementStatsTotalReservations =>
      'Total Reservations';

  @override
  String get adminUpsertCustomerManagementStatsTotalAmount => 'Total Amount';

  @override
  String get adminUpsertCustomerManagementStatsTireStorage => 'Tire Storage';

  @override
  String get adminUpsertCustomerManagementSidebarStatusRegistered =>
      'Registered';

  @override
  String get adminUpsertCustomerManagementSidebarStatusGuest => 'Guest';

  @override
  String get adminUpsertCustomerManagementSidebarEmail => 'Email';

  @override
  String get adminUpsertCustomerManagementSidebarPhone => 'Phone';

  @override
  String get adminUpsertCustomerManagementSidebarCompany => 'Company';

  @override
  String get adminUpsertCustomerManagementSidebarDepartment => 'Department';

  @override
  String get adminUpsertCustomerManagementSidebarDob => 'Date of Birth';

  @override
  String get adminUpsertCustomerManagementSidebarGender => 'Gender';

  @override
  String get adminUpsertCustomerManagementSidebarGuestInfoTitle =>
      'Guest Customer';

  @override
  String get adminUpsertCustomerManagementSidebarGuestInfoBody =>
      'This customer made reservations as a guest. Limited information available.';

  @override
  String get adminUpsertCustomerManagementTabsCustomerInfo => 'Customer Info';

  @override
  String get adminUpsertCustomerManagementTabsReservationHistory =>
      'Reservation History';

  @override
  String get adminUpsertCustomerManagementTabsTireStorage => 'Tire Storage';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoTitle =>
      'Customer Information';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoFullName =>
      'Full Name';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoFullNameKana =>
      'Full Name (Kana)';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoEmail =>
      'Email';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoPhoneNumber =>
      'Phone Number';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoCompanyName =>
      'Company Name';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoDepartment =>
      'Department';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoDob =>
      'Date of Birth';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoGender =>
      'Gender';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoAddressesTitle =>
      'Addresses';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoCompanyAddress =>
      'Company Address';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoHomeAddress =>
      'Home Address';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoGuestTitle =>
      'Guest Customer';

  @override
  String get adminUpsertCustomerManagementMainContentCustomerInfoGuestBody =>
      'This customer made reservations as a guest. Only basic reservation information is available.';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestNameLabel =>
      'Name:';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestNameKanaLabel =>
      'Name (Kana):';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestEmailLabel =>
      'Email:';

  @override
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestPhoneLabel =>
      'Phone:';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryTitle =>
      'Reservation History';

  @override
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryCountText =>
      ':count reservations';

  @override
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryDateTime =>
      'Date & Time:';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryPeople =>
      'People:';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryMenu =>
      'Menu:';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryAmount =>
      'Amount:';

  @override
  String get adminUpsertCustomerManagementMainContentReservationHistoryNotes =>
      'Notes:';

  @override
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryViewDetailsLink =>
      'View Details';

  @override
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryNoRecords =>
      'No reservation history found.';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageTitle =>
      'Tire Storage';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageCountText =>
      ':count storage records';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageStartDate =>
      'Start Date:';

  @override
  String get adminUpsertCustomerManagementMainContentTireStoragePlannedEnd =>
      'Planned End:';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageStorageFee =>
      'Storage Fee:';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageDaysRemaining =>
      'Days Remaining:';

  @override
  String
  get adminUpsertCustomerManagementMainContentTireStorageDaysRemainingText =>
      ':days days';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageNotes =>
      'Notes:';

  @override
  String get adminUpsertCustomerManagementMainContentTireStorageNoRecords =>
      'No tire storage records found.';

  @override
  String get adminUpsertCustomerManagementModalTitle => 'Send Message to :name';

  @override
  String get adminUpsertCustomerManagementModalSubjectLabel => 'Subject';

  @override
  String get adminUpsertCustomerManagementModalSubjectPlaceholder =>
      'Enter subject';

  @override
  String get adminUpsertCustomerManagementModalMessageLabel => 'Message';

  @override
  String get adminUpsertCustomerManagementModalMessagePlaceholder =>
      'Enter your message';

  @override
  String get adminUpsertCustomerManagementModalCancelButton => 'Cancel';

  @override
  String get adminUpsertCustomerManagementModalSendButton => 'Send Message';

  @override
  String get adminUpsertCustomerManagementJsAlertsFillFields =>
      'Please fill in both subject and message';

  @override
  String get adminUpsertCustomerManagementJsAlertsSendSuccess =>
      'Message sent successfully!';

  @override
  String get adminUpsertCustomerManagementJsAlertsSendFailed =>
      'Failed to send message';

  @override
  String get adminUpsertCustomerManagementJsAlertsExportPlaceholder =>
      'Export functionality will be implemented';

  @override
  String get homePrimaryTitle => 'Our Service';

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
  String get profileLabelCompany => 'Company Name';

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
  String get profileButtonUpdateProfile => 'Update Profile';

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
  String confirmReservationWelcomeBack(String name) {
    return 'Welcome back, $name!';
  }

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
  String get reservationStatusConfirmed => 'Confirmed';

  @override
  String get reservationStatusPending => 'Pending';

  @override
  String get reservationStatusCompleted => 'Completed';

  @override
  String get reservationStatusCancelled => 'Cancelled';

  @override
  String get reservationItemLabelDate => 'Date';

  @override
  String get reservationItemLabelTime => 'Time';

  @override
  String get reservationItemLabelPeople => 'People';

  @override
  String get reservationItemLabelNotes => 'Notes';

  @override
  String get reservationItemPeopleUnit => 'people';

  @override
  String get reservationItemCancelButton => 'Cancel Reservation';

  @override
  String get dateToday => 'Today';

  @override
  String get dateTomorrow => 'Tomorrow';

  @override
  String get myReservationMainTitle => 'My Reservations';

  @override
  String get myReservationMainSubTitle =>
      'Manage and view all your reservations in one place.';

  @override
  String get appName => 'Tire Installation Reservation';

  @override
  String get appBarCalendar => 'Calendar';

  @override
  String get appBarInquiry => 'Inquiry';

  @override
  String get appBarLogin => 'Login';

  @override
  String get appBarReservations => 'Reservations';

  @override
  String get appBarProfile => 'Profile';

  @override
  String get appBarLogout => 'Logout';

  @override
  String get appBarHome => 'Home';

  @override
  String get appBarCreateReservation => 'Create Reservation';

  @override
  String get appBarConfirmReservation => 'Confirm Reservation';

  @override
  String get appBarConfirmedReservation => 'Confirmed Reservation';

  @override
  String get appBarMyReservations => 'My Reservations';

  @override
  String get appBarReservationSummary => 'Reservation Summary';

  @override
  String get appBarRegister => 'Register';

  @override
  String get userBottomNavHome => 'Home';

  @override
  String get userBottomNavReservations => 'Reservations';

  @override
  String get userBottomNavProfile => 'Profile';

  @override
  String get drawerHeaderTitle => 'Main Menu';

  @override
  String get adminDrawerHeaderTitle => 'Admin Menu';

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

  @override
  String get adminBottomNavDashboard => 'Dashboard';

  @override
  String get adminBottomNavCalendar => 'Calendar';

  @override
  String get adminBottomNavAnnouncements => 'Announcements';

  @override
  String get adminDrawerItemAvailability => 'Availability';

  @override
  String get adminDrawerItemBlocked => 'Blocked Management';

  @override
  String get adminDrawerItemBusinessInformation => 'Business Info';

  @override
  String get adminDrawerItemContact => 'Contact Management';

  @override
  String get adminDrawerItemCustomerManagement => 'Customer Management';

  @override
  String get adminDrawerItemMenu => 'Menu Management';

  @override
  String get pressAgainToExit => 'Press Again To Exit';
}
