import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/contact/domain/usecases/get_contact_statistics_usecase.dart';
import 'package:tires/features/contact/presentation/providers/contact_statistics_state.dart';

class ContactStatisticsNotifier extends Notifier<ContactStatisticsState> {
  late GetContactStatisticsUsecase _getContactStatisticsUsecase;

  @override
  ContactStatisticsState build() {
    _getContactStatisticsUsecase = ref.watch(
      getContactStatisticsUsecaseProvider,
    );
    Future.microtask(() => getContactStatistics());
    return const ContactStatisticsState();
  }

  Future<void> getContactStatistics() async {
    if (state.status == ContactStatisticsStatus.loading) return;

    AppLogger.uiInfo('Fetching contact statistics in notifier');
    state = state.copyWith(status: ContactStatisticsStatus.loading);

    final params = GetContactStatisticsParams();

    final response = await _getContactStatisticsUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch contact statistics', failure);
        state = state.copyWith(
          status: ContactStatisticsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'Contact statistics fetched successfully in notifier',
        );
        state = state
            .copyWith(
              status: ContactStatisticsStatus.success,
              statistics: success.data,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh() async {
    await getContactStatistics();
  }
}
