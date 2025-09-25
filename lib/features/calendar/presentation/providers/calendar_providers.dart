import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/calendar/presentation/providers/calendar_notifier.dart';
import 'package:tires/features/calendar/presentation/providers/calendar_state.dart';

final calendarNotifierProvider =
    NotifierProvider<CalendarNotifier, CalendarState>(CalendarNotifier.new);
