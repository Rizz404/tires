import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/bussiness_information/domain/usecases/get_business_information_usecase.dart';
import 'package:tires/features/bussiness_information/presentation/providers/business_information_state.dart';
import 'package:tires/core/usecases/usecase.dart';

class BusinessInformationNotifier
    extends StateNotifier<BusinessInformationState> {
  final GetBusinessInformationUsecase _getBusinessInformationUsecase;

  BusinessInformationNotifier(this._getBusinessInformationUsecase)
    : super(const BusinessInformationState()) {
    getBusinessInformation();
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
