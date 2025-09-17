import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_state.dart';

class CustomerNotifier extends Notifier<CustomerState> {
  late final GetCustomerCursorUsecase _getCustomersUsecase;

  @override
  CustomerState build() {
    _getCustomersUsecase = ref.watch(getCustomerCursorUsecaseProvider);
    Future.microtask(() => getInitialCustomers());
    return const CustomerState();
  }

  Future<void> getInitialCustomers() async {
    if (state.status == CustomerStatus.loading) return;

    AppLogger.uiInfo('Getting initial customers');
    state = state.copyWith(status: CustomerStatus.loading);

    final result = await _getCustomersUsecase(
      const GetCustomerCursorParams(paginate: true, perPage: 15),
    );

    result.fold(
      (failure) {
        AppLogger.uiError('Failed to get initial customers', failure);
        state = state.copyWith(
          status: CustomerStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Initial customers loaded successfully');
        state = state.copyWith(
          status: CustomerStatus.loaded,
          customers: success.data ?? [],
          hasNextPage: success.cursor?.hasNextPage,
          nextCursor: success.cursor?.nextCursor,
          forceErrorMessageNull: true,
        );
      },
    );
  }

  Future<void> loadMoreCustomers() async {
    if (state.status == CustomerStatus.loadingMore || !state.hasNextPage)
      return;

    AppLogger.uiInfo('Loading more customers');
    state = state.copyWith(status: CustomerStatus.loadingMore);

    final result = await _getCustomersUsecase(
      GetCustomerCursorParams(
        paginate: true,
        perPage: 15,
        cursor: state.nextCursor,
      ),
    );

    result.fold(
      (failure) {
        AppLogger.uiError('Failed to load more customers', failure);
        state = state.copyWith(
          status: CustomerStatus.loaded,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('More customers loaded successfully');
        state = state.copyWith(
          status: CustomerStatus.loaded,
          customers: [...state.customers, ...success.data ?? []],
          hasNextPage: success.cursor?.hasNextPage,
          nextCursor: success.cursor?.nextCursor,
        );
      },
    );
  }

  Future<void> refreshCustomers() async {
    AppLogger.uiInfo('Refreshing customers');
    await getInitialCustomers();
  }
}
