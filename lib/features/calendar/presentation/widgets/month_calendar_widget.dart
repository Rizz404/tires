import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';

class MonthCalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final List<CalendarReservation> Function(DateTime) eventLoader;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;

  const MonthCalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.eventLoader,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TableCalendar<CalendarReservation>(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: calendarFormat,
          eventLoader: eventLoader,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            // Remove weekend text color styling so Saturday is not red
            weekendTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            // Only Sunday should be styled differently if needed
            holidayTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            markersMaxCount: 3,
            markerSizeScale: 0.2,
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronVisible: true, // Enable built-in chevrons
            rightChevronVisible: true, // Enable built-in chevrons
            leftChevronIcon: Icon(Icons.chevron_left),
            rightChevronIcon: Icon(Icons.chevron_right),
          ),
          availableGestures: AvailableGestures.horizontalSwipe,
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: onDaySelected,
          onFormatChanged: onFormatChanged,
          onPageChanged: onPageChanged,
          // Custom marker builder to show "+" when more than 3 events
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isEmpty) return null;

              final eventCount = events.length;

              if (eventCount <= 3) {
                // Show dots for 1-3 events
                return Positioned(
                  bottom: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      eventCount,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                // Show 3 dots + plus indicator for more than 3 events
                return Positioned(
                  bottom: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
