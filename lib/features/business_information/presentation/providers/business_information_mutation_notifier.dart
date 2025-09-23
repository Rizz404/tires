import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/business_information/domain/usecases/update_business_information_usecase.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_mutation_state.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_providers.dart';

class BusinessInformationMutationNotifier
    extends Notifier<BusinessInformationMutationState> {
  late UpdateBusinessInformationUsecase _updateBusinessInformationUsecase;

  @override
  BusinessInformationMutationState build() {
    _updateBusinessInformationUsecase = ref.watch(
      updateBusinessInformationUsecaseProvider,
    );
    return const BusinessInformationMutationState();
  }

  Future<void> updateBusinessInformation(
    UpdateBusinessInformationParams params,
  ) async {
    AppLogger.uiInfo('Updating business information');
    state = state.copyWith(status: BusinessInformationMutationStatus.loading);

    final response = await _updateBusinessInformationUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to update business information', failure);
        state = state.copyWith(
          status: BusinessInformationMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Business information updated successfully');
        state = state
            .copyWith(
              status: BusinessInformationMutationStatus.success,
              updatedBusinessInformation: success.data,
              successMessage:
                  success.message ??
                  'Business information updated successfully',
            )
            .copyWithClearError();
        ref.invalidate(businessInformationGetNotifierProvider);
      },
    );
  }

  void clearState() {
    AppLogger.uiInfo('Clearing business information mutation state');
    state = const BusinessInformationMutationState();
  }

  void clearError() {
    if (state.failure != null) {
      AppLogger.uiInfo('Clearing business information mutation error');
      state = state.copyWithClearError();
    }
  }

  void clearSuccess() {
    if (state.successMessage != null) {
      AppLogger.uiInfo('Clearing business information mutation success');
      state = state.copyWithClearSuccess();
    }
  }
}
