import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customers_cursor_usecase.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_state.dart';

class CustomersSearchNotifier extends Notifier<CustomersState> {
  late GetCustomersCursorUsecase _getCustomersCursorUsecase;

  @override
  CustomersState build() {
    _getCustomersCursorUsecase = ref.watch(getCustomersCursorUsecaseProvider);
    return const CustomersState();
  }

  Future<void> searchCustomers({
    required String search,
    String? status,
    int perPage = 10,
  }) async {
    if (state.status == CustomersStatus.loading) return;

    AppLogger.uiInfo('Searching customers in notifier');
    state = state.copyWith(status: CustomersStatus.loading);

    final params = GetCustomerCursorParams(
      paginate: true,
      perPage: perPage,
      search: search,
      status: status,
    );

    final response = await _getCustomersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to search customers', failure);
        state = state.copyWith(
          status: CustomersStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Customers searched successfully in notifier');
        state = state
            .copyWith(
              status: CustomersStatus.success,
              customers: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> loadMoreSearchResults({
    required String search,
    String? status,
    int perPage = 10,
  }) async {
    if (!state.hasNextPage || state.status == CustomersStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more search results in notifier');
    state = state.copyWith(status: CustomersStatus.loadingMore);

    final params = GetCustomerCursorParams(
      paginate: true,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
      search: search,
      status: status,
    );

    final response = await _getCustomersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more search results', failure);
        state = state.copyWith(
          status: CustomersStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'More search results loaded successfully in notifier',
        );
        final List<Customer> allCustomers = [
          ...state.customers,
          ...success.data ?? <Customer>[],
        ];
        state = state
            .copyWith(
              status: CustomersStatus.success,
              customers: allCustomers,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  void clearSearch() {
    AppLogger.uiInfo('Clearing search results');
    state = const CustomersState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
