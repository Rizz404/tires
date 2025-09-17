import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/usecases/get_current_user_reservations_cursor_usecase.dart';
import 'package:tires/features/reservation/presentation/providers/current_user_reservations_get_state.dart';

class CurrentUserReservationsGetNotifier
    extends Notifier<CurrentUserReservationsGetState> {
  late final GetCurrentUserReservationsCursorUsecase
  _getCurrentUserReservationsCursorUsecase;

  @override
  CurrentUserReservationsGetState build() {
    _getCurrentUserReservationsCursorUsecase = ref.watch(
      getCurrentUserReservationsCursorUsecaseProvider,
    );
    Future.microtask(() => getInitialReservations());
    return const CurrentUserReservationsGetState();
  }

  Future<void> getInitialReservations({
    bool paginate = true,
    int perPage = 10,
  }) async {
    // Prevent duplicate loading if already in progress
    if (state.status == CurrentUserReservationsGetStatus.loading) return;

    AppLogger.uiInfo('Loading initial current user reservations');
    state = state.copyWith(status: CurrentUserReservationsGetStatus.loading);

    final params = GetCurrentUserReservationsCursorParams(
      paginate: paginate,
      perPage: perPage,
    );

    final response = await _getCurrentUserReservationsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError(
          'Failed to load initial current user reservations',
          failure,
        );
        state = state.copyWith(
          status: CurrentUserReservationsGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo(
          'Successfully loaded initial current user reservations',
        );
        state = state
            .copyWith(
              status: CurrentUserReservationsGetStatus.success,
              reservations: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> getReservations({bool paginate = true, int perPage = 10}) async {
    AppLogger.uiInfo('Getting current user reservations');
    await getInitialReservations(paginate: paginate, perPage: perPage);
  }

  Future<void> loadMoreReservations() async {
    if (state.status == CurrentUserReservationsGetStatus.loadingMore ||
        !state.hasNextPage) {
      return;
    }

    AppLogger.uiInfo('Loading more current user reservations');
    state = state.copyWith(
      status: CurrentUserReservationsGetStatus.loadingMore,
    );

    final params = GetCurrentUserReservationsCursorParams(
      paginate: true,
      perPage: 10,
      cursor: state.cursor?.nextCursor,
    );

    final response = await _getCurrentUserReservationsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError(
          'Failed to load more current user reservations',
          failure,
        );
        state = state.copyWith(
          status: CurrentUserReservationsGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        final newReservations = List<Reservation>.from(state.reservations)
          ..addAll(success.data ?? []);

        state = state
            .copyWith(
              status: CurrentUserReservationsGetStatus.success,
              reservations: newReservations,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> refreshReservations() async {
    AppLogger.uiInfo('Refreshing current user reservations');
    await getInitialReservations();
  }

  void clearState() {
    AppLogger.uiInfo('Clearing current user reservations state');
    state = const CurrentUserReservationsGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing current user reservations error');
      state = state.copyWithClearError();
    }
  }
}
