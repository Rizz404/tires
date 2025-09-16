import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    state = state.copyWith(status: MenuStatisticsStatus.loading);

    final params = GetMenuStatisticsParams();

    final response = await _getMenuStatisticsUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: MenuStatisticsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
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
    await getMenuStatistics();
  }
}
