import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/customer_management/domain/usecases/get_current_user_dashboard_usecase.dart';
import 'package:tires/features/customer_management/presentation/providers/current_user_dashboard_get_state.dart';

class CurrentUserDashboardGetNotifier
    extends Notifier<CurrentUserDashboardGetState> {
  late GetCurrentUserDashboardUsecase _getCurrentUserDashboardUsecase;

  @override
  CurrentUserDashboardGetState build() {
    _getCurrentUserDashboardUsecase = ref.watch(
      getCurrentUserDashboardUsecaseProvider,
    );
    Future.microtask(() => getInitialDashboard());
    return const CurrentUserDashboardGetState();
  }

  Future<void> getInitialDashboard() async {
    // Prevent duplicate loading if already in progress
    if (state.status == CurrentUserDashboardGetStatus.loading) return;

    state = state.copyWith(status: CurrentUserDashboardGetStatus.loading);

    final params = NoParams();
    final response = await _getCurrentUserDashboardUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: CurrentUserDashboardGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: CurrentUserDashboardGetStatus.success,
              dashboard: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> getCurrentUserDashboard() async {
    await getInitialDashboard();
  }

  Future<void> refreshDashboard() async {
    await getInitialDashboard();
  }

  void clearState() {
    state = const CurrentUserDashboardGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
