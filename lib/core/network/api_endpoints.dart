class ApiEndpoints {
  ApiEndpoints._();

  // --- Role Prefixes ---
  static const String _adminPrefix = '/admin';
  static const String _customerPrefix = '/customer';

  // --- Api Prefixes ---
  static const String _authPrefix = '/auth';
  static const String _menuPrefix = '/menus';
  static const String _userPrefix = '/users';
  static const String _reservationPrefix = '/reservations';
  static const String _bookingPrefix = '/booking';
  static const String _announcementPrefix = '/announcements';
  static const String _blockedPeriodPrefix = '/blocked-periods';
  static const String _businessSettingPrefix = '/business-settings';
  static const String _contactPrefix = '/contacts';
  static const String _inquiryPrefix = '/inquiry';
  static const String _faqPrefix = '/faqs';
  static const String _paymentPrefix = '/payments';
  static const String _questionnairePrefix = '/questionnaires';
  static const String _tireStoragePrefix = '/tire-storages';
  static const String _availabilityPrefix = '/availability';
  static const String _profilePrefix = '$_customerPrefix/profile';

  // --- Auth Endpoints ---
  static const String register = '$_authPrefix/register';
  static const String login = '$_authPrefix/login';
  static const String logout = '$_authPrefix/logout';

  // --- Admin Endpoints ---
  static const String adminMenus = '$_adminPrefix$_menuPrefix';
  static const String adminUsers = '$_adminPrefix$_userPrefix';
  static const String adminReservations = '$_adminPrefix$_reservationPrefix';
  static const String adminReservationCalendar =
      '$_adminPrefix$_reservationPrefix/calendar';
  static const String adminAnnouncements = '$_adminPrefix$_announcementPrefix';
  static const String adminBlockedPeriods =
      '$_adminPrefix$_blockedPeriodPrefix';
  static const String adminBusinessSettings =
      '$_adminPrefix$_businessSettingPrefix';
  static const String adminContacts = '$_adminPrefix$_contactPrefix';
  static const String adminFaqs = '$_adminPrefix$_faqPrefix';
  static const String adminPayments = '$_adminPrefix$_paymentPrefix';
  static const String adminQuestionnaires =
      '$_adminPrefix$_questionnairePrefix';
  static const String adminTireStorages = '$_adminPrefix$_tireStoragePrefix';
  static const String adminAvailability = '$_adminPrefix$_availabilityPrefix';

  // --- Customer Endpoints ---
  static const String customerProfile = _profilePrefix;
  static const String customerMenus = '$_customerPrefix$_menuPrefix';
  static const String customerUsers = '$_customerPrefix$_userPrefix';
  static const String customerReservations =
      '$_customerPrefix$_reservationPrefix';
  static const String customerCreateReservation =
      '$_customerPrefix$_bookingPrefix/create-reservation';
  static const String customerReservationCalendar =
      '$_customerPrefix$_bookingPrefix/calendar-data';
  static const String customerReservationAvailableHours =
      '$_customerPrefix$_bookingPrefix/available-hours';
  static const String customerAnnouncements =
      '$_customerPrefix$_announcementPrefix';
  static const String customerBlockedPeriods =
      '$_customerPrefix$_blockedPeriodPrefix';
  static const String customerBusinessSettings =
      '$_customerPrefix$_businessSettingPrefix';
  static const String customerContacts = '$_customerPrefix$_contactPrefix';
  static const String customerInquiry = '$_customerPrefix$_inquiryPrefix';
  static const String customerFaqs = '$_customerPrefix$_faqPrefix';
  static const String customerPayments = '$_customerPrefix$_paymentPrefix';
  static const String customerQuestionnaires =
      '$_customerPrefix$_questionnairePrefix';
  static const String customerTireStorages =
      '$_customerPrefix$_tireStoragePrefix';
  static const String customerAvailability =
      '$_customerPrefix$_availabilityPrefix';
  static const String forgotPassword = '$_customerPrefix/forgot-password';
  static const String setNewPassword = '$_customerPrefix/change-password';

  // --- Shared Endpoints (Get by ID) ---
  static String menuById(String menuId) => '$_menuPrefix/$menuId';
  static String userById(String userId) => '$_userPrefix/$userId';
  static String reservationById(String reservationId) =>
      '$_reservationPrefix/$reservationId';
  static String announcementById(String announcementId) =>
      '$_announcementPrefix/$announcementId';
  static String blockedPeriodById(String blockedPeriodId) =>
      '$_blockedPeriodPrefix/$blockedPeriodId';
  static String businessSettingById(String settingId) =>
      '$_businessSettingPrefix/$settingId';
  static String contactById(String contactId) => '$_contactPrefix/$contactId';
  static String faqById(String faqId) => '$_faqPrefix/$faqId';
  static String paymentById(String paymentId) => '$_paymentPrefix/$paymentId';
  static String questionnaireById(String questionnaireId) =>
      '$_questionnairePrefix/$questionnaireId';
  static String tireStorageById(String tireStorageId) =>
      '$_tireStoragePrefix/$tireStorageId';
}
