import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_state.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';

class AnnouncementsSearchNotifier extends Notifier<AnnouncementsState> {
  late GetAnnouncementsCursorUsecase _getAnnouncementsCursorUsecase;

  @override
  AnnouncementsState build() {
    _getAnnouncementsCursorUsecase = ref.watch(
      getAnnouncementsCursorUsecaseProvider,
    );
    return const AnnouncementsState();
  }

  Future<void> searchAnnouncements({
    required String search,
    String? status,
    DateTime? publishedAt,
    int perPage = 10,
  }) async {
    if (state.status == AnnouncementsStatus.loading) return;

    AppLogger.uiInfo('Searching announcements in notifier');
    state = state.copyWith(status: AnnouncementsStatus.loading);

    final params = GetAnnouncementsCursorParams(
      paginate: true,
      perPage: perPage,
      search: search,
      status: status,
      publishedAt: publishedAt,
    );

    final response = await _getAnnouncementsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to search announcements', failure);
        state = state.copyWith(
          status: AnnouncementsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Announcements searched successfully in notifier');
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

  Future<void> loadMoreSearchResults({
    required String search,
    String? status,
    DateTime? publishedAt,
    int perPage = 10,
  }) async {
    if (!state.hasNextPage || state.status == AnnouncementsStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more search results in notifier');
    state = state.copyWith(status: AnnouncementsStatus.loadingMore);

    final params = GetAnnouncementsCursorParams(
      paginate: true,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
      search: search,
      status: status,
      publishedAt: publishedAt,
    );

    final response = await _getAnnouncementsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more search results', failure);
        state = state.copyWith(
          status: AnnouncementsStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'More search results loaded successfully in notifier',
        );
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

  void clearSearch() {
    AppLogger.uiInfo('Clearing search results');
    state = const AnnouncementsState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
