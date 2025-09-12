import 'package:equatable/equatable.dart';
import 'package:tires/features/bussiness_information/domain/entities/business_information.dart';

enum BusinessInformationStatus { initial, loading, success, error }

class BusinessInformationState extends Equatable {
  final BusinessInformationStatus status;
  final BusinessInformation? businessInformation;
  final String? errorMessage;

  const BusinessInformationState({
    this.status = BusinessInformationStatus.initial,
    this.businessInformation,
    this.errorMessage,
  });

  BusinessInformationState copyWith({
    BusinessInformationStatus? status,
    BusinessInformation? businessInformation,
    String? errorMessage,
  }) {
    return BusinessInformationState(
      status: status ?? this.status,
      businessInformation: businessInformation ?? this.businessInformation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  BusinessInformationState copyWithClearError() {
    return BusinessInformationState(
      status: status,
      businessInformation: businessInformation,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, businessInformation, errorMessage];
}
