import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/menu/domain/usecases/get_menu_statistics_usecase.dart';
import 'package:tires/features/menu/presentation/providers/menu_statistics_state.dart';

class MenuStatisticsNotifier extends Notifier<MenuStatisticsState> {
  late GetMenuStatisticsUsecase _getMenuStatisticsUsecase;

  @override
  MenuStatisticsState build() {
    _getMenuStatisticsUsecase = ref.watch(getMenuStatisticsUsecaseProvider);
    Future.microtask(() => getMenuStatistics());
    return const MenuStatisticsState();
  }

  Future<void> getMenuStatistics() async {
    if (state.status == MenuStatisticsStatus.loading) return;

    AppLogger.uiInfo('Loading menu statistics');
    state = state.copyWith(status: MenuStatisticsStatus.loading);

    final params = GetMenuStatisticsParams();

    final response = await _getMenuStatisticsUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load menu statistics', failure);
        state = state.copyWith(
          status: MenuStatisticsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully loaded menu statistics');
        state = state
            .copyWith(
              status: MenuStatisticsStatus.success,
              statistics: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh() async {
    AppLogger.uiInfo('Refreshing menu statistics');
    await getMenuStatistics();
  }
}
