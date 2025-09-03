import 'package:equatable/equatable.dart';

class InquiryResponse extends Equatable {
  final int inquiryId;
  final String referenceNumber;
  final String submittedBy;
  final String email;
  final bool autoFilled;

  const InquiryResponse({
    required this.inquiryId,
    required this.referenceNumber,
    required this.submittedBy,
    required this.email,
    required this.autoFilled,
  });

  @override
  List<Object> get props {
    return [inquiryId, referenceNumber, submittedBy, email, autoFilled];
  }
}
