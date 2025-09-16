import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    state = state.copyWith(status: BusinessInformationStatus.loading);

    final response = await _getBusinessInformationUsecase(NoParams());

    response.fold(
      (failure) {
        state = state.copyWith(
          status: BusinessInformationStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
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
    await getBusinessInformation();
  }

  void clearState() {
    state = const BusinessInformationState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
