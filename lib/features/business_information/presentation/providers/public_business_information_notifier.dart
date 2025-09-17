import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/business_information/domain/usecases/get_public_business_information_usecase.dart';
import 'package:tires/features/business_information/presentation/providers/public_business_information_state.dart';

class PublicBusinessInformationNotifier
    extends Notifier<PublicBusinessInformationState> {
  late GetPublicBusinessInformationUsecase _getPublicBusinessInformationUsecase;

  @override
  PublicBusinessInformationState build() {
    _getPublicBusinessInformationUsecase = ref.watch(
      getPublicBusinessInformationUsecaseProvider,
    );
    Future.microtask(() => getPublicBusinessInformation());
    return const PublicBusinessInformationState();
  }

  Future<void> getPublicBusinessInformation() async {
    if (state.status == PublicBusinessInformationStatus.loading) return;

    AppLogger.uiInfo('Getting public business information');
    state = state.copyWith(status: PublicBusinessInformationStatus.loading);

    final response = await _getPublicBusinessInformationUsecase(NoParams());

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to get public business information', failure);
        state = state.copyWith(
          status: PublicBusinessInformationStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Public business information loaded successfully');
        state = state
            .copyWith(
              status: PublicBusinessInformationStatus.success,
              businessInformation: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh() async {
    AppLogger.uiInfo('Refreshing public business information');
    await getPublicBusinessInformation();
  }

  void clearState() {
    AppLogger.uiInfo('Clearing public business information state');
    state = const PublicBusinessInformationState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing public business information error');
      state = state.copyWithClearError();
    }
  }
}
