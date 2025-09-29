import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/routes/app_router.dart';

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
import 'package:tires/features/calendar/presentation/widgets/calendar_list_view_toggle_widget.dart';
import 'package:tires/features/calendar/presentation/widgets/calendar_filter_search_widget.dart';
import 'package:tires/features/calendar/presentation/widgets/reservation_table_widget.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_providers.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_get_state.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

  // List view variables
  CalendarDisplayMode _displayMode = CalendarDisplayMode.calendar;
  final GlobalKey<FormBuilderState> _filterFormKey =
      GlobalKey<FormBuilderState>();
  bool _isFilterVisible = true;

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

    // Also refresh reservations for list view
    if (_displayMode == CalendarDisplayMode.list) {
      await ref
          .read(reservationGetNotifierProvider.notifier)
          .refreshReservations();
    }
  }

  Future<void> _applyFilters() async {
    if (_displayMode == CalendarDisplayMode.list) {
      // Apply filters to reservation list
      // For now, just refresh the data - filtering logic can be implemented later
      await ref
          .read(reservationGetNotifierProvider.notifier)
          .refreshReservations();
    }
  }

  void _resetFilters() {
    _filterFormKey.currentState?.reset();
    _applyFilters();
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
              // Display Mode Toggle (Calendar vs List)
              SliverToBoxAdapter(
                child: CalendarListViewToggleWidget(
                  currentMode: _displayMode,
                  onModeChanged: (mode) async {
                    setState(() {
                      _displayMode = mode;
                    });
                    if (mode == CalendarDisplayMode.list) {
                      // Load reservation data when switching to list view
                      await ref
                          .read(reservationGetNotifierProvider.notifier)
                          .getReservations();
                    }
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              // Calendar View Toggle (only show in calendar mode)
              if (_displayMode == CalendarDisplayMode.calendar)
                SliverToBoxAdapter(
                  child: CalendarViewToggleWidget(
                    currentView: _currentView,
                    onViewChanged: (view) async {
                      setState(() {
                        _currentView = view;
                        _calendarFormat =
                            view == GetCalendarDataParamsView.month
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
              // Filter for list mode
              if (_displayMode == CalendarDisplayMode.list)
                SliverToBoxAdapter(
                  child: CalendarFilterSearchWidget(
                    formKey: _filterFormKey,
                    isFilterVisible: _isFilterVisible,
                    onToggleVisibility: () =>
                        setState(() => _isFilterVisible = !_isFilterVisible),
                    onFilter: _applyFilters,
                    onReset: _resetFilters,
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              // Main content based on display mode
              if (_displayMode == CalendarDisplayMode.calendar) ...[
                SliverToBoxAdapter(child: _buildCalendarView()),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: ReservationsListWidget(
                    selectedDay: _selectedDay ?? DateTime.now(),
                    reservations: _getEventsForDay(
                      _selectedDay ?? DateTime.now(),
                    ),
                    onReservationTap: (calendarReservation) {
                      context.router.push(AdminUpsertReservationRoute());
                    },
                  ),
                ),
              ] else ...[
                SliverToBoxAdapter(child: _buildListView()),
              ],
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

  Widget _buildListView() {
    final reservationState = ref.watch(reservationGetNotifierProvider);

    return ReservationTableWidget(
      reservations: reservationState.reservations,
      isLoading: reservationState.status == ReservationGetStatus.loading,
      onRefresh: () async {
        await ref
            .read(reservationGetNotifierProvider.notifier)
            .refreshReservations();
      },
    );
  }
}
