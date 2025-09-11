import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_state.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';

class AnnouncementsNotifier extends StateNotifier<AnnouncementsState> {
  final GetAnnouncementsCursorUsecase _getUsersCursorUsecase;

  AnnouncementsNotifier(this._getUsersCursorUsecase)
    : super(const AnnouncementsState()) {
    getInitialAnnouncements();
  }

  Future<void> getInitialAnnouncements({
    bool paginate = true,
    int perPage = 10,
  }) async {
    if (state.status == AnnouncementsStatus.loading) return;

    state = state.copyWith(status: AnnouncementsStatus.loading);

    final params = GetUserAnnouncementsCursorParams(
      paginate: paginate,
      perPage: perPage,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: AnnouncementsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
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

  Future<void> getUsers({bool paginate = true, int perPage = 10}) async {
    await getInitialAnnouncements(paginate: paginate, perPage: perPage);
  }

  Future<void> loadMores({bool paginate = true, int perPage = 10}) async {
    if (!state.hasNextPage || state.status == AnnouncementsStatus.loadingMore) {
      return;
    }

    state = state.copyWith(status: AnnouncementsStatus.loadingMore);

    final params = GetUserAnnouncementsCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getUsersCursorUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: AnnouncementsStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
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

  Future<void> refreshs({bool paginate = true, int perPage = 10}) async {
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
