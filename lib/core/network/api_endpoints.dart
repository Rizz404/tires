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

  // --- Auth Endpoints ---
  static const String register = '$_authPrefix/register';
  static const String login = '$_authPrefix/login';
  static const String forgotPassword = '$_authPrefix/forgot-password';
  static const String setNewPassword = '$_authPrefix/reset-password';

  // --- Menu Endpoints ---
  /// GET: /menus
  /// POST: /menus
  static const String menus = _menuPrefix;

  /// GET: /menus/{id}
  /// PUT: /menus/{id}
  /// DELETE: /menus/{id}
  static String menuById(String menuId) => '$_menuPrefix/$menuId';

  // --- User Endpoints ---
  /// GET: /users
  /// POST: /users
  static const String users = _userPrefix;

  /// GET: /users/{id}
  /// PUT: /users/{id}
  /// DELETE: /users/{id}
  static String userById(String userId) => '$_userPrefix/$userId';

  // --- Reservation Endpoints ---
  /// GET: /reservations
  /// POST: /reservations
  static const String reservations = _reservationPrefix;

  /// GET: /reservations/{id}
  /// PUT: /reservations/{id}
  /// DELETE: /reservations/{id}
  static String reservationById(String reservationId) =>
      '$_reservationPrefix/$reservationId';

  // --- Announcement Endpoints ---
  /// GET: /announcements
  /// POST: /announcements
  static const String announcements = _announcementPrefix;

  /// GET: /announcements/{id}
  /// PUT: /announcements/{id}
  /// DELETE: /announcements/{id}
  static String announcementById(String announcementId) =>
      '$_announcementPrefix/$announcementId';

  // --- Blocked Period Endpoints ---
  /// GET: /blocked-periods
  /// POST: /blocked-periods
  static const String blockedPeriods = _blockedPeriodPrefix;

  /// GET: /blocked-periods/{id}
  /// PUT: /blocked-periods/{id}
  /// DELETE: /blocked-periods/{id}
  static String blockedPeriodById(String blockedPeriodId) =>
      '$_blockedPeriodPrefix/$blockedPeriodId';

  // --- Business Setting Endpoints ---
  /// GET: /business-settings
  /// POST: /business-settings
  static const String businessSettings = _businessSettingPrefix;

  /// GET: /business-settings/{id}
  /// PUT: /business-settings/{id}
  /// DELETE: /business-settings/{id}
  static String businessSettingById(String settingId) =>
      '$_businessSettingPrefix/$settingId';

  // --- Contact Endpoints ---
  /// GET: /contacts
  /// POST: /contacts
  static const String contacts = _contactPrefix;

  /// GET: /contacts/{id}
  /// PUT: /contacts/{id}
  /// DELETE: /contacts/{id}
  static String contactById(String contactId) => '$_contactPrefix/$contactId';

  // --- FAQ Endpoints ---
  /// GET: /faqs
  /// POST: /faqs
  static const String faqs = _faqPrefix;

  /// GET: /faqs/{id}
  /// PUT: /faqs/{id}
  /// DELETE: /faqs/{id}
  static String faqById(String faqId) => '$_faqPrefix/$faqId';

  // --- Payment Endpoints ---
  /// GET: /payments
  /// POST: /payments
  static const String payments = _paymentPrefix;

  /// GET: /payments/{id}
  /// PUT: /payments/{id}
  /// DELETE: /payments/{id}
  static String paymentById(String paymentId) => '$_paymentPrefix/$paymentId';

  // --- Questionnaire Endpoints ---
  /// GET: /questionnaires
  /// POST: /questionnaires
  static const String questionnaires = _questionnairePrefix;

  /// GET: /questionnaires/{id}
  /// PUT: /questionnaires/{id}
  /// DELETE: /questionnaires/{id}
  static String questionnaireById(String questionnaireId) =>
      '$_questionnairePrefix/$questionnaireId';

  // --- Tire Storage Endpoints ---
  /// GET: /tire-storages
  /// POST: /tire-storages
  static const String tireStorages = _tireStoragePrefix;

  /// GET: /tire-storages/{id}
  /// PUT: /tire-storages/{id}
  /// DELETE: /tire-storages/{id}
  static String tireStorageById(String tireStorageId) =>
      '$_tireStoragePrefix/$tireStorageId';
}
