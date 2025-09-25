import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/availability/presentation/providers/availability_providers.dart';
import 'package:tires/features/availability/presentation/providers/reservation_availability_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_state.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/features/availability/presentation/widgets/availability_date_info_item.dart';
import 'package:tires/features/availability/presentation/widgets/availability_legend_item.dart';
import 'package:tires/features/availability/presentation/widgets/availability_status_chip.dart';
import 'package:tires/features/availability/presentation/widgets/availability_time_slot_item.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminListAvailabilityScreen extends ConsumerStatefulWidget {
  const AdminListAvailabilityScreen({super.key});

  @override
  ConsumerState<AdminListAvailabilityScreen> createState() =>
      _AdminListAvailabilityScreenState();
}

class _AdminListAvailabilityScreenState
    extends ConsumerState<AdminListAvailabilityScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  DateTime _selectedDate = DateTime.now();
  int? _selectedMenuId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialAvailabilityData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialAvailabilityData() async {
    // Get menus state (auto-loaded by AdminMenusNotifier)
    final menusState = ref.read(adminMenuGetNotifierProvider);

    // If menus are loaded and available, set first menu and load availability
    if (menusState.status == AdminMenusStatus.success &&
        menusState.menus.isNotEmpty) {
      setState(() {
        _selectedMenuId = menusState.menus.first.id;
      });
      await _loadAvailabilityData();
    }
    // If still loading, wait and try again
    else if (menusState.status == AdminMenusStatus.loading) {
      await Future.delayed(const Duration(milliseconds: 200));
      return _loadInitialAvailabilityData();
    }
  }

  Future<void> _loadAvailabilityData() async {
    if (_selectedMenuId != null) {
      final startDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
      );
      final endDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        23,
        59,
        59,
      );

      await ref
          .read(reservationAvailabilityNotifierProvider.notifier)
          .getReservationAvailability(
            menuId: _selectedMenuId!,
            startDate: startDate,
            endDate: endDate,
          );
    }
  }

  Future<void> _refreshData() async {
    await _loadInitialAvailabilityData();
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
    _loadAvailabilityData();
  }

  void _onMenuChanged(int? newMenuId) {
    setState(() {
      _selectedMenuId = newMenuId;
    });
    _loadAvailabilityData();
  }

  void _navigateToPreviousDay() {
    final previousDay = _selectedDate.subtract(const Duration(days: 1));
    _onDateChanged(previousDay);
  }

  void _navigateToNextDay() {
    final nextDay = _selectedDate.add(const Duration(days: 1));
    _onDateChanged(nextDay);
  }

  @override
  Widget build(BuildContext context) {
    final availabilityState = ref.watch(
      reservationAvailabilityNotifierProvider,
    );
    final menusState = ref.watch(adminMenuGetNotifierProvider);

    // Listen to menu state changes and auto-select first menu when available
    ref.listen<AdminMenusState>(adminMenuGetNotifierProvider, (previous, next) {
      if (previous?.status != AdminMenusStatus.success &&
          next.status == AdminMenusStatus.success &&
          next.menus.isNotEmpty &&
          _selectedMenuId == null) {
        setState(() {
          _selectedMenuId = next.menus.first.id;
        });
        _loadAvailabilityData();
      }
    });

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: FormBuilder(
          key: _formKey,
          child: _buildBody(context, availabilityState, menusState),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ReservationAvailabilityState availabilityState,
    dynamic menusState,
  ) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildDateSelector(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildMenuSelector(context, menusState)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildDateInfo(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: _buildTimeAvailability(context, availabilityState),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildLegend(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            context.l10n.adminListAvailabilityScreenPageTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.adminListAvailabilityScreenPageSubtitle,
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context.l10n.adminListAvailabilityScreenFormDateLabel,
              style: AppTextStyle.titleMedium,
            ),
            const SizedBox(height: 8),
            FormBuilderDateTimePicker(
              name: 'date',
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText:
                    context.l10n.adminListAvailabilityScreenFormDateLabel,
                suffixIcon: const Icon(Icons.calendar_today_outlined),
              ),
              initialValue: _selectedDate,
              onChanged: (DateTime? newDate) {
                if (newDate != null) {
                  _onDateChanged(newDate);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInfo(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton.icon(
              onPressed: _navigateToPreviousDay,
              icon: const Icon(Icons.chevron_left),
              label: Text(
                context.l10n.adminListAvailabilityScreenButtonsPrevious,
              ),
            ),
            OutlinedButton.icon(
              onPressed: _navigateToNextDay,
              label: Text(context.l10n.adminListAvailabilityScreenButtonsNext),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          color: context.colorScheme.primaryContainer.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AvailabilityDateInfoItem(
                  title: context.l10n.adminListAvailabilityScreenSummaryDate,
                  value: DateFormat('dd').format(_selectedDate),
                ),
                AvailabilityDateInfoItem(
                  title: context.l10n.adminListAvailabilityScreenSummaryMonth,
                  value: DateFormat('MM').format(_selectedDate),
                ),
                AvailabilityDateInfoItem(
                  title: context.l10n.adminListAvailabilityScreenSummaryYear,
                  value: DateFormat('yyyy').format(_selectedDate),
                ),
                AvailabilityDateInfoItem(
                  title: context
                      .l10n
                      .adminListAvailabilityScreenSummaryCurrentTime,
                  value: DateFormat('HH:mm').format(DateTime.now()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSelector(BuildContext context, dynamic menusState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context.l10n.adminListAvailabilityScreenFormMenuLabel,
              style: AppTextStyle.titleMedium,
            ),
            const SizedBox(height: 8),
            FormBuilderDropdown<int>(
              name: 'menu',
              decoration: InputDecoration(
                labelText:
                    context.l10n.adminListAvailabilityScreenFormMenuLabel,
              ),
              items: menusState.menus
                  .map<DropdownMenuItem<int>>(
                    (menu) => DropdownMenuItem<int>(
                      value: menu.id,
                      child: Text(
                        '${menu.name} (${menu.requiredTime} ${context.l10n.adminListAvailabilityScreenFormMenuMinutes})',
                      ),
                    ),
                  )
                  .toList(),
              initialValue: _selectedMenuId,
              onChanged: (int? newMenuId) {
                _onMenuChanged(newMenuId);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeAvailability(
    BuildContext context,
    ReservationAvailabilityState availabilityState,
  ) {
    if (availabilityState.status == ReservationAvailabilityStatus.loading) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              AppText(
                context.l10n.adminListAvailabilityScreenLoadingText,
                style: AppTextStyle.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (availabilityState.status == ReservationAvailabilityStatus.error) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: context.colorScheme.error,
                size: 48,
              ),
              const SizedBox(height: 16),
              AppText(
                availabilityState.errorMessage ?? 'An error occurred',
                style: AppTextStyle.bodyMedium,
                color: context.colorScheme.error,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final availabilityDate =
        availabilityState.availabilityDates?.isNotEmpty == true
        ? availabilityState.availabilityDates!.first
        : null;

    if (availabilityDate == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(
                Icons.event_busy,
                color: context.colorScheme.onSurface.withOpacity(0.5),
                size: 48,
              ),
              const SizedBox(height: 16),
              AppText(
                context.l10n.adminListAvailabilityScreenEmptyTitle,
                style: AppTextStyle.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              AppText(
                context.l10n.adminListAvailabilityScreenEmptyDescription,
                style: AppTextStyle.bodyMedium,
                color: context.colorScheme.onSurface.withOpacity(0.7),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final availableSlots = availabilityDate.availableHours
        .where((slot) => slot.available && slot.blockedBy == null)
        .length;
    final reservedSlots = availabilityDate.availableHours
        .where((slot) => !slot.available && slot.blockedBy == null)
        .length;
    final blockedSlots = availabilityDate.availableHours
        .where((slot) => slot.blockedBy != null)
        .length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context.l10n.adminListAvailabilityScreenAvailabilityTitle,
              style: AppTextStyle.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  DateFormat('MMMM dd, yyyy').format(_selectedDate),
                  style: AppTextStyle.bodyLarge,
                ),
                AppText(
                  DateFormat('EEEE').format(_selectedDate),
                  style: AppTextStyle.bodyMedium,
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                AvailabilityStatusChip(
                  label:
                      '$availableSlots ${context.l10n.adminListAvailabilityScreenAvailabilityAvailableSlots}',
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),
                AvailabilityStatusChip(
                  label:
                      '$reservedSlots ${context.l10n.adminListAvailabilityScreenAvailabilityReservedSlots}',
                  color: Colors.orange,
                  icon: Icons.watch_later,
                ),
                AvailabilityStatusChip(
                  label:
                      '$blockedSlots ${context.l10n.adminListAvailabilityScreenAvailabilityBlockedSlots}',
                  color: context.colorScheme.error,
                  icon: Icons.block,
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: availabilityDate.availableHours.length,
              itemBuilder: (context, index) {
                final slot = availabilityDate.availableHours[index];
                return AvailabilityTimeSlotItem(
                  time: slot.hour,
                  isAvailable: slot.available && slot.blockedBy == null,
                  isReserved: !slot.available && slot.blockedBy == null,
                  isBlocked: slot.blockedBy != null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvailabilityLegendItem(
              icon: Icons.check_circle_outline,
              color: Colors.green,
              title:
                  context.l10n.adminListAvailabilityScreenLegendAvailableTitle,
              subtitle: context
                  .l10n
                  .adminListAvailabilityScreenLegendAvailableDescription,
            ),
            const SizedBox(height: 12),
            AvailabilityLegendItem(
              icon: Icons.watch_later_outlined,
              color: Colors.orange,
              title:
                  context.l10n.adminListAvailabilityScreenLegendReservedTitle,
              subtitle: context
                  .l10n
                  .adminListAvailabilityScreenLegendReservedDescription,
            ),
            const SizedBox(height: 12),
            AvailabilityLegendItem(
              icon: Icons.block,
              color: context.colorScheme.error,
              title: context.l10n.adminListAvailabilityScreenLegendBlockedTitle,
              subtitle: context
                  .l10n
                  .adminListAvailabilityScreenLegendBlockedDescription,
            ),
          ],
        ),
      ),
    );
  }
}
