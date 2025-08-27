class ApiEndpoints {
  ApiEndpoints._();

  // --- Prefixes ---
  static const String _authPrefix = '/auth';
  static const String _menuPrefix = '/menus';
  static const String _userPrefix = '/users';
  static const String _reservationPrefix = '/reservations';
  static const String _announcementPrefix = '/announcements';
  static const String _blockedPeriodPrefix = '/blocked-periods';
  static const String _businessSettingPrefix = '/business-settings';
  static const String _contactPrefix = '/contacts';
  static const String _faqPrefix = '/faqs';
  static const String _paymentPrefix = '/payments';
  static const String _questionnairePrefix = '/questionnaires';
  static const String _tireStoragePrefix = '/tire-storages';
  static const String _availabilityPrefix = '/availability';

  // --- Auth Endpoints ---
  static const String register = '$_authPrefix/register';
  static const String login = '$_authPrefix/login';
  static const String forgotPassword = '$_authPrefix/forgot-password';
  static const String setNewPassword = '$_authPrefix/reset-password';

  // --- Menu Endpoints ---
  static const String menus = _menuPrefix;
  static String menuById(String menuId) => '$_menuPrefix/$menuId';

  // --- User Endpoints ---
  static const String users = _userPrefix;
  static String userById(String userId) => '$_userPrefix/$userId';

  // --- Reservation Endpoints ---
  static const String reservations = _reservationPrefix;
  static const String reservationCalendar = "$_reservationPrefix/calendar";
  static String reservationById(String reservationId) =>
      '$_reservationPrefix/$reservationId';

  // --- Announcement Endpoints ---
  static const String announcements = _announcementPrefix;
  static String announcementById(String announcementId) =>
      '$_announcementPrefix/$announcementId';

  // --- Blocked Period Endpoints ---
  static const String blockedPeriods = _blockedPeriodPrefix;
  static String blockedPeriodById(String blockedPeriodId) =>
      '$_blockedPeriodPrefix/$blockedPeriodId';

  // --- Business Setting Endpoints ---
  static const String businessSettings = _businessSettingPrefix;
  static String businessSettingById(String settingId) =>
      '$_businessSettingPrefix/$settingId';

  // --- Contact Endpoints ---
  static const String contacts = _contactPrefix;
  static String contactById(String contactId) => '$_contactPrefix/$contactId';

  // --- FAQ Endpoints ---
  static const String faqs = _faqPrefix;
  static String faqById(String faqId) => '$_faqPrefix/$faqId';

  // --- Payment Endpoints ---
  static const String payments = _paymentPrefix;
  static String paymentById(String paymentId) => '$_paymentPrefix/$paymentId';

  // --- Questionnaire Endpoints ---
  static const String questionnaires = _questionnairePrefix;
  static String questionnaireById(String questionnaireId) =>
      '$_questionnairePrefix/$questionnaireId';

  // --- Tire Storage Endpoints ---
  static const String tireStorages = _tireStoragePrefix;
  static String tireStorageById(String tireStorageId) =>
      '$_tireStoragePrefix/$tireStorageId';

  // --- Availability Endpoints ---
  static const String availability = _availabilityPrefix;
}
