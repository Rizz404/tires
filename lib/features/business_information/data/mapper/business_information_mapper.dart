import 'package:tires/features/business_information/data/models/business_information_model.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';

extension BusinessInformationModelMapper on BusinessInformationModel {
  BusinessInformation toEntity() {
    return BusinessInformation(
      id: id,
      shopName: shopName,
      siteName: siteName,
      shopDescription: shopDescription,
      accessInformation: accessInformation,
      termsOfUse: termsOfUse,
      privacyPolicy: privacyPolicy,
      address: address,
      phoneNumber: phoneNumber,
      businessHours: businessHours,
      websiteUrl: websiteUrl,
      topImagePath: topImagePath,
      topImageUrl: topImageUrl,
      sitePublic: sitePublic,
      replyEmail: replyEmail,
      googleAnalyticsId: googleAnalyticsId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BusinessInformationEntityMapper on BusinessInformation {
  BusinessInformationModel toModel() {
    return BusinessInformationModel(
      id: id,
      shopName: shopName,
      siteName: siteName,
      shopDescription: shopDescription,
      accessInformation: accessInformation,
      termsOfUse: termsOfUse,
      privacyPolicy: privacyPolicy,
      address: address,
      phoneNumber: phoneNumber,
      businessHours: businessHours,
      websiteUrl: websiteUrl,
      topImagePath: topImagePath,
      topImageUrl: topImageUrl,
      sitePublic: sitePublic,
      replyEmail: replyEmail,
      googleAnalyticsId: googleAnalyticsId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
