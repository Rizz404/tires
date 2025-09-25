import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

enum CalendarViewMode { month, week, day }

class CalendarNavigationWidget extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final CalendarViewMode viewMode;

  const CalendarNavigationWidget({
    super.key,
    required this.focusedDay,
    required this.onPrevious,
    required this.onNext,
    this.viewMode = CalendarViewMode.month,
  });

  String _getTitle() {
    switch (viewMode) {
      case CalendarViewMode.month:
        return DateFormat.yMMMM().format(focusedDay);
      case CalendarViewMode.week:
        // Get start of week (Monday)
        final startOfWeek = focusedDay.subtract(
          Duration(days: focusedDay.weekday - 1),
        );
        final endOfWeek = startOfWeek.add(const Duration(days: 6));

        if (startOfWeek.month == endOfWeek.month) {
          // Same month: "Sep 22 - 28, 2025"
          return '${DateFormat.MMM().format(startOfWeek)} ${startOfWeek.day} - ${endOfWeek.day}, ${startOfWeek.year}';
        } else if (startOfWeek.year == endOfWeek.year) {
          // Different months, same year: "Sep 30 - Oct 6, 2025"
          return '${DateFormat.MMMd().format(startOfWeek)} - ${DateFormat.MMMd().format(endOfWeek)}, ${startOfWeek.year}';
        } else {
          // Different years: "Dec 30, 2024 - Jan 5, 2025"
          return '${DateFormat.MMMd().format(startOfWeek)}, ${startOfWeek.year} - ${DateFormat.MMMd().format(endOfWeek)}, ${endOfWeek.year}';
        }
      case CalendarViewMode.day:
        // Use shorter format to prevent overflow: "Thu, Sep 25"
        return DateFormat.E().format(focusedDay) +
            ', ' +
            DateFormat.MMMd().format(focusedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: onPrevious, icon: const Icon(Icons.chevron_left)),
        Expanded(
          child: Center(
            child: AppText(
              _getTitle(),
              style: AppTextStyle.titleLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}
