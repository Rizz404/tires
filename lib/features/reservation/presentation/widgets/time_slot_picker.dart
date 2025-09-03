import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_available_hours_get_state.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_providers.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class TimeSlotPicker extends ConsumerWidget {
  final DateTime selectedDate;
  final ReservationAvailableHoursGetState hoursState;

  const TimeSlotPicker({
    super.key,
    required this.selectedDate,
    required this.hoursState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTime = ref.watch(selectedTimeProvider);
    final locale = Localizations.localeOf(context).toString();

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
            DateFormat('EEEE, d MMMM yyyy', locale).format(selectedDate),
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          _buildHoursContent(context, ref, selectedTime),
        ],
      ),
    );
  }

  Widget _buildHoursContent(
    BuildContext context,
    WidgetRef ref,
    String? selectedTime,
  ) {
    switch (hoursState.status) {
      case ReservationAvailableHoursGetStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case ReservationAvailableHoursGetStatus.error:
        return Center(
          child: Text(hoursState.errorMessage ?? 'Failed to load hours'),
        );
      case ReservationAvailableHoursGetStatus.success:
        final hours = hoursState.availableHour?.hours;
        if (hours == null || hours.isEmpty) {
          return const Center(child: Text('No available time slots.'));
        }
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: hours.map((hour) {
            final isSelected = selectedTime == hour.time;
            final isAvailable = hour.available;

            Color bgColor;
            Color textColor;
            Color borderColor;

            if (!isAvailable) {
              bgColor = Theme.of(context).disabledColor;
              textColor = context.colorScheme.onSurface.withOpacity(0.5);
              borderColor = context.colorScheme.outline.withOpacity(0.5);
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
              onTap: !isAvailable
                  ? null
                  : () {
                      ref.read(selectedTimeProvider.notifier).state = hour.time;
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
                  hour.time,
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        );
      default:
        return const Center(
          child: Text('Select a date to see available times.'),
        );
    }
  }
}
