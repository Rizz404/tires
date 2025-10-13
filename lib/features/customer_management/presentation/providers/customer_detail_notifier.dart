import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_detail_usecase.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_detail_state.dart';

class CustomerDetailNotifier extends Notifier<CustomerDetailState> {
  late GetCustomerDetailUsecase _getCustomerDetailUsecase;

  @override
  CustomerDetailState build() {
    _getCustomerDetailUsecase = ref.watch(getCustomerDetailUsecaseProvider);
    return const CustomerDetailState();
  }

  Future<void> getCustomerDetail(String id) async {
    if (state.status == CustomerDetailStatus.loading) return;

    AppLogger.uiInfo('Fetching customer detail for id: $id in notifier');
    state = state.copyWith(status: CustomerDetailStatus.loading);

    final response = await _getCustomerDetailUsecase(
      GetCustomerDetailParams(id: id),
    );

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch customer detail', failure);
        state = state.copyWith(
          status: CustomerDetailStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Customer detail fetched successfully in notifier');
        state = state
            .copyWith(
              status: CustomerDetailStatus.success,
              customerDetail: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh(String id) async {
    await getCustomerDetail(id);
  }
}
