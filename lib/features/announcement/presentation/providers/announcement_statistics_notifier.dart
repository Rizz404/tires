import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcement_statistics_usecase.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_statistics_state.dart';

class AnnouncementStatisticsNotifier
    extends Notifier<AnnouncementStatisticsState> {
  late GetAnnouncementStatisticsUsecase _getAnnouncementStatisticsUsecase;

  @override
  AnnouncementStatisticsState build() {
    _getAnnouncementStatisticsUsecase = ref.watch(
      getAnnouncementStatisticsUsecaseProvider,
    );
    Future.microtask(() => getAnnouncementStatistics());
    return const AnnouncementStatisticsState();
  }

  Future<void> getAnnouncementStatistics() async {
    if (state.status == AnnouncementStatisticsStatus.loading) return;

    AppLogger.uiInfo('Fetching announcement statistics in notifier');
    state = state.copyWith(status: AnnouncementStatisticsStatus.loading);

    final params = GetAnnouncementStatisticsParams();

    final response = await _getAnnouncementStatisticsUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch announcement statistics', failure);
        state = state.copyWith(
          status: AnnouncementStatisticsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'Announcement statistics fetched successfully in notifier',
        );
        state = state
            .copyWith(
              status: AnnouncementStatisticsStatus.success,
              statistics: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh() async {
    await getAnnouncementStatistics();
  }
}
