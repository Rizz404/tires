import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/business_information/domain/repositories/business_information_repository.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';

class UpdateBusinessInformationUsecase
    implements
        Usecase<
          ItemSuccessResponse<BusinessInformation>,
          UpdateBusinessInformationParams
        > {
  final BusinessInformationRepository repository;

  UpdateBusinessInformationUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>> call(
    UpdateBusinessInformationParams params,
  ) {
    return repository.updateBusinessInformation(params);
  }
}

class UpdateBusinessInformationParams extends Equatable {
  final String? shopName;
  final String? siteName;
  final String? shopDescription;
  final String? accessInformation;
  final String? termsOfUse;
  final String? privacyPolicy;
  final String? address;
  final String? phoneNumber;
  final Map<String, dynamic>? businessHours;
  final String? websiteUrl;
  final File? topImage;
  final bool? sitePublic;
  final String? replyEmail;
  final String? googleAnalyticsId;

  const UpdateBusinessInformationParams({
    this.shopName,
    this.siteName,
    this.shopDescription,
    this.accessInformation,
    this.termsOfUse,
    this.privacyPolicy,
    this.address,
    this.phoneNumber,
    this.businessHours,
    this.websiteUrl,
    this.topImage,
    this.sitePublic,
    this.replyEmail,
    this.googleAnalyticsId,
  });

  UpdateBusinessInformationParams copyWith({
    String? shopName,
    String? siteName,
    String? shopDescription,
    String? accessInformation,
    String? termsOfUse,
    String? privacyPolicy,
    String? address,
    String? phoneNumber,
    Map<String, dynamic>? businessHours,
    String? websiteUrl,
    File? topImage,
    bool? sitePublic,
    String? replyEmail,
    String? googleAnalyticsId,
  }) {
    return UpdateBusinessInformationParams(
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
      topImage: topImage ?? this.topImage,
      sitePublic: sitePublic ?? this.sitePublic,
      replyEmail: replyEmail ?? this.replyEmail,
      googleAnalyticsId: googleAnalyticsId ?? this.googleAnalyticsId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (shopName != null) 'shop_name': shopName,
      if (siteName != null) 'site_name': siteName,
      if (shopDescription != null) 'shop_description': shopDescription,
      if (accessInformation != null) 'access_information': accessInformation,
      if (termsOfUse != null) 'terms_of_use': termsOfUse,
      if (privacyPolicy != null) 'privacy_policy': privacyPolicy,
      if (address != null) 'address': address,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (businessHours != null) 'business_hours': businessHours,
      if (websiteUrl != null) 'website_url': websiteUrl,
      if (sitePublic != null) 'site_public': sitePublic,
      if (replyEmail != null) 'reply_email': replyEmail,
      if (googleAnalyticsId != null) 'google_analytics_id': googleAnalyticsId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
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
    topImage,
    sitePublic,
    replyEmail,
    googleAnalyticsId,
  ];
}
