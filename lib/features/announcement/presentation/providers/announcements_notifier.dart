import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_state.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';

class AnnouncementsNotifier extends Notifier<AnnouncementsState> {
  late GetAnnouncementsCursorUsecase _getUsersCursorUsecase;

  @override
  AnnouncementsState build() {
    _getUsersCursorUsecase = ref.watch(getAnnouncementsCursorUsecaseProvider);
    Future.microtask(() => getInitialAnnouncements());
    return const AnnouncementsState();
  }

  Future<void> getInitialAnnouncements({
    bool paginate = true,
    int perPage = 10,
  }) async {
    if (state.status == AnnouncementsStatus.loading) return;

    AppLogger.uiInfo('Fetching initial announcements in notifier');
    state = state.copyWith(status: AnnouncementsStatus.loading);

    final params = GetAnnouncementsCursorParams(
      paginate: paginate,
      perPage: perPage,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch initial announcements', failure);
        state = state.copyWith(
          status: AnnouncementsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'Initial announcements fetched successfully in notifier',
        );
        state = state
            .copyWith(
              status: AnnouncementsStatus.success,
              announcements: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> getAnnouncements({
    bool paginate = true,
    int perPage = 10,
  }) async {
    await getInitialAnnouncements(paginate: paginate, perPage: perPage);
  }

  Future<void> loadMore({bool paginate = true, int perPage = 10}) async {
    if (!state.hasNextPage || state.status == AnnouncementsStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more announcements in notifier');
    state = state.copyWith(status: AnnouncementsStatus.loadingMore);

    final params = GetAnnouncementsCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more announcements', failure);
        state = state.copyWith(
          status: AnnouncementsStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('More announcements loaded successfully in notifier');
        final List<Announcement> alls = [
          ...state.announcements,
          ...success.data ?? <Announcement>[],
        ];
        state = state
            .copyWith(
              status: AnnouncementsStatus.success,
              announcements: alls,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refresh({bool paginate = true, int perPage = 10}) async {
    await getInitialAnnouncements(paginate: paginate, perPage: perPage);
  }

  void clearState() {
    state = const AnnouncementsState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
