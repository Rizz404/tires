import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/user/domain/usecases/get_current_user_dashboard_usecase.dart';
import 'package:tires/features/user/presentation/providers/current_user_dashboard_get_state.dart';

class CurrentUserDashboardGetNotifier
    extends StateNotifier<CurrentUserDashboardGetState> {
  final GetCurrentUserDashboardUsecase _getCurrentUserDashboardUsecase;

  CurrentUserDashboardGetNotifier(this._getCurrentUserDashboardUsecase)
    : super(const CurrentUserDashboardGetState()) {
    getInitialDashboard();
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
