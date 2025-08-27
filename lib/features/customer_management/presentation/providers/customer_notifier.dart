import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_state.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';

class CustomerNotifier extends StateNotifier<CustomerState> {
  final GetCustomerCursorUsecase _getCustomersUsecase;

  CustomerNotifier(this._getCustomersUsecase) : super(const CustomerState()) {
    getInitialCustomers();
  }

  Future<void> getInitialCustomers() async {
    if (state.status == CustomerStatus.loading) return;

    state = state.copyWith(status: CustomerStatus.loading);

    final result = await _getCustomersUsecase(
      const GetCustomerCursorParams(paginate: true, perPage: 15),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: CustomerStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
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
        state = state.copyWith(
          status: CustomerStatus.loaded,
          errorMessage: failure.message,
        );
      },
      (success) {
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
    await getInitialCustomers();
  }
}
