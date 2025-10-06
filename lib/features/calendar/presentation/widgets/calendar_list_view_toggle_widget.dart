import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

enum CalendarDisplayMode { calendar, list }

class CalendarListViewToggleWidget extends StatelessWidget {
  final CalendarDisplayMode currentMode;
  final Function(CalendarDisplayMode) onModeChanged;

  const CalendarListViewToggleWidget({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              'Display Mode',
              style: AppTextStyle.titleMedium,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildModeButton(
                  context,
                  context.l10n.adminListCalendarScreenTabsCalendarView,
                  CalendarDisplayMode.calendar,
                  Icons.calendar_month,
                ),
                const SizedBox(width: 8),
                _buildModeButton(
                  context,
                  context.l10n.adminListCalendarScreenTabsListView,
                  CalendarDisplayMode.list,
                  Icons.list,
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppText(
              currentMode == CalendarDisplayMode.calendar
                  ? context.l10n.adminListCalendarScreenModeDescriptionCalendar
                  : context.l10n.adminListCalendarScreenModeDescriptionList,
              style: AppTextStyle.bodySmall,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context,
    String title,
    CalendarDisplayMode mode,
    IconData icon,
  ) {
    final isSelected = currentMode == mode;
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () => onModeChanged(mode),
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
