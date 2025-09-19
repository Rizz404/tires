import 'package:tires/features/customer_management/data/models/customer_model.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart';

extension CustomerModelMapper on CustomerModel {
  Customer toEntity() {
    return Customer(
      id: id,
      userId: userId,
      email: email,
      fullName: fullName,
      fullNameKana: fullNameKana,
      phoneNumber: phoneNumber,
      companyName: companyName,
      department: department,
      companyAddress: companyAddress,
      homeAddress: homeAddress,
      dateOfBirth: dateOfBirth,
      gender: gender,
      isRegistered: isRegistered,
      reservationCount: reservationCount,
      latestReservation: latestReservation,
      totalAmount: totalAmount,
      translations: (translations as TranslationsModel).toEntity(),
      meta: (meta as MetaModel).toEntity(),
    );
  }
}

extension TranslationsModelMapper on TranslationsModel {
  Translations toEntity() {
    return Translations(
      en: (en as LanguageTranslationModel).toEntity(),
      ja: (ja as LanguageTranslationModel).toEntity(),
    );
  }
}

extension LanguageTranslationModelMapper on LanguageTranslationModel {
  LanguageTranslation toEntity() {
    return LanguageTranslation(fullName: fullName, companyName: companyName);
  }
}

extension MetaModelMapper on MetaModel {
  Meta toEntity() {
    return Meta(locale: locale, fallbackUsed: fallbackUsed);
  }
}

extension CustomerEntityMapper on Customer {
  CustomerModel toModel() {
    return CustomerModel(
      id: id,
      userId: userId,
      email: email,
      fullName: fullName,
      fullNameKana: fullNameKana,
      phoneNumber: phoneNumber,
      companyName: companyName,
      department: department,
      companyAddress: companyAddress,
      homeAddress: homeAddress,
      dateOfBirth: dateOfBirth,
      gender: gender,
      isRegistered: isRegistered,
      reservationCount: reservationCount,
      latestReservation: latestReservation,
      totalAmount: totalAmount,
      translations: translations.toModel(),
      meta: meta.toModel(),
    );
  }
}

extension TranslationsEntityMapper on Translations {
  TranslationsModel toModel() {
    return TranslationsModel(en: en.toModel(), ja: ja.toModel());
  }
}

extension LanguageTranslationEntityMapper on LanguageTranslation {
  LanguageTranslationModel toModel() {
    return LanguageTranslationModel(
      fullName: fullName,
      companyName: companyName,
    );
  }
}

extension MetaEntityMapper on Meta {
  MetaModel toModel() {
    return MetaModel(locale: locale, fallbackUsed: fallbackUsed);
  }
}
