import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    NotifierProvider<ReservationGetNotifier, ReservationGetState>(
      ReservationGetNotifier.new,
    );

final reservationMutationNotifierProvider =
    NotifierProvider<ReservationMutationNotifier, ReservationMutationState>(
      ReservationMutationNotifier.new,
    );

final reservationCalendarGetNotifierProvider =
    NotifierProvider<
      ReservationCalendarGetNotifier,
      ReservationCalendarGetState
    >(ReservationCalendarGetNotifier.new);

final reservationAvailableHoursGetNotifierProvider =
    NotifierProvider<
      ReservationAvailableHoursGetNotifier,
      ReservationAvailableHoursGetState
    >(ReservationAvailableHoursGetNotifier.new);

final currentUserReservationsGetNotifierProvider =
    NotifierProvider<
      CurrentUserReservationsGetNotifier,
      CurrentUserReservationsGetState
    >(CurrentUserReservationsGetNotifier.new);

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
