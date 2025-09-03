import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_cursor_usecase.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_get_state.dart';

class ReservationGetNotifier extends StateNotifier<ReservationGetState> {
  final GetReservationCursorUsecase _getReservationCursorUsecase;

  ReservationGetNotifier(this._getReservationCursorUsecase)
    : super(const ReservationGetState()) {
    getInitialReservations();
  }

  Future<void> getInitialReservations({
    bool paginate = true,
    int perPage = 10,
  }) async {
    // Prevent duplicate loading if already in progress
    if (state.status == ReservationGetStatus.loading) return;

    state = state.copyWith(status: ReservationGetStatus.loading);

    final params = GetReservationCursorParams(
      paginate: paginate,
      perPage: perPage,
    );

    final response = await _getReservationCursorUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: ReservationGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: ReservationGetStatus.success,
              reservations: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> getReservations({bool paginate = true, int perPage = 10}) async {
    await getInitialReservations(paginate: paginate, perPage: perPage);
  }

  Future<void> loadMoreReservations({
    bool paginate = true,
    int perPage = 10,
  }) async {
    if (!state.hasNextPage ||
        state.status == ReservationGetStatus.loadingMore) {
      return;
    }

    state = state.copyWith(status: ReservationGetStatus.loadingMore);

    final params = GetReservationCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getReservationCursorUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: ReservationGetStatus.success, // Keep previous data on error
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
              status: ReservationGetStatus.success,
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
    state = const ReservationGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
