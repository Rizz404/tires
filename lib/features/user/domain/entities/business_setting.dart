import 'package:equatable/equatable.dart';

class BusinessSetting extends Equatable {
  final int id;
  final String phoneNumber;
  final Map<String, dynamic> businessHours;
  final String? websiteUrl;
  final String? topImagePath;
  final bool sitePublic;
  final String? replyEmail;
  final String? googleAnalyticsId;
  final List<BusinessSettingTranslation> translations;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BusinessSetting({
    required this.id,
    required this.phoneNumber,
    required this.businessHours,
    this.websiteUrl,
    this.topImagePath,
    required this.sitePublic,
    this.replyEmail,
    this.googleAnalyticsId,
    required this.translations,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    phoneNumber,
    businessHours,
    websiteUrl,
    topImagePath,
    sitePublic,
    replyEmail,
    googleAnalyticsId,
    translations,
    createdAt,
    updatedAt,
  ];
}

class BusinessSettingTranslation extends Equatable {
  final int id;
  final String locale;
  final String shopName;
  final String address;
  final String? accessInformation;
  final String? siteName;
  final String? shopDescription;
  final String? termsOfUse;
  final String? privacyPolicy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BusinessSettingTranslation({
    required this.id,
    required this.locale,
    required this.shopName,
    required this.address,
    this.accessInformation,
    this.siteName,
    this.shopDescription,
    this.termsOfUse,
    this.privacyPolicy,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    locale,
    shopName,
    address,
    accessInformation,
    siteName,
    shopDescription,
    termsOfUse,
    privacyPolicy,
    createdAt,
    updatedAt,
  ];
}
