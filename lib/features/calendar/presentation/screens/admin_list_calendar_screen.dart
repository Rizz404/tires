import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart'
    as reservation_entity;
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';

import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/calendar/presentation/providers/calendar_providers.dart';
import 'package:tires/features/calendar/presentation/providers/calendar_state.dart';
import 'package:tires/features/calendar/domain/usecases/get_calendar_data_usecase.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';
import 'package:tires/features/calendar/presentation/widgets/calendar_stats_widget.dart';
import 'package:tires/features/calendar/presentation/widgets/calendar_view_toggle_widget.dart';
import 'package:tires/features/calendar/presentation/widgets/month_calendar_widget.dart';
import 'package:tires/features/calendar/presentation/widgets/calendar_navigation_widget.dart';
import 'package:tires/features/calendar/presentation/widgets/day_view_widget.dart';
import 'package:tires/features/calendar/presentation/widgets/week_view_widget.dart';
import 'package:tires/features/calendar/presentation/widgets/reservations_list_widget.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

@RoutePage()
class AdminListCalendarScreen extends ConsumerStatefulWidget {
  const AdminListCalendarScreen({super.key});

  @override
  ConsumerState<AdminListCalendarScreen> createState() =>
      _AdminListCalendarScreenState();
}

class _AdminListCalendarScreenState
    extends ConsumerState<AdminListCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  GetCalendarDataParamsView _currentView = GetCalendarDataParamsView.month;
  GetCalendarDataParamsView? _lastFetchedView;
  DateTime? _lastFetchedDate;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCalendarData();
    });
  }

  Future<void> _loadCalendarData() async {
    // Determine the appropriate date parameter based on current view
    DateTime dateParam;
    switch (_currentView) {
      case GetCalendarDataParamsView.day:
        dateParam = _selectedDay ?? _focusedDay;
        break;
      case GetCalendarDataParamsView.week:
      case GetCalendarDataParamsView.month:
        dateParam = _focusedDay;
        break;
    }

    // Determine if we need to force refresh
    bool needsForceRefresh =
        _lastFetchedView != _currentView ||
        _lastFetchedDate == null ||
        !_isSamePeriod(_lastFetchedDate!, dateParam, _currentView);

    await ref
        .read(calendarNotifierProvider.notifier)
        .getCalendarData(
          month: dateParam,
          view: _currentView,
          forceRefresh: needsForceRefresh,
        );

    // Update tracking
    _lastFetchedView = _currentView;
    _lastFetchedDate = dateParam;
  }

  bool _isSamePeriod(
    DateTime date1,
    DateTime date2,
    GetCalendarDataParamsView view,
  ) {
    switch (view) {
      case GetCalendarDataParamsView.day:
        return date1.year == date2.year &&
            date1.month == date2.month &&
            date1.day == date2.day;
      case GetCalendarDataParamsView.week:
        // Check if both dates are in the same week
        final startOfWeek1 = date1.subtract(Duration(days: date1.weekday - 1));
        final startOfWeek2 = date2.subtract(Duration(days: date2.weekday - 1));
        return startOfWeek1.year == startOfWeek2.year &&
            startOfWeek1.month == startOfWeek2.month &&
            startOfWeek1.day == startOfWeek2.day;
      case GetCalendarDataParamsView.month:
        return date1.year == date2.year && date1.month == date2.month;
    }
  }

  Future<void> _refreshData() async {
    // Force refresh by clearing tracking
    _lastFetchedView = null;
    _lastFetchedDate = null;
    await _loadCalendarData();
  }

  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      // If we're in day view, refetch data for the selected day
      if (_currentView == GetCalendarDataParamsView.day) {
        await _loadCalendarData();
      }
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    // Prevent unwanted format changes during scroll by ignoring them
    // Format should only change through the view toggle widget
    return;
  }

  Future<void> _onPageChanged(DateTime focusedDay) async {
    // Only update if the focused day actually changed to prevent unnecessary calls during scroll
    if (!isSameDay(_focusedDay, focusedDay)) {
      setState(() {
        _focusedDay = focusedDay;
      });
      // Force refetch data for the new focused day
      await _loadCalendarData();
    }
  }

  /// Convert calendar reservation to full reservation entity
  reservation_entity.Reservation _convertCalendarReservationToFull(
    CalendarReservation calendarReservation,
  ) {
    debugPrint('DEBUG: Converting calendar reservation:');
    debugPrint('DEBUG: - Reservation ID: ${calendarReservation.id}');
    debugPrint('DEBUG: - Menu ID: ${calendarReservation.menu.id}');
    debugPrint('DEBUG: - Menu Name: ${calendarReservation.menu.name}');
    debugPrint('DEBUG: - Customer: ${calendarReservation.customer.name}');

    // Parse time string to DateTime
    final now = DateTime.now();
    final timeParts = calendarReservation.time.split(':');
    final hour = int.tryParse(timeParts[0]) ?? 0;
    final minute = int.tryParse(timeParts.length > 1 ? timeParts[1] : '0') ?? 0;

    final reservationDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Parse amount string to int
    final amountString = calendarReservation.amount.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    final amountInt = int.tryParse(amountString) ?? 0;

    // Parse menu price amount
    final menuPriceString = calendarReservation.menu.price.amount.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    final menuPriceInt = int.tryParse(menuPriceString) ?? 0;

    return reservation_entity.Reservation(
      id: calendarReservation.id,
      reservationNumber: calendarReservation.reservationNumber,
      user: null, // Not available in calendar data
      customerInfo: ReservationCustomerInfo(
        fullName: calendarReservation.customer.name ?? 'Unknown',
        fullNameKana: '', // Not available in calendar data
        email: calendarReservation.customer.email ?? '',
        phoneNumber: calendarReservation.customer.phone ?? '',
        isGuest: calendarReservation.customer.type == 'guest',
      ),
      menu: Menu(
        id: calendarReservation.menu.id, // Use actual menu ID from API
        name: calendarReservation.menu.name,
        description: calendarReservation.menu.description,
        requiredTime: calendarReservation.menu.requiredTime,
        price: Price(
          amount: menuPriceInt.toString(),
          formatted: calendarReservation.menu.price.formatted,
          currency: calendarReservation.menu.price.currency,
        ),
        photoPath: calendarReservation.menu.photoPath,
        displayOrder: calendarReservation.menu.displayOrder,
        color: ColorInfo(
          hex: calendarReservation.menu.color.hex,
          rgbaLight: calendarReservation.menu.color.rgbaLight,
          textColor: calendarReservation.menu.color.textColor,
        ),
        isActive: calendarReservation.menu.isActive,
        translations: null, // TODO: Map translations properly if needed
      ),
      reservationDatetime: reservationDateTime,
      numberOfPeople: calendarReservation.peopleCount,
      amount: ReservationAmount(
        raw: amountInt.toString(),
        formatted: calendarReservation.amount,
      ),
      status: ReservationStatus(
        value: _parseReservationStatus(calendarReservation.status),
        label: calendarReservation.status,
      ),
      notes: null, // Not available in calendar data
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Parse reservation status string to enum
  ReservationStatusValue _parseReservationStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return ReservationStatusValue.pending;
      case 'confirmed':
        return ReservationStatusValue.confirmed;
      case 'completed':
        return ReservationStatusValue.completed;
      case 'cancelled':
        return ReservationStatusValue.cancelled;
      default:
        return ReservationStatusValue.pending;
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            context.l10n.adminListCalendarScreenHeaderTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.adminListCalendarScreenHeaderSubtitle,
            style: AppTextStyle.bodyLarge,
          ),
          const SizedBox(height: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: 'Add Reservation',
            leadingIcon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(AdminUpsertReservationRoute());
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarNotifierProvider);
    final selectedDayReservations = _getEventsForDay(
      _selectedDay ?? DateTime.now(),
    );

    return Scaffold(
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: CalendarStatsWidget(
                  isLoading: state.status == CalendarStatus.loading,
                  hasError: state.status == CalendarStatus.error,
                  errorMessage: state.errorMessage,
                  statistics: state.calendarData?.statistics,
                  onRetry: _refreshData,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: CalendarViewToggleWidget(
                  currentView: _currentView,
                  onViewChanged: (view) async {
                    setState(() {
                      _currentView = view;
                      _calendarFormat = view == GetCalendarDataParamsView.month
                          ? CalendarFormat.month
                          : CalendarFormat.week;
                    });
                    // Force refetch data for the new view by clearing tracking
                    _lastFetchedView = null;
                    _lastFetchedDate = null;
                    await _loadCalendarData();
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: _buildCalendarView()),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: ReservationsListWidget(
                  selectedDay: _selectedDay ?? DateTime.now(),
                  reservations: selectedDayReservations,
                  onReservationTap: (calendarReservation) {
                    // Convert calendar reservation to full reservation entity
                    final fullReservation = _convertCalendarReservationToFull(
                      calendarReservation,
                    );
                    context.router.push(
                      AdminUpsertReservationRoute(reservation: fullReservation),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    if (_currentView == GetCalendarDataParamsView.day) {
      return DayViewWidget(
        selectedDay: _selectedDay ?? DateTime.now(),
        reservations: _getEventsForDay(_selectedDay ?? DateTime.now()),
        onPreviousDay: () async {
          setState(() {
            _selectedDay =
                _selectedDay?.subtract(const Duration(days: 1)) ??
                DateTime.now().subtract(const Duration(days: 1));
            _focusedDay = _selectedDay!;
          });
          // Force refetch data for the new day
          await _loadCalendarData();
        },
        onNextDay: () async {
          setState(() {
            _selectedDay =
                _selectedDay?.add(const Duration(days: 1)) ??
                DateTime.now().add(const Duration(days: 1));
            _focusedDay = _selectedDay!;
          });
          // Force refetch data for the new day
          await _loadCalendarData();
        },
      );
    }

    if (_currentView == GetCalendarDataParamsView.week) {
      return Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CalendarNavigationWidget(
                focusedDay: _focusedDay,
                viewMode: CalendarViewMode.week,
                onPrevious: () async {
                  setState(() {
                    _focusedDay = _focusedDay.subtract(const Duration(days: 7));
                  });
                  // Force refetch data for the new week
                  await _loadCalendarData();
                },
                onNext: () async {
                  setState(() {
                    _focusedDay = _focusedDay.add(const Duration(days: 7));
                  });
                  // Force refetch data for the new week
                  await _loadCalendarData();
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          WeekViewWidget(
            selectedWeek: _focusedDay,
            eventLoader: _getEventsForDay,
            onDaySelected: _onDaySelected,
            selectedDay: _selectedDay,
          ),
        ],
      );
    }

    // Month view - use built-in calendar navigation
    return MonthCalendarWidget(
      focusedDay: _focusedDay,
      selectedDay: _selectedDay,
      calendarFormat: _calendarFormat,
      eventLoader: _getEventsForDay,
      onDaySelected: _onDaySelected,
      onFormatChanged: _onFormatChanged,
      onPageChanged: _onPageChanged,
    );
  }

  List<CalendarReservation> _getEventsForDay(DateTime day) {
    final state = ref.watch(calendarNotifierProvider);
    final calendarData = state.calendarData;

    if (calendarData == null) return [];

    final dayString = DateFormat('yyyy-MM-dd').format(day);
    final calendarDay = calendarData.calendarData.firstWhere(
      (d) => d.date == dayString,
      orElse: () => const CalendarDay(
        date: '',
        day: 0,
        isCurrentMonth: false,
        isToday: false,
        dayName: '',
        reservations: [],
        totalReservations: 0,
      ),
    );

    return calendarDay.reservations;
  }
}
