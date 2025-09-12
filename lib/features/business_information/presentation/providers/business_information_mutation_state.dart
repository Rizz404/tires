import 'package:equatable/equatable.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';

enum BusinessInformationMutationStatus { initial, loading, success, error }

class BusinessInformationMutationState extends Equatable {
  final BusinessInformationMutationStatus status;
  final BusinessInformation? updatedBusinessInformation;
  final Failure? failure;
  final String? successMessage;

  const BusinessInformationMutationState({
    this.status = BusinessInformationMutationStatus.initial,
    this.updatedBusinessInformation,
    this.failure,
    this.successMessage,
  });

  BusinessInformationMutationState copyWith({
    BusinessInformationMutationStatus? status,
    BusinessInformation? updatedBusinessInformation,
    Failure? failure,
    String? successMessage,
  }) {
    return BusinessInformationMutationState(
      status: status ?? this.status,
      updatedBusinessInformation:
          updatedBusinessInformation ?? this.updatedBusinessInformation,
      failure: failure ?? this.failure,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  BusinessInformationMutationState copyWithClearError() {
    return BusinessInformationMutationState(
      status: status,
      updatedBusinessInformation: updatedBusinessInformation,
      failure: null,
      successMessage: successMessage,
    );
  }

  BusinessInformationMutationState copyWithClearSuccess() {
    return BusinessInformationMutationState(
      status: status,
      updatedBusinessInformation: updatedBusinessInformation,
      failure: failure,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    updatedBusinessInformation,
    failure,
    successMessage,
  ];
}
