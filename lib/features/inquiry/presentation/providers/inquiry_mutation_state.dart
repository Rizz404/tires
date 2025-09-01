import 'package:equatable/equatable.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/inquiry/domain/entities/contact.dart';

enum InquiryMutationStatus { initial, loading, success, error }

class InquiryMutationState extends Equatable {
  final InquiryMutationStatus status;
  final Contact? createdContact;
  final Failure? failure;
  final String? successMessage;

  const InquiryMutationState({
    this.status = InquiryMutationStatus.initial,
    this.createdContact,
    this.failure,
    this.successMessage,
  });

  InquiryMutationState copyWith({
    InquiryMutationStatus? status,
    Contact? createdContact,
    Failure? failure,
    String? successMessage,
  }) {
    return InquiryMutationState(
      status: status ?? this.status,
      createdContact: createdContact ?? this.createdContact,
      failure: failure ?? this.failure,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  InquiryMutationState copyWithClearError() {
    return InquiryMutationState(
      status: status,
      createdContact: createdContact,
      failure: null,
      successMessage: successMessage,
    );
  }

  InquiryMutationState copyWithClearSuccess() {
    return InquiryMutationState(
      status: status,
      createdContact: createdContact,
      failure: failure,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, createdContact, failure, successMessage];
}
