import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/features/calendar/domain/usecases/get_calendar_data_usecase.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class CalendarViewToggleWidget extends StatelessWidget {
  final GetCalendarDataParamsView currentView;
  final Function(GetCalendarDataParamsView) onViewChanged;

  const CalendarViewToggleWidget({
    super.key,
    required this.currentView,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context.l10n.adminListCalendarScreenTabsCalendarView,
              style: AppTextStyle.titleMedium,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildViewButton(
                  context,
                  context.l10n.adminListCalendarScreenViewsMonth,
                  GetCalendarDataParamsView.month,
                  Icons.calendar_view_month,
                ),
                const SizedBox(width: 8),
                _buildViewButton(
                  context,
                  context.l10n.adminListCalendarScreenViewsWeek,
                  GetCalendarDataParamsView.week,
                  Icons.calendar_view_week,
                ),
                const SizedBox(width: 8),
                _buildViewButton(
                  context,
                  context.l10n.adminListCalendarScreenViewsDay,
                  GetCalendarDataParamsView.day,
                  Icons.calendar_today,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewButton(
    BuildContext context,
    String title,
    GetCalendarDataParamsView view,
    IconData icon,
  ) {
    final isSelected = currentView == view;
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () => onViewChanged(view),
        icon: Icon(icon, size: 16),
        label: Text(title, style: const TextStyle(fontSize: 12)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          foregroundColor: isSelected
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSurface,
          elevation: isSelected ? 4 : 1,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
      ),
    );
  }
}
