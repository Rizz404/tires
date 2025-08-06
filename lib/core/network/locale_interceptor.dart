import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LocaleInterceptor extends Interceptor {
  Locale? _currentLocale;

  void updateLocale(Locale locale) {
    _currentLocale = locale;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_currentLocale != null) {
      options.headers['X-Locale'] = _getLocaleHeaderValue(_currentLocale!);
    }
    super.onRequest(options, handler);
  }

  String _getLocaleHeaderValue(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'en';
      case 'ja':
        return 'ja';
      default:
        return 'en'; // Default fallback
    }
  }
}
