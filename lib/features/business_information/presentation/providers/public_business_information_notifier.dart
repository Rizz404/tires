import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    state = state.copyWith(status: PublicBusinessInformationStatus.loading);

    final response = await _getPublicBusinessInformationUsecase(NoParams());

    response.fold(
      (failure) {
        state = state.copyWith(
          status: PublicBusinessInformationStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
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
    await getPublicBusinessInformation();
  }

  void clearState() {
    state = const PublicBusinessInformationState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
