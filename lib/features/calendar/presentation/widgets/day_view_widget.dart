import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class DayViewWidget extends StatelessWidget {
  final DateTime selectedDay;
  final List<Reservation> reservations;
  final VoidCallback onPreviousDay;
  final VoidCallback onNextDay;

  const DayViewWidget({
    super.key,
    required this.selectedDay,
    required this.reservations,
    required this.onPreviousDay,
    required this.onNextDay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onPreviousDay,
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Center(
                    child: AppText(
                      DateFormat('EEEE, d MMM y').format(selectedDay),
                      style: AppTextStyle.titleLarge,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onNextDay,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildHourlyTimeSlots(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyTimeSlots(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: 24,
        itemBuilder: (context, index) {
          final hour = index;
          final timeString = ':00';
          final hourReservations = reservations.where((reservation) {
            final reservationHour =
                int.tryParse(reservation.time.split(':')[0]) ?? 0;
            return reservationHour == hour;
          }).toList();
          return Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    timeString,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
                Expanded(
                  child: hourReservations.isEmpty
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: hourReservations.map((reservation) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                  reservation.status,
                                ).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: _getStatusColor(reservation.status),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                ' ( - )',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getStatusColor(reservation.status),
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
