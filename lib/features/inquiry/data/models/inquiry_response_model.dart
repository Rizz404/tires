import 'dart:convert';

import 'package:tires/features/inquiry/domain/entities/inquiry_response.dart'; // Sesuaikan path jika berbeda

class InquiryResponseModel extends InquiryResponse {
  const InquiryResponseModel({
    required super.inquiryId,
    required super.referenceNumber,
    required super.submittedBy,
    required super.email,
    required super.autoFilled,
  });

  factory InquiryResponseModel.fromMap(Map<String, dynamic> map) {
    return InquiryResponseModel(
      inquiryId: map['inquiry_id'] as int,
      referenceNumber: map['reference_number'] as String,
      submittedBy: map['submitted_by'] as String,
      email: map['email'] as String,
      autoFilled: map['auto_filled'] as bool,
    );
  }

  factory InquiryResponseModel.fromJson(String source) =>
      InquiryResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory InquiryResponseModel.fromEntity(InquiryResponse entity) {
    return InquiryResponseModel(
      inquiryId: entity.inquiryId,
      referenceNumber: entity.referenceNumber,
      submittedBy: entity.submittedBy,
      email: entity.email,
      autoFilled: entity.autoFilled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inquiry_id': inquiryId,
      'reference_number': referenceNumber,
      'submitted_by': submittedBy,
      'email': email,
      'auto_filled': autoFilled,
    };
  }

  String toJson() => json.encode(toMap());

  InquiryResponseModel copyWith({
    int? inquiryId,
    String? referenceNumber,
    String? submittedBy,
    String? email,
    bool? autoFilled,
  }) {
    return InquiryResponseModel(
      inquiryId: inquiryId ?? this.inquiryId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      submittedBy: submittedBy ?? this.submittedBy,
      email: email ?? this.email,
      autoFilled: autoFilled ?? this.autoFilled,
    );
  }
}
