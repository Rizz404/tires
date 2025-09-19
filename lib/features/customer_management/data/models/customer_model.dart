import 'dart:convert';
import 'package:tires/features/customer_management/domain/entities/customer.dart';

class CustomerModel extends Customer {
  CustomerModel({
    required super.id,
    super.userId,
    required super.email,
    required super.fullName,
    required super.fullNameKana,
    super.phoneNumber,
    super.companyName,
    super.department,
    super.companyAddress,
    super.homeAddress,
    super.dateOfBirth,
    super.gender,
    required super.isRegistered,
    required super.reservationCount,
    super.latestReservation,
    required super.totalAmount,
    required TranslationsModel super.translations,
    required MetaModel super.meta,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    try {
      return CustomerModel(
        id: (map['id'] as String?) ?? '',
        userId: map['user_id'] as int?,
        email: (map['email'] as String?) ?? '',
        fullName: (map['full_name'] as String?) ?? '',
        fullNameKana: (map['full_name_kana'] as String?) ?? '',
        phoneNumber: map['phone_number'] as String?,
        companyName: map['company_name'] as String?,
        department: map['department'] as String?,
        companyAddress: map['company_address'] as String?,
        homeAddress: map['home_address'] as String?,
        dateOfBirth: map['date_of_birth'] as String?,
        gender: map['gender'] as String?,
        isRegistered: (map['is_registered'] as int?) ?? 0,
        reservationCount: (map['reservation_count'] as int?) ?? 0,
        latestReservation: map['latest_reservation'] as String?,
        totalAmount: (map['total_amount'] as String?) ?? '0',
        translations:
            map['translations'] != null &&
                map['translations'] is Map<String, dynamic>
            ? TranslationsModel.fromMap(map['translations'])
            : const TranslationsModel(
                en: LanguageTranslationModel(fullName: '', companyName: null),
                ja: LanguageTranslationModel(fullName: '', companyName: null),
              ),
        meta: map['meta'] != null && map['meta'] is Map<String, dynamic>
            ? MetaModel.fromMap(map['meta'])
            : MetaModel(locale: 'en', fallbackUsed: true),
      );
    } catch (e, stackTrace) {
      print('❌ Error in CustomerModel.fromMap: $e');
      print('📋 Map contents: $map');
      print('📊 Stack trace: $stackTrace');
      rethrow;
    }
  }

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'email': email,
      'full_name': fullName,
      'full_name_kana': fullNameKana,
      'phone_number': phoneNumber,
      'company_name': companyName,
      'department': department,
      'company_address': companyAddress,
      'home_address': homeAddress,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'is_registered': isRegistered,
      'reservation_count': reservationCount,
      'latest_reservation': latestReservation,
      'total_amount': totalAmount,
      'translations': (translations as TranslationsModel).toMap(),
      'meta': (meta as MetaModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class TranslationsModel extends Translations {
  const TranslationsModel({
    required LanguageTranslationModel super.en,
    required LanguageTranslationModel super.ja,
  });

  factory TranslationsModel.fromMap(Map<String, dynamic> map) {
    return TranslationsModel(
      en: map['en'] != null && map['en'] is Map<String, dynamic>
          ? LanguageTranslationModel.fromMap(map['en'])
          : const LanguageTranslationModel(fullName: '', companyName: null),
      ja: map['ja'] != null && map['ja'] is Map<String, dynamic>
          ? LanguageTranslationModel.fromMap(map['ja'])
          : const LanguageTranslationModel(fullName: '', companyName: null),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'en': (en as LanguageTranslationModel).toMap(),
      'ja': (ja as LanguageTranslationModel).toMap(),
    };
  }
}

class LanguageTranslationModel extends LanguageTranslation {
  const LanguageTranslationModel({required super.fullName, super.companyName});

  factory LanguageTranslationModel.fromMap(Map<String, dynamic> map) {
    return LanguageTranslationModel(
      fullName: (map['full_name'] as String?) ?? '',
      companyName: map['company_name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'full_name': fullName, 'company_name': companyName};
  }
}

class MetaModel extends Meta {
  MetaModel({required super.locale, required super.fallbackUsed});

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      locale: (map['locale'] as String?) ?? 'en',
      fallbackUsed: (map['fallback_used'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {'locale': locale, 'fallback_used': fallbackUsed};
  }
}
