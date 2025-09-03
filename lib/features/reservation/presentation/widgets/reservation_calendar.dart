import 'package:collection/collection.dart'; // Tambahkan import ini
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/reservation/domain/entities/calendar.dart'
    as entity;
import 'package:tires/features/reservation/presentation/providers/reservation_calendar_get_state.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_providers.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class ReservationCalendar extends ConsumerWidget {
  final ReservationCalendarGetState calendarState;

  const ReservationCalendar({super.key, required this.calendarState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMonth = ref.watch(currentMonthProvider);
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
        // 1. Menambahkan border di sini
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
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
          _buildMonthHeader(context, ref, currentMonth, locale),
          const SizedBox(height: 16),
          _buildWeekdayHeader(rotatedWeekdays),
          const SizedBox(height: 8),
          _buildCalendarBody(context, ref),
        ],
      ),
    );
  }

  Widget _buildMonthHeader(
    BuildContext context,
    WidgetRef ref,
    DateTime currentMonth,
    String locale,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            ref.read(currentMonthProvider.notifier).state = DateTime(
              currentMonth.year,
              currentMonth.month - 1,
            );
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
            ref.read(currentMonthProvider.notifier).state = DateTime(
              currentMonth.year,
              currentMonth.month + 1,
            );
          },
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader(List<String> weekdays) {
    return Row(
      children: weekdays
          .map(
            (day) => Expanded(
              child: Center(
                child: AppText(
                  day,
                  style: AppTextStyle.bodySmall,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarBody(BuildContext context, WidgetRef ref) {
    if (calendarState.status == ReservationCalendarGetStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (calendarState.status == ReservationCalendarGetStatus.error) {
      return Center(child: AppText(calendarState.errorMessage ?? 'Error'));
    }
    if (calendarState.calendar != null) {
      return Column(
        children: _buildCalendarGrid(context, ref, calendarState.calendar!),
      );
    }
    return const Center(child: AppText('No availability data.'));
  }

  // 2. Logika grid kalender yang baru
  List<Widget> _buildCalendarGrid(
    BuildContext context,
    WidgetRef ref,
    entity.Calendar calendar,
  ) {
    final currentMonth = ref.watch(currentMonthProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    // Cari hari Minggu pertama untuk memulai grid
    final startOfGrid = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );

    final weeks = <Widget>[];

    // Buat 6 baris untuk kalender
    for (int i = 0; i < 6; i++) {
      final currentWeek = <Widget>[];
      // Buat 7 kolom untuk setiap baris
      for (int j = 0; j < 7; j++) {
        final date = startOfGrid.add(Duration(days: (i * 7) + j));

        // Cari data ketersediaan untuk tanggal ini dari API
        final dayData = calendar.days.firstWhereOrNull(
          (d) => d.date.isAtSameMomentAs(date),
        );

        final isCurrentMonth = date.month == currentMonth.month;
        final isSelected =
            selectedDate != null &&
            date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day;

        // Tentukan apakah tanggal bisa dipilih atau tidak
        final isSelectable =
            dayData != null && !dayData.isPastDate && dayData.hasAvailableHours;

        Color? dayColor;
        Color textColor;
        Color? borderColor;

        if (isSelected) {
          dayColor = context.colorScheme.primary;
          textColor = context.colorScheme.onPrimary;
        } else if (!isCurrentMonth) {
          dayColor = Colors.transparent;
          textColor = context.colorScheme.onSurface.withOpacity(0.3);
        } else if (dayData == null || dayData.isPastDate) {
          dayColor = Colors.transparent;
          textColor = context.colorScheme.onSurface.withOpacity(0.4);
        } else if (!dayData.hasAvailableHours) {
          dayColor = context.colorScheme.errorContainer.withOpacity(0.3);
          textColor = context.colorScheme.onErrorContainer.withOpacity(0.6);
        } else if (dayData.isToday) {
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
              onTap: !isSelectable
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
                      '${date.day}',
                      color: textColor,
                      fontWeight: (dayData?.isToday ?? false)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    if (dayData != null &&
                        dayData.reservationCount > 0 &&
                        !isSelected &&
                        isSelectable)
                      Positioned(
                        bottom: 4,
                        child: Container(
                          width: 5,
                          height: 5,
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
      }
      weeks.add(Row(children: currentWeek));
    }
    return weeks;
  }
}
