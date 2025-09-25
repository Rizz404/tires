import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/availability/presentation/providers/availability_calendar_notifier.dart';
import 'package:tires/features/availability/presentation/providers/availability_calendar_state.dart';
import 'package:tires/features/availability/presentation/providers/reservation_availability_notifier.dart';
import 'package:tires/features/availability/presentation/providers/reservation_availability_state.dart';

final availabilityCalendarNotifierProvider =
    NotifierProvider<AvailabilityCalendarNotifier, AvailabilityCalendarState>(
      AvailabilityCalendarNotifier.new,
    );

final reservationAvailabilityNotifierProvider =
    NotifierProvider<
      ReservationAvailabilityNotifier,
      ReservationAvailabilityState
    >(ReservationAvailabilityNotifier.new);
