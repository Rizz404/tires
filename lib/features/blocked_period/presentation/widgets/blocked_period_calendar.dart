import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

enum CalendarDisplayMode { month, week }

class BlockedPeriodCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final Function(DateTime, DateTime) onTimeRangeSelected;
  final DateTime initialDate;

  const BlockedPeriodCalendar({
    super.key,
    required this.onDateSelected,
    required this.onTimeRangeSelected,
    required this.initialDate,
  });

  @override
  State<BlockedPeriodCalendar> createState() => _BlockedPeriodCalendarState();
}

class _BlockedPeriodCalendarState extends State<BlockedPeriodCalendar> {
  late CalendarDisplayMode _displayMode;
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _displayMode = CalendarDisplayMode.month;
    _focusedDay = widget.initialDate;
    _selectedDay = widget.initialDate;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      widget.onDateSelected(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colorScheme.outline.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            if (_displayMode == CalendarDisplayMode.month)
              _buildMonthView()
            else
              _buildWeekView(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText('Calendar View - Click on dates to select'),
            const SizedBox(height: 4),
            AppText(
              DateFormat.yMMMM().format(_focusedDay),
              style: AppTextStyle.titleLarge,
            ),
          ],
        ),
        Row(
          children: [
            AppButton(
              text: 'Month',
              onPressed: () {
                setState(() {
                  _displayMode = CalendarDisplayMode.month;
                });
              },
              color: _displayMode == CalendarDisplayMode.month
                  ? AppButtonColor.primary
                  : AppButtonColor.secondary,
              size: AppButtonSize.small,
            ),
            const SizedBox(width: 8),
            AppButton(
              text: 'Week',
              onPressed: () {
                setState(() {
                  _displayMode = CalendarDisplayMode.week;
                });
              },
              color: _displayMode == CalendarDisplayMode.week
                  ? AppButtonColor.primary
                  : AppButtonColor.secondary,
              size: AppButtonSize.small,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth.isFinite ? constraints.maxWidth : 400,
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            headerVisible: false,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeekView() {
    // For simplicity, this is a placeholder. A more complex implementation
    // would be needed to match the image exactly with time slots.
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth.isFinite ? constraints.maxWidth : 400,
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            headerVisible: false,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
              ),
              todayDecoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(0.5),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      },
    );
  }
}
