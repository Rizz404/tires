import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';

class WeekViewWidget extends StatelessWidget {
  final DateTime selectedWeek;
  final List<CalendarReservation> Function(DateTime) eventLoader;
  final Function(DateTime, DateTime) onDaySelected;
  final DateTime? selectedDay;

  const WeekViewWidget({
    super.key,
    required this.selectedWeek,
    required this.eventLoader,
    required this.onDaySelected,
    this.selectedDay,
  });

  List<DateTime> _getWeekDays() {
    // Get the start of the week (Monday)
    final startOfWeek = selectedWeek.subtract(
      Duration(days: selectedWeek.weekday - 1),
    );

    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _getWeekDays();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8, // Adjust this ratio to control height
          ),
          itemCount: weekDays.length,
          itemBuilder: (context, index) {
            final day = weekDays[index];
            final dayReservations = eventLoader(day);
            final isSelected =
                selectedDay != null &&
                day.day == selectedDay!.day &&
                day.month == selectedDay!.month &&
                day.year == selectedDay!.year;
            final isToday = _isToday(day);

            return _buildDayCard(
              context,
              day,
              dayReservations,
              isSelected,
              isToday,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDayCard(
    BuildContext context,
    DateTime day,
    List<CalendarReservation> reservations,
    bool isSelected,
    bool isToday,
  ) {
    return GestureDetector(
      onTap: () => onDaySelected(day, day),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : isToday
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : isToday
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).dividerColor.withOpacity(0.3),
            width: isSelected || isToday ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day name and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.E().format(day),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : isToday
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                if (reservations.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${reservations.length}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Reservations list
            Expanded(
              child: reservations.isEmpty
                  ? Center(
                      child: Text(
                        'No reservations',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: reservations.length > 3
                          ? 3
                          : reservations.length,
                      itemBuilder: (context, index) {
                        if (index == 2 && reservations.length > 3) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '+${reservations.length - 2} more',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          );
                        }

                        final reservation = reservations[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              reservation.status,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _getStatusColor(
                                reservation.status,
                              ).withOpacity(0.5),
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reservation.menuName,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                  color: _getStatusColor(reservation.status),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${reservation.time} - ${reservation.endTime}',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: _getStatusColor(
                                    reservation.status,
                                  ).withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isToday(DateTime day) {
    final now = DateTime.now();
    return day.year == now.year && day.month == now.month && day.day == now.day;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
