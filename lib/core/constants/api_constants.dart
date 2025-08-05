class ApiConstants {
  // * Ini jadiin singelton jangan lupa ya
  ApiConstants._();

  static const String baseUrl = "http://localhost:5000/api/v1";
  static const int defaultReceiveTimeout = 15000;
  static const int defaultConnectTimeout = 15000;
}
