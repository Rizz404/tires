import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

class CalendarStatsWidget extends StatelessWidget {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final Statistics? statistics;
  final VoidCallback onRetry;

  const CalendarStatsWidget({
    super.key,
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
    this.statistics,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (hasError) {
      return SizedBox(
        height: 120,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 32),
              const SizedBox(height: 8),
              Text(
                errorMessage ??
                    context
                        .l10n
                        .adminListCalendarScreenFailedToLoadCalendarData,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(
                  context.l10n.adminListCalendarScreenRetry,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (statistics == null) {
      return SizedBox(
        height: 80,
        child: Center(
          child: Text(
            context.l10n.adminListCalendarScreenNoStatisticsAvailable,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatTile(
          title: context.l10n.adminListCalendarScreenStatsTotalReservations,
          value: '${statistics!.totalReservations}',
          icon: Icons.event,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListCalendarScreenStatsConfirmed,
          value: '${statistics!.confirmed}',
          icon: Icons.check_circle,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListCalendarScreenStatsPending,
          value: '${statistics!.pending}',
          icon: Icons.pending,
          color: Colors.orange.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: context.l10n.adminListCalendarScreenStatsCompleted,
          value: '${statistics!.completed}',
          icon: Icons.done_all,
          color: Colors.purple.shade100,
        ),
      ],
    );
  }
}
