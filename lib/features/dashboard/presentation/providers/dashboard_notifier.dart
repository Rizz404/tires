import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/dashboard/domain/usecases/get_dashboard_usecase.dart';
import 'package:tires/features/dashboard/presentation/providers/dashboard_state.dart';

class DashboardNotifier extends Notifier<DashboardState> {
  late GetDashboardUsecase _getDashboardUsecase;

  @override
  DashboardState build() {
    _getDashboardUsecase = ref.watch(getDashboardUsecaseProvider);
    Future.microtask(() => getDashboard());
    return const DashboardState();
  }

  Future<void> getDashboard() async {
    if (state.status == DashboardStatus.loading) return;

    AppLogger.uiInfo('Getting dashboard');
    state = state.copyWith(status: DashboardStatus.loading);

    final response = await _getDashboardUsecase(NoParams());

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to get dashboard', failure);
        state = state.copyWith(
          status: DashboardStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Dashboard loaded successfully');
        state = state
            .copyWith(status: DashboardStatus.success, dashboard: success.data)
            .copyWithClearError();
      },
    );
  }

  Future<void> refreshDashboard() async {
    AppLogger.uiInfo('Refreshing dashboard');
    await getDashboard();
  }
}
