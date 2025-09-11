import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/user/domain/usecases/get_current_user_reservations_cursor_usecase.dart';
import 'package:tires/features/user/presentation/providers/current_user_reservations_state.dart';

class CurrentUserReservationsNotifier
    extends StateNotifier<CurrentUserReservationsState> {
  final GetCurrentUserReservationsCursorUsecase
  _getUserReservationsCursorUsecase;

  CurrentUserReservationsNotifier(this._getUserReservationsCursorUsecase)
    : super(const CurrentUserReservationsState()) {
    getInitialReservations();
  }

  Future<void> getInitialReservations({
    bool paginate = true,
    int perPage = 10,
  }) async {
    if (state.status == CurrentUserReservationsStatus.loading) return;

    state = state.copyWith(status: CurrentUserReservationsStatus.loading);

    final params = GetUserReservationsCursorParams(
      paginate: paginate,
      perPage: perPage,
    );

    final response = await _getUserReservationsCursorUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: CurrentUserReservationsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: CurrentUserReservationsStatus.success,
              reservations: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> getUserReservations({
    bool paginate = true,
    int perPage = 10,
  }) async {
    await getInitialReservations(paginate: paginate, perPage: perPage);
  }

  Future<void> loadMoreReservations({
    bool paginate = true,
    int perPage = 10,
  }) async {
    if (!state.hasNextPage ||
        state.status == CurrentUserReservationsStatus.loadingMore) {
      return;
    }

    state = state.copyWith(status: CurrentUserReservationsStatus.loadingMore);

    final params = GetUserReservationsCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getUserReservationsCursorUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: CurrentUserReservationsStatus
              .success, // Keep previous data on error
          errorMessage: failure.message,
        );
      },
      (success) {
        final List<Reservation> allReservations = [
          ...state.reservations,
          ...success.data ?? <Reservation>[],
        ];
        state = state
            .copyWith(
              status: CurrentUserReservationsStatus.success,
              reservations: allReservations,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refreshReservations({
    bool paginate = true,
    int perPage = 10,
  }) async {
    await getInitialReservations(paginate: paginate, perPage: perPage);
  }

  void clearState() {
    state = const CurrentUserReservationsState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
