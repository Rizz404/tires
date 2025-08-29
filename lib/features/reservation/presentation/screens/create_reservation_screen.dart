import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/availability/domain/entities/availability_day.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';
import 'package:tires/features/availability/presentation/providers/availability_provider.dart';
import 'package:tires/features/availability/presentation/providers/availability_state.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

// * State providers untuk reservation
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
final selectedTimeProvider = StateProvider<String?>((ref) => null);
final selectedMenuProvider = StateProvider<Menu?>((ref) => null);
final currentMonthProvider = StateProvider<DateTime>((ref) => DateTime.now());

// TODO: Mock availability state provider - remove when API is ready
final mockAvailabilityStateProvider = StateProvider<AvailabilityState>((ref) {
  final currentMonth = ref.watch(currentMonthProvider);
  return AvailabilityState(
    status: AvailabilityStatus.success,
    availabilityCalendar: _generateMockAvailabilityCalendar(currentMonth),
  );
});

// TODO: Mock data generation function - remove when API is ready
AvailabilityCalendar _generateMockAvailabilityCalendar(DateTime currentMonth) {
  final availabilityDays = <AvailabilityDay>[];
  final today = DateTime.now();

  // Generate mock data for the current month
  final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
  final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);

  for (int day = 1; day <= lastDayOfMonth.day; day++) {
    final date = DateTime(currentMonth.year, currentMonth.month, day);
    final isToday =
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    final isPastDate = date.isBefore(
      DateTime(today.year, today.month, today.day),
    );

    // Mock logic: weekends have limited availability, past dates are blocked
    final weekday = date.weekday;
    final isSunday = weekday == 7;
    final isSaturday = weekday == 6;

    BookingStatus bookingStatus;
    bool hasAvailableHours;
    List<String> blockedHours;
    int reservationCount;

    if (isPastDate) {
      bookingStatus = BookingStatus.past;
      hasAvailableHours = false;
      blockedHours = [];
      reservationCount = 0;
    } else if (isSunday) {
      bookingStatus = BookingStatus.noAvailableHours;
      hasAvailableHours = false;
      blockedHours = [];
      reservationCount = 0;
    } else if (isSaturday) {
      // Saturday: limited hours, some bookings
      bookingStatus = BookingStatus.available;
      hasAvailableHours = true;
      blockedHours = ['15:00', '16:00']; // afternoon blocked
      reservationCount = 2;
    } else {
      // Weekdays: simulate different booking statuses
      if (day % 5 == 0) {
        // Every 5th day is fully booked
        bookingStatus = BookingStatus.fullyBooked;
        hasAvailableHours = false;
        blockedHours = [];
        reservationCount = 8;
      } else if (day % 3 == 0) {
        // Every 3rd day has heavy bookings
        bookingStatus = BookingStatus.available;
        hasAvailableHours = true;
        blockedHours = ['10:00', '11:00', '14:00', '15:00'];
        reservationCount = 4;
      } else {
        // Regular availability
        bookingStatus = BookingStatus.available;
        hasAvailableHours = true;
        blockedHours = day % 2 == 0
            ? ['12:00']
            : []; // lunch break on even days
        reservationCount = day % 4 == 0 ? 2 : 1;
      }
    }

    final availabilityDay = AvailabilityDay(
      date: date.toIso8601String().split('T')[0], // YYYY-MM-DD format
      day: day,
      isCurrentMonth: true,
      isToday: isToday,
      isPastDate: isPastDate,
      hasAvailableHours: hasAvailableHours,
      bookingStatus: bookingStatus,
      blockedHours: blockedHours,
      reservationCount: reservationCount,
    );

    availabilityDays.add(availabilityDay);
  }

  // Create mock availability calendar
  return AvailabilityCalendar(
    days: availabilityDays,
    currentMonth: DateFormat('yyyy-MM').format(currentMonth),
    previousMonth: DateFormat(
      'yyyy-MM',
    ).format(DateTime(currentMonth.year, currentMonth.month - 1)),
    nextMonth: DateFormat(
      'yyyy-MM',
    ).format(DateTime(currentMonth.year, currentMonth.month + 1)),
  );
}

@RoutePage()
class CreateReservationScreen extends ConsumerWidget {
  final Menu menu;

