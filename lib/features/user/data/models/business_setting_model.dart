import 'dart:convert';

import 'package:tires/features/user/domain/entities/business_setting.dart';

class BusinessSettingModel extends BusinessSetting {
  const BusinessSettingModel({
    required super.id,
    required super.phoneNumber,
    required super.businessHours,
    super.websiteUrl,
    super.topImagePath,
    required super.sitePublic,
    super.replyEmail,
    super.googleAnalyticsId,
    required super.translations,
    required super.createdAt,
    required super.updatedAt,
  });

  BusinessSettingModel copyWith({
    int? id,
    String? phoneNumber,
    Map<String, dynamic>? businessHours,
    String? websiteUrl,
    String? topImagePath,
    bool? sitePublic,
    String? replyEmail,
    String? googleAnalyticsId,
    List<BusinessSettingTranslationModel>? translations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BusinessSettingModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      businessHours: businessHours ?? this.businessHours,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      topImagePath: topImagePath ?? this.topImagePath,
      sitePublic: sitePublic ?? this.sitePublic,
      replyEmail: replyEmail ?? this.replyEmail,
      googleAnalyticsId: googleAnalyticsId ?? this.googleAnalyticsId,
      translations:
          translations ??
          this.translations
              .map((e) => BusinessSettingTranslationModel.fromEntity(e))
              .toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'businessHours': businessHours,
      'websiteUrl': websiteUrl,
      'topImagePath': topImagePath,
      'sitePublic': sitePublic,
      'replyEmail': replyEmail,
      'googleAnalyticsId': googleAnalyticsId,
      'translations': translations
          .map((x) => (x as BusinessSettingTranslationModel).toMap())
          .toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory BusinessSettingModel.fromMap(Map<String, dynamic> map) {
    return BusinessSettingModel(
      id: map['id']?.toInt() ?? 0,
      phoneNumber: map['phoneNumber'] ?? '',
      businessHours: Map<String, dynamic>.from(map['businessHours']),
      websiteUrl: map['websiteUrl'],
      topImagePath: map['topImagePath'],
      sitePublic: map['sitePublic'] ?? false,
      replyEmail: map['replyEmail'],
      googleAnalyticsId: map['googleAnalyticsId'],
      translations: List<BusinessSettingTranslationModel>.from(
        map['translations']?.map(
          (x) => BusinessSettingTranslationModel.fromMap(x),
        ),
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  factory BusinessSettingModel.fromEntity(BusinessSetting entity) {
    return BusinessSettingModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber,
      businessHours: entity.businessHours,
      websiteUrl: entity.websiteUrl,
      topImagePath: entity.topImagePath,
      sitePublic: entity.sitePublic,
      replyEmail: entity.replyEmail,
      googleAnalyticsId: entity.googleAnalyticsId,
      translations: entity.translations
          .map((e) => BusinessSettingTranslationModel.fromEntity(e))
          .toList(),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessSettingModel.fromJson(String source) =>
      BusinessSettingModel.fromMap(json.decode(source));

  @override
  String toString() => 'BusinessSettingModel(${toMap()})';
}

class BusinessSettingTranslationModel extends BusinessSettingTranslation {
  const BusinessSettingTranslationModel({
    required super.id,
    required super.locale,
    required super.shopName,
    required super.address,
    super.accessInformation,
    super.siteName,
    super.shopDescription,
    super.termsOfUse,
    super.privacyPolicy,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BusinessSettingTranslationModel.fromEntity(
    BusinessSettingTranslation entity,
  ) {
    return BusinessSettingTranslationModel(
      id: entity.id,
      locale: entity.locale,
      shopName: entity.shopName,
      address: entity.address,
      accessInformation: entity.accessInformation,
      siteName: entity.siteName,
      shopDescription: entity.shopDescription,
      termsOfUse: entity.termsOfUse,
      privacyPolicy: entity.privacyPolicy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  BusinessSettingTranslationModel copyWith({
    int? id,
    String? locale,
    String? shopName,
    String? address,
    String? accessInformation,
    String? siteName,
    String? shopDescription,
    String? termsOfUse,
    String? privacyPolicy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BusinessSettingTranslationModel(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      shopName: shopName ?? this.shopName,
      address: address ?? this.address,
      accessInformation: accessInformation ?? this.accessInformation,
      siteName: siteName ?? this.siteName,
      shopDescription: shopDescription ?? this.shopDescription,
      termsOfUse: termsOfUse ?? this.termsOfUse,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'locale': locale,
      'shopName': shopName,
      'address': address,
      'accessInformation': accessInformation,
      'siteName': siteName,
      'shopDescription': shopDescription,
      'termsOfUse': termsOfUse,
      'privacyPolicy': privacyPolicy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory BusinessSettingTranslationModel.fromMap(Map<String, dynamic> map) {
    return BusinessSettingTranslationModel(
      id: map['id']?.toInt() ?? 0,
      locale: map['locale'] ?? '',
      shopName: map['shopName'] ?? '',
      address: map['address'] ?? '',
      accessInformation: map['accessInformation'],
      siteName: map['siteName'],
      shopDescription: map['shopDescription'],
      termsOfUse: map['termsOfUse'],
      privacyPolicy: map['privacyPolicy'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessSettingTranslationModel.fromJson(String source) =>
      BusinessSettingTranslationModel.fromMap(json.decode(source));

  @override
  String toString() => 'BusinessSettingTranslationModel(${toMap()})';
}
