import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/user/domain/entities/reservation.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

// * State providers untuk reservation
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
final selectedTimeProvider = StateProvider<String?>((ref) => null);
final selectedMenuProvider = StateProvider<Menu?>((ref) => null);
final currentMonthProvider = StateProvider<DateTime>((ref) => DateTime.now());

// * Mock data untuk testing
final mockReservationsProvider = Provider<List<Reservation>>((ref) {
  // * Mock existing reservations untuk testing
  return [
    // * Mock reservation untuk hari ini jam 10:00
    Reservation(
      id: 1,
      reservationNumber: 'RES001',
      menu: const Menu(
        id: 1,
        name: 'Oil Change',
        description: 'Premium oil change service',
        requiredTime: 40,
        price: Price(amount: '50000', formatted: '¥50,000', currency: 'JPY'),
        displayOrder: 1,
        isActive: true,
        color: ColorInfo(
          hex: '#FF6B6B',
          rgbaLight: 'rgba(255, 107, 107, 0.1)',
          textColor: '#FFFFFF',
        ),
      ),
      reservationDatetime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        10,
        0,
      ),
      numberOfPeople: 1,
      amount: 50000,
      status: ReservationStatus.confirmed,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
});

@RoutePage()
class CreateReservationScreen extends ConsumerWidget {
  const CreateReservationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    final selectedMenu = ref.watch(selectedMenuProvider);
    final mockMenu = const Menu(
      id: 1,
      name: 'Oil Change',
      description: 'Premium oil change service with high-quality synthetic oil',
      requiredTime: 40,
      price: Price(amount: '50000', formatted: '¥50,000', currency: 'JPY'),
      displayOrder: 1,
      isActive: true,
      color: ColorInfo(
        hex: '#FF6B6B',
        rgbaLight: 'rgba(255, 107, 107, 0.1)',
        textColor: '#FFFFFF',
      ),
    );
    if (selectedMenu == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedMenuProvider.notifier).state = mockMenu;
      });
    }
    return Scaffold(
      appBar: UserAppBar(title: context.l10n.appBarCreateReservation),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuDetail(context, mockMenu),
              const SizedBox(height: 24),
              _buildReservationNotes(context),
              const SizedBox(height: 24),
              _buildCalendar(context, ref),
              const SizedBox(height: 24),
              if (selectedDate != null) ...[
                _buildTimeSlots(context, ref, selectedDate),
                const SizedBox(height: 24),
              ],
              if (selectedDate != null && selectedTime != null) ...[
                _buildBookingSummary(
                  context,
                  mockMenu,
                  selectedDate,
                  selectedTime,
                ),
                const SizedBox(height: 24),
                _buildConfirmButton(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuDetail(BuildContext context, Menu menu) {
    final onSurfaceColor = context.colorScheme.onSurface;
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
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color(
                int.parse(menu.color.hex.replaceFirst('#', '0xFF')),
              ).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.build,
              size: 40,
              color: Color(int.parse(menu.color.hex.replaceFirst('#', '0xFF'))),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  menu.name,
                  style: AppTextStyle.headlineSmall,
                  fontWeight: FontWeight.bold,
                ),
                if (menu.description != null) ...[
                  const SizedBox(height: 4),
                  AppText(
                    menu.description!,
                    style: AppTextStyle.bodyMedium,
                    color: onSurfaceColor.withValues(alpha: 0.7),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: onSurfaceColor.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      '${menu.requiredTime} minutes',
                      style: AppTextStyle.bodyMedium,
                      color: onSurfaceColor.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.monetization_on,
                      size: 16,
                      color: onSurfaceColor.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      menu.price.formatted,
                      style: AppTextStyle.bodyMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationNotes(BuildContext context) {
    final l10n = context.l10n;
    final notes = [
      l10n.createReservationNotesContent1,
      l10n.createReservationNotesContent2,
      l10n.createReservationNotesContent3,
      l10n.createReservationNotesContent4,
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            l10n.createReservationNotesTitle,
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 8),
          ...notes.map(
            (note) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: AppText(
                      note,
                      style: AppTextStyle.bodyMedium,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, WidgetRef ref) {
    final currentMonth = ref.watch(currentMonthProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final existingReservations = ref.watch(mockReservationsProvider);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  final prevMonth = DateTime(
                    currentMonth.year,
                    currentMonth.month - 1,
                  );
                  ref.read(currentMonthProvider.notifier).state = prevMonth;
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
                  final nextMonth = DateTime(
                    currentMonth.year,
                    currentMonth.month + 1,
                  );
                  ref.read(currentMonthProvider.notifier).state = nextMonth;
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: rotatedWeekdays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: AppText(
                        day,
                        style: AppTextStyle.bodySmall,
                        fontWeight: FontWeight.bold,
                        color: context.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          ..._buildCalendarGrid(
            context,
            currentMonth,
            selectedDate,
            existingReservations,
            ref,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCalendarGrid(
    BuildContext context,
    DateTime currentMonth,
    DateTime? selectedDate,
    List<Reservation> existingReservations,
    WidgetRef ref,
  ) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final today = DateTime.now();

    List<Widget> weeks = [];
    List<Widget> currentWeek = [];

    for (int i = 0; i < firstWeekday; i++) {
      currentWeek.add(const Expanded(child: SizedBox(height: 40)));
    }

    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final isToday =
          date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
      final isPastDate = date.isBefore(
        DateTime(today.year, today.month, today.day),
      );
      final isSelected =
          selectedDate != null &&
          date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;

      final reservationsOnDate = existingReservations
          .where(
            (r) =>
                r.reservationDatetime.year == date.year &&
                r.reservationDatetime.month == date.month &&
                r.reservationDatetime.day == date.day,
          )
          .toList();
      final hasPartialBookings =
          reservationsOnDate.isNotEmpty && reservationsOnDate.length < 8;
      final isFullyBooked = reservationsOnDate.length >= 8;

      Color? dayColor;
      Color textColor;
      Color? borderColor;

      if (isPastDate) {
        dayColor = Theme.of(context).disabledColor.withValues(alpha: 0.5);
        textColor = context.colorScheme.onSurface.withValues(alpha: 0.4);
      } else if (isSelected) {
        dayColor = context.colorScheme.primary;
        textColor = context.colorScheme.onPrimary;
        borderColor = context.colorScheme.primary;
      } else if (isFullyBooked) {
        dayColor = context.colorScheme.errorContainer;
        textColor = context.colorScheme.onErrorContainer;
      } else if (isToday) {
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
            onTap: isPastDate || isFullyBooked
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
                    '$day',
                    style: AppTextStyle.bodyMedium,
                    color: textColor,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                  if (hasPartialBookings && !isFullyBooked && !isSelected)
                    Positioned(
                      bottom: 4,
                      child: Container(
                        width: 6,
                        height: 6,
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

      if (currentWeek.length == 7) {
        weeks.add(Row(children: List.from(currentWeek)));
        currentWeek.clear();
      }
    }

    while (currentWeek.length < 7) {
      currentWeek.add(const Expanded(child: SizedBox(height: 40)));
    }
    if (currentWeek.isNotEmpty) {
      weeks.add(Row(children: List.from(currentWeek)));
    }
    return weeks;
  }

  Widget _buildTimeSlots(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedDate,
  ) {
    final selectedTime = ref.watch(selectedTimeProvider);
    final existingReservations = ref.watch(mockReservationsProvider);
    final now = DateTime.now();
    final locale = Localizations.localeOf(context).toString();

    final isToday =
        selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

    final businessHours = {
      1: {'start': 9, 'end': 18},
      2: {'start': 9, 'end': 18},
      3: {'start': 9, 'end': 18},
      4: {'start': 9, 'end': 18},
      5: {'start': 9, 'end': 18},
      6: {'start': 9, 'end': 17},
      7: null,
    };
    final weekday = selectedDate.weekday;
    final hours = businessHours[weekday];
    if (hours == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: AppText(
            'Sunday: Closed',
            style: AppTextStyle.titleMedium,
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    List<String> timeSlots = [];
    for (int hour = hours['start']!; hour < hours['end']!; hour++) {
      timeSlots.add('${hour.toString().padLeft(2, '0')}:00');
    }

    if (isToday) {
      timeSlots = timeSlots.where((time) {
        final timeParts = time.split(':');
        final slotHour = int.parse(timeParts[0]);
        return slotHour > now.hour;
      }).toList();
    }

    final reservationsOnDate = existingReservations
        .where(
          (r) =>
              r.reservationDatetime.year == selectedDate.year &&
              r.reservationDatetime.month == selectedDate.month &&
              r.reservationDatetime.day == selectedDate.day,
        )
        .toList();

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
            '${DateFormat('EEE', locale).format(selectedDate)} ${hours['start']!.toString().padLeft(2, '0')}:00 - ${hours['end']!.toString().padLeft(2, '0')}:00',
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: timeSlots.map((time) {
              final isBooked = reservationsOnDate.any(
                (r) =>
                    DateFormat('HH:mm').format(r.reservationDatetime) == time,
              );
              final isSelected = selectedTime == time;

              Color? bgColor;
              Color textColor;
              Color borderColor;

              if (isBooked) {
                bgColor = Theme.of(context).disabledColor;
                textColor = context.colorScheme.onSurface.withValues(
                  alpha: 0.5,
                );
                borderColor = context.colorScheme.outline.withValues(
                  alpha: 0.5,
                );
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
                onTap: isBooked
                    ? null
                    : () {
                        ref.read(selectedTimeProvider.notifier).state = time;
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
                    time,
                    color: textColor,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary(
    BuildContext context,
    Menu menu,
    DateTime selectedDate,
    String selectedTime,
  ) {
    final locale = Localizations.localeOf(context).toString();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.success.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Booking Summary',
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(context, 'Service:', menu.name),
          _buildSummaryRow(
            context,
            'Duration:',
            '${menu.requiredTime} minutes',
          ),
          _buildSummaryRow(
            context,
            'Date:',
            DateFormat('EEEE, MMMM d, y', locale).format(selectedDate),
          ),
          _buildSummaryRow(context, 'Time:', selectedTime),
          const Divider(height: 20),
          _buildSummaryRow(
            context,
            'Total:',
            menu.price.formatted,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final textStyle = isTotal
        ? context.textTheme.titleMedium
        : context.textTheme.bodyMedium;
    final valueStyle = textStyle?.copyWith(
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        text: 'Confirm Reservation',
        color: AppButtonColor.primary,
        onPressed: () {
          context.router.push(const ConfirmReservationRoute());
        },
      ),
    );
  }
}
