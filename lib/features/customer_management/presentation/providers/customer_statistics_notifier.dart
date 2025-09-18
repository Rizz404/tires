import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_statistics_usecase.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_statistics_state.dart';

class CustomerStatisticsNotifier extends Notifier<CustomerStatisticsState> {
  late GetCustomerStatisticsUsecase _getCustomerStatisticsUsecase;

  @override
  CustomerStatisticsState build() {
    _getCustomerStatisticsUsecase = ref.watch(
      getCustomerStatisticsUsecaseProvider,
    );
    Future.microtask(() => getStatistics());
    return const CustomerStatisticsState();
  }

  Future<void> getStatistics() async {
    if (state.status == CustomerStatisticsStatus.loading) return;

    AppLogger.uiInfo('Fetching customer statistics in notifier');
    state = state.copyWith(status: CustomerStatisticsStatus.loading);

    final response = await _getCustomerStatisticsUsecase(NoParams());

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch customer statistics', failure);
        state = state.copyWith(
          status: CustomerStatisticsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'Customer statistics fetched successfully in notifier',
        );
        state = state
            .copyWith(
              status: CustomerStatisticsStatus.success,
              statistics: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh() async {
    await getStatistics();
  }

  void clearState() {
    state = const CustomerStatisticsState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
