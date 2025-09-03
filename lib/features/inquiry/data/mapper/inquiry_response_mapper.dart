import 'package:tires/features/inquiry/data/models/inquiry_response_model.dart';
import 'package:tires/features/inquiry/domain/entities/inquiry_response.dart';

extension InquiryResponseModelMapper on InquiryResponseModel {
  InquiryResponse toEntity() {
    return InquiryResponse(
      inquiryId: inquiryId,
      referenceNumber: referenceNumber,
      submittedBy: submittedBy,
      email: email,
      autoFilled: autoFilled,
    );
  }
}

extension InquiryResponseEntityMapper on InquiryResponse {
  InquiryResponseModel toModel() {
    return InquiryResponseModel.fromEntity(this);
  }
}
