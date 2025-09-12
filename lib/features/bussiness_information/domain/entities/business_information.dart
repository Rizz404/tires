import 'package:equatable/equatable.dart';

class BusinessInformation extends Equatable {
  final int id;
  final String shopName;
  final String siteName;
  final String shopDescription;
  final String accessInformation;
  final String termsOfUse;
  final String privacyPolicy;
  final String address;
  final String phoneNumber;
  final Map<String, dynamic> businessHours;
  final String? websiteUrl;
  final String? topImagePath;
  final String? topImageUrl;
  final bool sitePublic;
  final String? replyEmail;
  final String? googleAnalyticsId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BusinessInformation({
    required this.id,
    required this.shopName,
    required this.siteName,
    required this.shopDescription,
    required this.accessInformation,
    required this.termsOfUse,
    required this.privacyPolicy,
    required this.address,
    required this.phoneNumber,
    required this.businessHours,
    this.websiteUrl,
    this.topImagePath,
    this.topImageUrl,
    required this.sitePublic,
    this.replyEmail,
    this.googleAnalyticsId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    shopName,
    siteName,
    shopDescription,
    accessInformation,
    termsOfUse,
    privacyPolicy,
    address,
    phoneNumber,
    businessHours,
    websiteUrl,
    topImagePath,
    topImageUrl,
    sitePublic,
    replyEmail,
    googleAnalyticsId,
    createdAt,
    updatedAt,
  ];
}
