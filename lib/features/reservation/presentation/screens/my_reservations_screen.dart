import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/reservation/presentation/widgets/reservation_item.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/features/user/presentation/providers/current_user_providers.dart';
import 'package:tires/features/user/presentation/providers/current_user_reservations_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_dashboard_get_state.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class MyReservationsScreen extends ConsumerStatefulWidget {
  const MyReservationsScreen({super.key});

  @override
  ConsumerState<MyReservationsScreen> createState() =>
      _MyReservationsScreenState();
}

class _MyReservationsScreenState extends ConsumerState<MyReservationsScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _expandedReservationId;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(currentUserReservationsNotifierProvider.notifier)
          .loadMoreReservations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(child: _buildBody()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const HomeRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    final state = ref.watch(currentUserReservationsNotifierProvider);
    final dashboardState = ref.watch(currentUserDashboardGetNotifierProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          ref
              .read(currentUserReservationsNotifierProvider.notifier)
              .refreshReservations(),
          ref
              .read(currentUserDashboardGetNotifierProvider.notifier)
              .refreshDashboard(),
        ]);
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildStatsCard(context, dashboardState)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          // Add debug section in development
          // if (true) // Replace with kDebugMode for production
          //   SliverToBoxAdapter(child: _buildDebugSection(context)),
          _buildReservationList(context, state),
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (state.status == CurrentUserReservationsStatus.loadingMore)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*  Widget _buildDebugSection(BuildContext context) {
    return DebugSection(
      title: '🔧 Reservation Debug Tools',
      actions: [
        DebugAction.refresh(
          label: 'Refresh with Debug',
          onPressed: () {
            ref
                .read(currentUserReservationsNotifierProvider.notifier)
                .getInitialReservations();
          },
          debugEndpoint: 'Manual Refresh Triggered - Reservations',
        ),
        DebugAction.clear(
          label: 'Clear Cache',
          onPressed: () {
            // Add cache clearing logic here if needed
            ref
                .read(currentUserReservationsNotifierProvider.notifier)
                .refreshReservations();
          },
        ),
        DebugAction.testApi(
          label: 'Test Load More',
          onPressed: () {
            ref
                .read(currentUserReservationsNotifierProvider.notifier)
                .loadMoreReservations();
          },
        ),
        DebugAction.viewLogs(
          label: 'Show Logs',
          context: context,
          message: 'Check console for reservation debugging logs',
        ),
        DebugAction.inspect(
          label: 'Inspect State',
          onPressed: () {
            final state = ref.read(currentUserReservationsNotifierProvider);
            DebugHelper.logApiResponse({
              'status': state.status.toString(),
              'reservations_count': state.reservations.length,
              'has_next_page': state.hasNextPage,
              'cursor': state.cursor?.toString(),
              'error_message': state.errorMessage,
            }, endpoint: 'Current Reservations State');
          },
        ),
      ],
    );
  }
 */
  // Method untuk membuat daftar reservasi dengan header tanggal
  Widget _buildReservationList(
    BuildContext context,
    CurrentUserReservationsState state,
  ) {
    // Initial loading state - show loading indicator
    if (state.status == CurrentUserReservationsStatus.loading &&
        state.reservations.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Error state - show error message with retry button
    if (state.status == CurrentUserReservationsStatus.error &&
        state.reservations.isEmpty) {
      debugPrint('Error: ${state.errorMessage}');
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  state.errorMessage ?? 'An unknown error occurred.',
                  style: AppTextStyle.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(currentUserReservationsNotifierProvider.notifier)
                        .getInitialReservations();
                  },
                  child: const AppText('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // No reservations available
    if (state.reservations.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: AppText(
              'No reservations found.',
              style: AppTextStyle.bodyMedium,
            ),
          ),
        ),
      );
    }

    // Urutkan reservasi dari yang terbaru ke terlama
    final sortedReservations = List<Reservation>.from(state.reservations)
      ..sort((a, b) => b.reservationDatetime.compareTo(a.reservationDatetime));

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final reservation = sortedReservations[index];
        final bool isFirst = index == 0;
        final bool isNewDay =
            !isFirst &&
            !DateUtils.isSameDay(
              sortedReservations[index - 1].reservationDatetime,
              reservation.reservationDatetime,
            );

        if (isFirst || isNewDay) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(context, reservation.reservationDatetime),
              _buildReservationItem(reservation),
            ],
          );
        }
        return _buildReservationItem(reservation);
      }, childCount: sortedReservations.length),
    );
  }

  // Helper untuk membuat item reservasi
  Widget _buildReservationItem(Reservation reservation) {
    return ReservationItem(
      reservation: reservation,
      isExpanded: _expandedReservationId == reservation.reservationNumber,
      onTap: () {
        setState(() {
          if (_expandedReservationId == reservation.reservationNumber) {
            _expandedReservationId = null;
          } else {
            _expandedReservationId = reservation.reservationNumber;
          }
        });
      },
    );
  }

  // Helper untuk membuat header tanggal
  Widget _buildDateHeader(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final itemDate = DateTime(date.year, date.month, date.day);

    String headerText;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();

    if (itemDate == today) {
      headerText = l10n.dateToday;
    } else if (itemDate == tomorrow) {
      headerText = l10n.dateTomorrow;
    } else {
      headerText = DateFormat.yMMMMd(locale).format(date);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4),
      child: AppText(
        headerText,
        style: AppTextStyle.titleMedium,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            context.l10n.myReservationMainTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.myReservationMainSubTitle,
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(
    BuildContext context,
    CurrentUserDashboardGetState dashboardState,
  ) {
    // Show loading state when dashboard is loading
    if (dashboardState.status == CurrentUserDashboardGetStatus.loading) {
      return Card(
        elevation: 2,
        shadowColor: context.theme.shadowColor.withValues(alpha: 0.05),
        child: const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Show error state or fallback to local data
    if (dashboardState.status == CurrentUserDashboardGetStatus.error ||
        dashboardState.dashboard == null) {
      // Fallback to local reservation data calculation
      final reservationsState = ref.watch(
        currentUserReservationsNotifierProvider,
      );
      final reservations = reservationsState.reservations;
      final pendingCount = reservations
          .where((r) => r.status.value == ReservationStatusValue.pending)
          .length;
      final confirmedCount = reservations
          .where((r) => r.status.value == ReservationStatusValue.confirmed)
          .length;

      return Card(
        elevation: 2,
        shadowColor: context.theme.shadowColor.withValues(alpha: 0.05),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    context,
                    count: reservations.length,
                    label: context.l10n.myReservationTotalReservations,
                  ),
                  _buildStatItem(
                    context,
                    count: pendingCount,
                    label: context.l10n.reservationStatusPending,
                  ),
                  _buildStatItem(
                    context,
                    count: confirmedCount,
                    label: context.l10n.reservationStatusConfirmed,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Use dashboard summary data
    final summary = dashboardState.dashboard!.summary;
    return Card(
      elevation: 2,
      shadowColor: context.theme.shadowColor.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              context,
              count: summary.totalReservations,
              label: context.l10n.myReservationTotalReservations,
            ),
            _buildStatItem(
              context,
              count: summary.pendingReservations,
              label: context.l10n.reservationStatusPending,
            ),
            _buildStatItem(
              context,
              count: summary.completedReservations,
              label: context.l10n.reservationStatusConfirmed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        AppText(
          count.toString(),
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 4),
        AppText(
          label,
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }
}
