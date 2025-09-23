import 'dart:convert';

import 'package:tires/features/business_information/domain/entities/business_day_hours.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';

class BusinessInformationModel extends BusinessInformation {
  const BusinessInformationModel({
    required super.id,
    required super.shopName,
    required super.siteName,
    required super.shopDescription,
    required super.accessInformation,
    required super.termsOfUse,
    required super.privacyPolicy,
    required super.address,
    required super.phoneNumber,
    required super.businessHours,
    super.websiteUrl,
    super.topImagePath,
    super.topImageUrl,
    required super.sitePublic,
    super.replyEmail,
    super.googleAnalyticsId,
    required super.createdAt,
    required super.updatedAt,
  });

  BusinessInformationModel copyWith({
    int? id,
    String? shopName,
    String? siteName,
    String? shopDescription,
    String? accessInformation,
    String? termsOfUse,
    String? privacyPolicy,
    String? address,
    String? phoneNumber,
    Map<String, BusinessDayHours>? businessHours,
    String? websiteUrl,
    String? topImagePath,
    String? topImageUrl,
    bool? sitePublic,
    String? replyEmail,
    String? googleAnalyticsId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BusinessInformationModel(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      siteName: siteName ?? this.siteName,
      shopDescription: shopDescription ?? this.shopDescription,
      accessInformation: accessInformation ?? this.accessInformation,
      termsOfUse: termsOfUse ?? this.termsOfUse,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      businessHours: businessHours ?? this.businessHours,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      topImagePath: topImagePath ?? this.topImagePath,
      topImageUrl: topImageUrl ?? this.topImageUrl,
      sitePublic: sitePublic ?? this.sitePublic,
      replyEmail: replyEmail ?? this.replyEmail,
      googleAnalyticsId: googleAnalyticsId ?? this.googleAnalyticsId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shop_name': shopName,
      'site_name': siteName,
      'shop_description': shopDescription,
      'access_information': accessInformation,
      'terms_of_use': termsOfUse,
      'privacy_policy': privacyPolicy,
      'address': address,
      'phone_number': phoneNumber,
      'business_hours': businessHours.map(
        (key, value) => MapEntry(key, value.toMap()),
      ),
      'website_url': websiteUrl,
      'top_image_path': topImagePath,
      'top_image_url': topImageUrl,
      'site_public': sitePublic,
      'reply_email': replyEmail,
      'google_analytics_id': googleAnalyticsId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BusinessInformationModel.fromMap(Map<String, dynamic> map) {
    final businessHoursMap =
        map['business_hours'] as Map<String, dynamic>? ?? {};
    final businessHours = businessHoursMap.map(
      (key, value) => MapEntry(
        key,
        BusinessDayHours.fromMap(value as Map<String, dynamic>),
      ),
    );

    return BusinessInformationModel(
      id: map['id']?.toInt() ?? 0,
      shopName: map['shop_name'] ?? '',
      siteName: map['site_name'] ?? '',
      shopDescription: map['shop_description'] ?? '',
      accessInformation: map['access_information'] ?? '',
      termsOfUse: map['terms_of_use'] ?? '',
      privacyPolicy: map['privacy_policy'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      businessHours: businessHours,
      websiteUrl: map['website_url'],
      topImagePath: map['top_image_path'],
      topImageUrl: map['top_image_url'],
      sitePublic: map['site_public'] ?? false,
      replyEmail: map['reply_email'],
      googleAnalyticsId: map['google_analytics_id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  factory BusinessInformationModel.fromEntity(BusinessInformation entity) {
    return BusinessInformationModel(
      id: entity.id,
      shopName: entity.shopName,
      siteName: entity.siteName,
      shopDescription: entity.shopDescription,
      accessInformation: entity.accessInformation,
      termsOfUse: entity.termsOfUse,
      privacyPolicy: entity.privacyPolicy,
      address: entity.address,
      phoneNumber: entity.phoneNumber,
      businessHours: entity.businessHours,
      websiteUrl: entity.websiteUrl,
      topImagePath: entity.topImagePath,
      topImageUrl: entity.topImageUrl,
      sitePublic: entity.sitePublic,
      replyEmail: entity.replyEmail,
      googleAnalyticsId: entity.googleAnalyticsId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessInformationModel.fromJson(String source) =>
      BusinessInformationModel.fromMap(json.decode(source));

  @override
  String toString() => 'BusinessInformationModel(${toMap()})';
}
