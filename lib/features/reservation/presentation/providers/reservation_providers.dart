import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/presentation/providers/current_user_reservations_get_notifier.dart';
import 'package:tires/features/reservation/presentation/providers/current_user_reservations_get_state.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_available_hours_get_notifier.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_available_hours_get_state.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_calendar_get_notifier.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_calendar_get_state.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_get_notifier.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_get_state.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_mutation_notifier.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_mutation_state.dart';

final reservationGetNotifierProvider =
    StateNotifierProvider<ReservationGetNotifier, ReservationGetState>((ref) {
      final getReservationCursorUsecase = ref.watch(
        getReservationCursorUsecaseProvider,
      );
      return ReservationGetNotifier(getReservationCursorUsecase);
    });

final reservationMutationNotifierProvider =
    StateNotifierProvider<
      ReservationMutationNotifier,
      ReservationMutationState
    >((ref) {
      final createReservationUsecase = ref.watch(
        createReservationUsecaseProvider,
      );
      final updateReservationUsecase = ref.watch(
        updateReservationUsecaseProvider,
      );
      final deleteReservationUsecase = ref.watch(
        deleteReservationUsecaseProvider,
      );

      return ReservationMutationNotifier(
        createReservationUsecase,
        updateReservationUsecase,
        deleteReservationUsecase,
      );
    });

final reservationCalendarGetNotifierProvider =
    StateNotifierProvider<
      ReservationCalendarGetNotifier,
      ReservationCalendarGetState
    >((ref) {
      final getReservationCalendarUsecase = ref.watch(
        getReservationCalendarUsecaseProvider,
      );
      return ReservationCalendarGetNotifier(getReservationCalendarUsecase);
    });

final reservationAvailableHoursGetNotifierProvider =
    StateNotifierProvider<
      ReservationAvailableHoursGetNotifier,
      ReservationAvailableHoursGetState
    >((ref) {
      final getReservationAvailableHoursUsecase = ref.watch(
        getReservationAvailableHoursUsecaseProvider,
      );
      return ReservationAvailableHoursGetNotifier(
        getReservationAvailableHoursUsecase,
      );
    });

final currentUserReservationsGetNotifierProvider =
    StateNotifierProvider<
      CurrentUserReservationsGetNotifier,
      CurrentUserReservationsGetState
    >((ref) {
      final getCurrentUserReservationsCursorUsecase = ref.watch(
        getCurrentUserReservationsCursorUsecaseProvider,
      );
      return CurrentUserReservationsGetNotifier(
        getCurrentUserReservationsCursorUsecase,
      );
    });

final selectedDateProvider = StateProvider.autoDispose<DateTime?>(
  (ref) => null,
);
final selectedTimeProvider = StateProvider.autoDispose<String?>((ref) => null);
final selectedMenuProvider = StateProvider.autoDispose<Menu?>((ref) => null);
final currentMonthProvider = StateProvider.autoDispose<DateTime>(
  (ref) => DateTime.now(),
);

final pendingReservationProvider = StateProvider<Reservation?>((ref) => null);

final confirmedReservationProvider = StateProvider<Reservation?>((ref) => null);
