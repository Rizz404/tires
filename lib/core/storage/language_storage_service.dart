import 'package:flutter/material.dart';

abstract class LanguageStorageService {
  Future<Locale> getLocale();
  Future<void> setLocale(Locale locale);
  Future<void> removeLocale();
}
