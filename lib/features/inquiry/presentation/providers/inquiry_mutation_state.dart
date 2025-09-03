import 'package:equatable/equatable.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/inquiry/domain/entities/inquiry_response.dart';

enum InquiryMutationStatus { initial, loading, success, error }

class InquiryMutationState extends Equatable {
  final InquiryMutationStatus status;
  final InquiryResponse? createdInquiryResponse;
  final Failure? failure;
  final String? successMessage;

  const InquiryMutationState({
    this.status = InquiryMutationStatus.initial,
    this.createdInquiryResponse,
    this.failure,
    this.successMessage,
  });

  InquiryMutationState copyWith({
    InquiryMutationStatus? status,
    InquiryResponse? createdInquiryResponse,
    Failure? failure,
    String? successMessage,
  }) {
    return InquiryMutationState(
      status: status ?? this.status,
      createdInquiryResponse:
          createdInquiryResponse ?? this.createdInquiryResponse,
      failure: failure ?? this.failure,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  InquiryMutationState copyWithClearError() {
    return InquiryMutationState(
      status: status,
      createdInquiryResponse: createdInquiryResponse,
      failure: null,
      successMessage: successMessage,
    );
  }

  InquiryMutationState copyWithClearSuccess() {
    return InquiryMutationState(
      status: status,
      createdInquiryResponse: createdInquiryResponse,
      failure: failure,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    createdInquiryResponse,
    failure,
    successMessage,
  ];
}
