import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
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

    AppLogger.uiInfo('Getting initial dashboard');
    state = state.copyWith(status: CurrentUserDashboardGetStatus.loading);

    final params = NoParams();
    final response = await _getCurrentUserDashboardUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to get initial dashboard', failure);
        state = state.copyWith(
          status: CurrentUserDashboardGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Initial dashboard loaded successfully');
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
    AppLogger.uiInfo('Getting current user dashboard');
    await getInitialDashboard();
  }

  Future<void> refreshDashboard() async {
    AppLogger.uiInfo('Refreshing dashboard');
    await getInitialDashboard();
  }

  void clearState() {
    AppLogger.uiInfo('Clearing dashboard state');
    state = const CurrentUserDashboardGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing dashboard error');
      state = state.copyWithClearError();
    }
  }
}
