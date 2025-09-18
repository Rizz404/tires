import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_state.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class CustomersNotifier extends Notifier<CustomersState> {
  late GetCustomerCursorUsecase _getCustomerCursorUsecase;

  @override
  CustomersState build() {
    _getCustomerCursorUsecase = ref.watch(getCustomerCursorUsecaseProvider);
    Future.microtask(() => getInitialCustomers());
    return const CustomersState();
  }

  Future<void> getInitialCustomers({
    bool paginate = true,
    int perPage = 10,
    String? search,
    String? status,
  }) async {
    if (state.status == CustomersStatus.loading) return;

    AppLogger.uiInfo('Fetching initial customers in notifier');
    state = state.copyWith(status: CustomersStatus.loading);

    final params = GetCustomerCursorParams(
      paginate: paginate,
      perPage: perPage,
      search: search,
      status: status,
    );

    final response = await _getCustomerCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch initial customers', failure);
        state = state.copyWith(
          status: CustomersStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Initial customers fetched successfully in notifier');
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

  Future<void> getCustomers({
    bool paginate = true,
    int perPage = 10,
    String? search,
    String? status,
  }) async {
    await getInitialCustomers(
      paginate: paginate,
      perPage: perPage,
      search: search,
      status: status,
    );
  }

  Future<void> loadMore({
    bool paginate = true,
    int perPage = 10,
    String? search,
    String? status,
  }) async {
    if (!state.hasNextPage || state.status == CustomersStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more customers in notifier');
    state = state.copyWith(status: CustomersStatus.loadingMore);

    final params = GetCustomerCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
      search: search,
      status: status,
    );

    final response = await _getCustomerCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more customers', failure);
        state = state.copyWith(
          status: CustomersStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('More customers loaded successfully in notifier');
        final List<User> allCustomers = [
          ...state.customers,
          ...success.data ?? <User>[],
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

  Future<void> refresh({
    bool paginate = true,
    int perPage = 10,
    String? search,
    String? status,
  }) async {
    await getInitialCustomers(
      paginate: paginate,
      perPage: perPage,
      search: search,
      status: status,
    );
  }

  void clearState() {
    state = const CustomersState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