  const CreateReservationScreen({super.key, required this.menu});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    final selectedMenu = ref.watch(selectedMenuProvider);
    final currentMonth = ref.watch(currentMonthProvider);
    // TODO: Use mock availability state instead of real API
    // final availabilityState = ref.watch(availabilityNotifierProvider);
    final availabilityState = ref.watch(mockAvailabilityStateProvider);

    // Set the passed menu as selected menu if not already set
    if (selectedMenu == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedMenuProvider.notifier).state = menu;
      });
    }

    // TODO: Comment out API calls temporarily - replace with mock data
    // Initialize availability data when menu changes or month changes
    // ref.listen(selectedMenuProvider, (previous, next) {
    //   if (next != null) {
    //     ref
    //         .read(availabilityNotifierProvider.notifier)
    //         .getAvailabilityCalendar(
    //           menuId: next.id.toString(),
    //           targetMonth: currentMonth,
    //         );
    //   }
    // });

    // ref.listen(currentMonthProvider, (previous, next) {
    //   final currentSelectedMenu = ref.read(selectedMenuProvider);
    //   if (currentSelectedMenu != null && previous != next) {
    //     ref
    //         .read(availabilityNotifierProvider.notifier)
    //         .getAvailabilityCalendar(
    //           menuId: currentSelectedMenu.id.toString(),
    //           targetMonth: next,
    //         );
    //   }
    // });

    // // Initial load
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (availabilityState.status == AvailabilityStatus.initial) {
    //     ref
    //         .read(availabilityNotifierProvider.notifier)
    //         .getAvailabilityCalendar(
    //           menuId: menu.id.toString(),
    //           targetMonth: currentMonth,
    //         );
    //   }
    // });

    // Mock data for testing - replace API calls
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (availabilityState.status == AvailabilityStatus.initial) {
    //     _loadMockAvailabilityData(ref, currentMonth);
    //   }
    // });

    // ref.listen(currentMonthProvider, (previous, next) {
    //   if (previous != next) {
    //     _loadMockAvailabilityData(ref, next);
    //   }
    // });
    return Scaffold(
      appBar: UserAppBar(title: context.l10n.appBarCreateReservation),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: availabilityState.status == AvailabilityStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : availabilityState.status == AvailabilityStatus.error
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      availabilityState.errorMessage ?? 'An error occurred',
                      style: AppTextStyle.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Comment out API call temporarily
                        // ref
                        //     .read(availabilityNotifierProvider.notifier)
                        //     .refreshAvailabilityCalendar(
                        //       menuId: menu.id.toString(),
                        //       targetMonth: currentMonth,
                        //     );

                        // Use mock data instead - trigger rebuild
                        ref.invalidate(mockAvailabilityStateProvider);
                      },
                      child: const AppText('Retry'),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMenuDetail(context, menu),
                    const SizedBox(height: 24),
                    _buildReservationNotes(context),
                    const SizedBox(height: 24),
                    _buildCalendar(context, ref, availabilityState),
                    const SizedBox(height: 24),
                    if (selectedDate != null) ...[
                      _buildTimeSlots(
                        context,
                        ref,
                        selectedDate,
                        availabilityState,
                      ),
                      const SizedBox(height: 24),
                    ],
                    if (selectedDate != null && selectedTime != null) ...[
                      _buildBookingSummary(
                        context,
                        menu,
                        selectedDate,
                        selectedTime,
                      ),
                      const SizedBox(height: 24),
                      _buildConfirmButton(context),
                    ],
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildMenuDetail(BuildContext context, Menu menu) {
    final onSurfaceColor = context.colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color(
                int.parse(menu.color.hex.replaceFirst('#', '0xFF')),
              ).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.build,
              size: 40,
              color: Color(int.parse(menu.color.hex.replaceFirst('#', '0xFF'))),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  menu.name,
                  style: AppTextStyle.headlineSmall,
                  fontWeight: FontWeight.bold,
                ),
                if (menu.description != null) ...[
                  const SizedBox(height: 4),
                  AppText(
                    menu.description!,
                    style: AppTextStyle.bodyMedium,
                    color: onSurfaceColor.withValues(alpha: 0.7),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: onSurfaceColor.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      '${menu.requiredTime} minutes',
                      style: AppTextStyle.bodyMedium,
                      color: onSurfaceColor.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.monetization_on,
                      size: 16,
                      color: onSurfaceColor.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      menu.price.formatted,
                      style: AppTextStyle.bodyMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationNotes(BuildContext context) {
    final l10n = context.l10n;
    final notes = [
      l10n.createReservationNotesContent1,
      l10n.createReservationNotesContent2,
      l10n.createReservationNotesContent3,
      l10n.createReservationNotesContent4,
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            l10n.createReservationNotesTitle,
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 8),
          ...notes.map(
            (note) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: AppText(
                      note,
                      style: AppTextStyle.bodyMedium,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(
    BuildContext context,
    WidgetRef ref,
    AvailabilityState availabilityState,
  ) {
    final currentMonth = ref.watch(currentMonthProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final locale = Localizations.localeOf(context).toString();

    final dateSymbols = DateFormat.E(locale).dateSymbols;
    final shortWeekdays = dateSymbols.SHORTWEEKDAYS;
    final rotatedWeekdays = [
      shortWeekdays[DateTime.sunday % 7],
      ...shortWeekdays.sublist(0, DateTime.sunday % 7),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  final prevMonth = DateTime(
                    currentMonth.year,
                    currentMonth.month - 1,
                  );
                  ref.read(currentMonthProvider.notifier).state = prevMonth;
                },
                icon: const Icon(Icons.chevron_left),
              ),
              AppText(
                DateFormat('MMMM yyyy', locale).format(currentMonth),
                style: AppTextStyle.headlineSmall,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                onPressed: () {
                  final nextMonth = DateTime(
                    currentMonth.year,
                    currentMonth.month + 1,
                  );
                  ref.read(currentMonthProvider.notifier).state = nextMonth;
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: rotatedWeekdays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: AppText(
                        day,
                        style: AppTextStyle.bodySmall,
                        fontWeight: FontWeight.bold,
                        color: context.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          ..._buildCalendarGrid(
            context,
            currentMonth,
            selectedDate,
            availabilityState,
            ref,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCalendarGrid(
    BuildContext context,
    DateTime currentMonth,
    DateTime? selectedDate,
    AvailabilityState availabilityState,
    WidgetRef ref,
  ) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final today = DateTime.now();

    // Get availability days from API response
    final availabilityDays = availabilityState.availabilityCalendar?.days ?? [];

    List<Widget> weeks = [];
    List<Widget> currentWeek = [];

    for (int i = 0; i < firstWeekday; i++) {
      currentWeek.add(const Expanded(child: SizedBox(height: 40)));
    }

    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final isToday =
          date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
      final isSelected =
          selectedDate != null &&
          date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;

      // Find availability data for this day
      final dayAvailability = availabilityDays.where((availDay) {
        final availDate = DateTime.parse(availDay.date);
        return availDate.year == date.year &&
            availDate.month == date.month &&
            availDate.day == date.day;
      }).firstOrNull;

      final isPastDate =
          dayAvailability?.isPastDate ??
          date.isBefore(DateTime(today.year, today.month, today.day));
      final hasAvailableHours = dayAvailability?.hasAvailableHours ?? false;
      final reservationCount = dayAvailability?.reservationCount ?? 0;
      final isFullyBooked =
          dayAvailability?.bookingStatus == BookingStatus.fullyBooked;

      Color? dayColor;
      Color textColor;
      Color? borderColor;

      if (isPastDate) {
        dayColor = Theme.of(context).disabledColor.withValues(alpha: 0.5);
        textColor = context.colorScheme.onSurface.withValues(alpha: 0.4);
      } else if (isSelected) {
        dayColor = context.colorScheme.primary;
        textColor = context.colorScheme.onPrimary;
        borderColor = context.colorScheme.primary;
      } else if (isFullyBooked) {
        dayColor = context.colorScheme.errorContainer;
        textColor = context.colorScheme.onErrorContainer;
      } else if (isToday) {
        dayColor = context.colorScheme.tertiary;
        textColor = context.colorScheme.primary;
        borderColor = context.colorScheme.primary;
      } else {
        dayColor = Colors.transparent;
        textColor = context.colorScheme.onSurface;
      }

      currentWeek.add(
        Expanded(
          child: GestureDetector(
            onTap: isPastDate || isFullyBooked || !hasAvailableHours
                ? null
                : () {
                    ref.read(selectedDateProvider.notifier).state = date;
                    ref.read(selectedTimeProvider.notifier).state = null;
                  },
            child: Container(
              height: 40,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: dayColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor ?? Colors.transparent),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppText(
                    '$day',
                    style: AppTextStyle.bodyMedium,
                    color: textColor,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                  if (reservationCount > 0 && !isFullyBooked && !isSelected)
                    Positioned(
                      bottom: 4,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: context.colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );

      if (currentWeek.length == 7) {
        weeks.add(Row(children: List.from(currentWeek)));
        currentWeek.clear();
      }
    }

    while (currentWeek.length < 7) {
      currentWeek.add(const Expanded(child: SizedBox(height: 40)));
    }
    if (currentWeek.isNotEmpty) {
      weeks.add(Row(children: List.from(currentWeek)));
    }
    return weeks;
  }

  Widget _buildTimeSlots(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedDate,
    AvailabilityState availabilityState,
  ) {
    final selectedTime = ref.watch(selectedTimeProvider);
    final now = DateTime.now();
    final locale = Localizations.localeOf(context).toString();

    final isToday =
        selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

    // Find availability data for selected date
    final availabilityDays = availabilityState.availabilityCalendar?.days ?? [];
    final dayAvailability = availabilityDays.where((availDay) {
      final availDate = DateTime.parse(availDay.date);
      return availDate.year == selectedDate.year &&
          availDate.month == selectedDate.month &&
          availDate.day == selectedDate.day;
    }).firstOrNull;

    // Use blocked hours from API
    final blockedHours = dayAvailability?.blockedHours ?? [];

    final businessHours = {
      1: {'start': 9, 'end': 18},
      2: {'start': 9, 'end': 18},
      3: {'start': 9, 'end': 18},
      4: {'start': 9, 'end': 18},
      5: {'start': 9, 'end': 18},
      6: {'start': 9, 'end': 17},
      7: null,
    };
    final weekday = selectedDate.weekday;
    final hours = businessHours[weekday];
    if (hours == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: AppText(
            'Sunday: Closed',
            style: AppTextStyle.titleMedium,
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    List<String> timeSlots = [];
    for (int hour = hours['start']!; hour < hours['end']!; hour++) {
      timeSlots.add('${hour.toString().padLeft(2, '0')}:00');
    }

    if (isToday) {
      timeSlots = timeSlots.where((time) {
        final timeParts = time.split(':');
        final slotHour = int.parse(timeParts[0]);
        return slotHour > now.hour;
      }).toList();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            '${DateFormat('EEE', locale).format(selectedDate)} ${hours['start']!.toString().padLeft(2, '0')}:00 - ${hours['end']!.toString().padLeft(2, '0')}:00',
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: timeSlots.map((time) {
              final isBlocked = blockedHours.contains(time);
              final isSelected = selectedTime == time;

              Color? bgColor;
              Color textColor;
              Color borderColor;

              if (isBlocked) {
                bgColor = Theme.of(context).disabledColor;
                textColor = context.colorScheme.onSurface.withValues(
                  alpha: 0.5,
                );
                borderColor = context.colorScheme.outline.withValues(
                  alpha: 0.5,
                );
              } else if (isSelected) {
                bgColor = context.colorScheme.primary;
                textColor = context.colorScheme.onPrimary;
                borderColor = context.colorScheme.primary;
              } else {
                bgColor = context.colorScheme.surface;
                textColor = context.colorScheme.onSurface;
                borderColor = context.colorScheme.outline;
              }

              return GestureDetector(
                onTap: isBlocked
                    ? null
                    : () {
                        ref.read(selectedTimeProvider.notifier).state = time;
                      },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor),
                  ),
                  child: AppText(
                    time,
                    color: textColor,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary(
    BuildContext context,
    Menu menu,
    DateTime selectedDate,
    String selectedTime,
  ) {
    final locale = Localizations.localeOf(context).toString();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.success.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Booking Summary',
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(context, 'Service:', menu.name),
          _buildSummaryRow(
            context,
            'Duration:',
            '${menu.requiredTime} minutes',
          ),
          _buildSummaryRow(
            context,
            'Date:',
            DateFormat('EEEE, MMMM d, y', locale).format(selectedDate),
          ),
          _buildSummaryRow(context, 'Time:', selectedTime),
          const Divider(height: 20),
          _buildSummaryRow(
            context,
            'Total:',
            menu.price.formatted,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final textStyle = isTotal
        ? context.textTheme.titleMedium
        : context.textTheme.bodyMedium;
    final valueStyle = textStyle?.copyWith(
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        text: 'Confirm Reservation',
        color: AppButtonColor.primary,
        onPressed: () {
          context.router.push(const ConfirmReservationRoute());
        },
      ),
    );
  }
}
