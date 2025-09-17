import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/business_information/domain/usecases/get_business_information_usecase.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_state.dart';

class BusinessInformationNotifier extends Notifier<BusinessInformationState> {
  late GetBusinessInformationUsecase _getBusinessInformationUsecase;

  @override
  BusinessInformationState build() {
    _getBusinessInformationUsecase = ref.watch(
      getBusinessInformationUsecaseProvider,
    );
    Future.microtask(() => getBusinessInformation());
    return const BusinessInformationState();
  }

  Future<void> getBusinessInformation() async {
    if (state.status == BusinessInformationStatus.loading) return;

    AppLogger.uiInfo('Getting business information');
    state = state.copyWith(status: BusinessInformationStatus.loading);

    final response = await _getBusinessInformationUsecase(NoParams());

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to get business information', failure);
        state = state.copyWith(
          status: BusinessInformationStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Business information loaded successfully');
        state = state
            .copyWith(
              status: BusinessInformationStatus.success,
              businessInformation: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh() async {
    AppLogger.uiInfo('Refreshing business information');
    await getBusinessInformation();
  }

  void clearState() {
    AppLogger.uiInfo('Clearing business information state');
    state = const BusinessInformationState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing business information error');
      state = state.copyWithClearError();
    }
  }
}
