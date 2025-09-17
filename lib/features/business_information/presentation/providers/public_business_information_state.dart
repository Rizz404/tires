import 'package:equatable/equatable.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';

enum PublicBusinessInformationStatus { initial, loading, success, error }

class PublicBusinessInformationState extends Equatable {
  final PublicBusinessInformationStatus status;
  final BusinessInformation? businessInformation;
  final String? errorMessage;

  const PublicBusinessInformationState({
    this.status = PublicBusinessInformationStatus.initial,
    this.businessInformation,
    this.errorMessage,
  });

  PublicBusinessInformationState copyWith({
    PublicBusinessInformationStatus? status,
    BusinessInformation? businessInformation,
    String? errorMessage,
  }) {
    return PublicBusinessInformationState(
      status: status ?? this.status,
      businessInformation: businessInformation ?? this.businessInformation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  PublicBusinessInformationState copyWithClearError() {
    return PublicBusinessInformationState(
      status: status,
      businessInformation: businessInformation,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, businessInformation, errorMessage];
}
