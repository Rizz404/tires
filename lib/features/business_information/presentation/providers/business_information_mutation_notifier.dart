import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/business_information/domain/usecases/update_business_information_usecase.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_mutation_state.dart';

class BusinessInformationMutationNotifier
    extends StateNotifier<BusinessInformationMutationState> {
  final UpdateBusinessInformationUsecase _updateBusinessInformationUsecase;

  BusinessInformationMutationNotifier(this._updateBusinessInformationUsecase)
    : super(const BusinessInformationMutationState());

  Future<void> updateBusinessInformation(
    UpdateBusinessInformationParams params,
  ) async {
    state = state.copyWith(status: BusinessInformationMutationStatus.loading);

    final response = await _updateBusinessInformationUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: BusinessInformationMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: BusinessInformationMutationStatus.success,
              updatedBusinessInformation: success.data,
              successMessage:
                  success.message ??
                  'Business information updated successfully',
            )
            .copyWithClearError();
      },
    );
  }

  void clearState() {
    state = const BusinessInformationMutationState();
  }

  void clearError() {
    if (state.failure != null) {
      state = state.copyWithClearError();
    }
  }

  void clearSuccess() {
    if (state.successMessage != null) {
      state = state.copyWithClearSuccess();
    }
  }
}
