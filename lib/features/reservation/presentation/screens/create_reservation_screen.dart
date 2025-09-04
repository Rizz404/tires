import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_providers.dart';
import 'package:tires/features/reservation/presentation/widgets/booking_summary_card.dart';
import 'package:tires/features/reservation/presentation/widgets/reservation_calendar.dart';
import 'package:tires/features/reservation/presentation/widgets/time_slot_picker.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class CreateReservationScreen extends ConsumerWidget {
  final Menu menu;

  const CreateReservationScreen({super.key, required this.menu});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    final selectedMenu = ref.watch(selectedMenuProvider);
    final currentMonth = ref.watch(currentMonthProvider);

    final calendarState = ref.watch(reservationCalendarGetNotifierProvider);
    final hoursState = ref.watch(reservationAvailableHoursGetNotifierProvider);

    // Set menu yang dipilih saat pertama kali layar dibuka
    if (selectedMenu == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedMenuProvider.notifier).state = menu;
      });
    }

    // Listener untuk mengambil data kalender saat menu atau bulan berubah
    ref.listen<Menu?>(selectedMenuProvider, (previous, next) {
      if (next != null) {
        final monthString = DateFormat('yyyy-MM').format(currentMonth);
        ref
            .read(reservationCalendarGetNotifierProvider.notifier)
            .getInitialCalendar(menuId: next.id.toString(), month: monthString);
      }
    });

    ref.listen<DateTime>(currentMonthProvider, (previous, next) {
      final currentSelectedMenu = ref.read(selectedMenuProvider);
      if (currentSelectedMenu != null && previous?.month != next.month) {
        final monthString = DateFormat('yyyy-MM').format(next);
        ref
            .read(reservationCalendarGetNotifierProvider.notifier)
            .getReservationCalendar(
              menuId: currentSelectedMenu.id.toString(),
              month: monthString,
            );
      }
    });

    // Listener untuk mengambil jam yang tersedia saat tanggal dipilih
    ref.listen<DateTime?>(selectedDateProvider, (previous, next) {
      final currentSelectedMenu = ref.read(selectedMenuProvider);
      if (next != null && currentSelectedMenu != null) {
        final dateString = DateFormat('yyyy-MM-dd').format(next);
        ref
            .read(reservationAvailableHoursGetNotifierProvider.notifier)
            .getAvailableHours(
              date: dateString,
              menuId: currentSelectedMenu.id.toString(),
            );
      }
    });

    return Scaffold(
      appBar: UserAppBar(title: context.l10n.appBarCreateReservation),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuDetail(context, menu),
              const SizedBox(height: 24),
              _buildReservationNotes(context),
              const SizedBox(height: 24),

              ReservationCalendar(calendarState: calendarState),

              const SizedBox(height: 24),
              if (selectedDate != null) ...[
                TimeSlotPicker(
                  selectedDate: selectedDate,
                  hoursState: hoursState,
                ),
                const SizedBox(height: 24),
              ],
              if (selectedDate != null && selectedTime != null) ...[
                BookingSummaryCard(
                  menu: menu,
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                ),
                const SizedBox(height: 24),
                _buildConfirmButton(context, ref),
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

  Widget _buildConfirmButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        text: 'Confirm Reservation',
        color: AppButtonColor.primary,
        onPressed: () {
          final selectedDate = ref.read(selectedDateProvider);
          final selectedTime = ref.read(selectedTimeProvider);
          final selectedMenu = ref.read(selectedMenuProvider);

          if (selectedDate == null ||
              selectedTime == null ||
              selectedMenu == null) {
            return;
          }

          final timeParts = selectedTime.split(':');
          final hour = int.parse(timeParts[0]);
          final minute = int.parse(timeParts[1]);
          final reservationDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            hour,
            minute,
          );

          final now = DateTime.now();
          final pendingReservation = Reservation(
            id: 0,
            reservationNumber: '',
            createdAt: now,
            updatedAt: now,
            reservationDatetime: reservationDateTime,
            menu: selectedMenu,
            amount: ReservationAmount(
              raw: selectedMenu.price.formatted,
              formatted: selectedMenu.price.formatted,
            ),
            status: const ReservationStatus(
              value: ReservationStatusValue.pending,
              label: 'Pending',
            ),
            numberOfPeople: 1,
            customerInfo: const ReservationCustomerInfo(
              fullName: '',
              fullNameKana: '',
              email: '',
              phoneNumber: '',
              isGuest: false,
            ),
            user: null,
            notes: null,
          );

          ref.read(pendingReservationProvider.notifier).state =
              pendingReservation;

          context.router.push(const ConfirmReservationRoute());
        },
      ),
    );
  }
}
