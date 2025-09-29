import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/usecases/get_reservation_cursor_usecase.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_get_state.dart';

class ReservationGetNotifier extends Notifier<ReservationGetState> {
  late GetReservationCursorUsecase _getReservationCursorUsecase;

  @override
  ReservationGetState build() {
    _getReservationCursorUsecase = ref.watch(
      getReservationCursorUsecaseProvider,
    );
    Future.microtask(() => getInitialReservations());
    return const ReservationGetState();
  }

  Future<void> getInitialReservations({
    bool paginate = true,
    int perPage = 10,
  }) async {
    // Prevent duplicate loading if already in progress
    if (state.status == ReservationGetStatus.loading) return;

    AppLogger.uiInfo('Loading initial reservations');
    state = state.copyWith(status: ReservationGetStatus.loading);

    final params = GetReservationCursorParams(
      paginate: paginate,
      perPage: perPage,
    );

    final response = await _getReservationCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load initial reservations', failure);
        state = state.copyWith(
          status: ReservationGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully loaded initial reservations');
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
    AppLogger.uiInfo('Getting reservations');
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

    AppLogger.uiInfo('Loading more reservations');
    state = state.copyWith(status: ReservationGetStatus.loadingMore);

    final params = GetReservationCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getReservationCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more reservations', failure);
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
    AppLogger.uiInfo('Refreshing reservations');
    await getInitialReservations(paginate: paginate, perPage: perPage);
  }

  void clearState() {
    AppLogger.uiInfo('Clearing reservations state');
    state = const ReservationGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing reservations error');
      state = state.copyWithClearError();
    }
  }
}
