import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<AnnouncementItem> _announcements = [];
  List<ContactItem> _contacts = [];
  List<ReservationItem> _todayReservations = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _announcements = _generateMockAnnouncements();
          _contacts = _generateMockContacts();
          _todayReservations = _generateMockReservations();
          _isLoading = false;
        });
      }
    });
  }

  void _refreshData() {
    _loadMockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async => _refreshData(),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Announcements Section
          SliverToBoxAdapter(child: _buildAnnouncementsSection(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // To Do Section
          SliverToBoxAdapter(child: _buildToDoSection(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Contact Section
          SliverToBoxAdapter(child: _buildContactSection(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Today's Reservations Section
          SliverToBoxAdapter(child: _buildTodayReservationsSection(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Status Section
          SliverToBoxAdapter(child: _buildStatusSection(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsSection(BuildContext context) {
    return Column(
      children: _announcements.map((announcement) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: context.colorScheme.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.colorScheme.secondary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.campaign,
                  color: context.colorScheme.secondary,
                  size: 20,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              announcement.title,
                              style: AppTextStyle.titleMedium,
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.primary,
                            ),
                          ),
                          AppText(
                            DateFormat(
                              'yyyy-MM-dd HH:mm',
                            ).format(announcement.date),
                            style: AppTextStyle.bodySmall,
                            color: context.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        announcement.description,
                        style: AppTextStyle.bodyMedium,
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.8,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _dismissAnnouncement(announcement),
                icon: const Icon(Icons.close, size: 18),
                tooltip: context.l10n.adminDashboardAnnouncementCloseTooltip,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildToDoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.adminDashboardTodoTitle,
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildToDoCard(
                context,
                context.l10n.adminDashboardTodoTodayReservations,
                '${_todayReservations.length}',
                context.l10n.adminDashboardTodoCasesUnit,
                Icons.event,
                context.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildToDoCard(
                context,
                context.l10n.adminDashboardTodoContacts,
                '${_contacts.length}',
                context.l10n.adminDashboardTodoCasesUnit,
                Icons.mail,
                context.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToDoCard(
    BuildContext context,
    String title,
    String count,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: AppText(
                  title,
                  style: AppTextStyle.bodyMedium,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                count,
                style: AppTextStyle.headlineMedium,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: AppText(
                  unit,
                  style: AppTextStyle.bodySmall,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.adminDashboardContactTitle,
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        if (_contacts.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Center(
              child: AppText(
                context.l10n.adminDashboardContactNoPending,
                style: AppTextStyle.bodyMedium,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.05),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppText(
                          context.l10n.adminDashboardContactReceivedAt,
                          style: AppTextStyle.bodySmall,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: AppText(
                          context.l10n.adminDashboardContactCustomerName,
                          style: AppTextStyle.bodySmall,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: AppText(
                          context.l10n.adminDashboardContactSubject,
                          style: AppTextStyle.bodySmall,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Contact rows
                ..._contacts.take(5).map((contact) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.outline.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AppText(
                            DateFormat(
                              'MM/dd\nHH:mm',
                            ).format(contact.receivedAt),
                            style: AppTextStyle.bodySmall,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: AppText(
                            contact.customerName,
                            style: AppTextStyle.bodySmall,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: AppText(
                            contact.subject,
                            style: AppTextStyle.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                // See more button
                if (_contacts.length > 5)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          // Navigate to contacts page
                        },
                        child: AppText(
                          context.l10n.adminDashboardContactSeeMore,
                          style: AppTextStyle.bodyMedium,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTodayReservationsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.adminDashboardReservationTitle,
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        if (_todayReservations.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Center(
              child: AppText(
                context.l10n.adminDashboardReservationNoReservationsToday,
                style: AppTextStyle.bodyMedium,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.05),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppText(
                          context.l10n.adminDashboardReservationTime,
                          style: AppTextStyle.bodySmall,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: AppText(
                          context.l10n.adminDashboardReservationService,
                          style: AppTextStyle.bodySmall,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: AppText(
                          context.l10n.adminDashboardReservationCustomerName,
                          style: AppTextStyle.bodySmall,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Reservation rows
                ..._todayReservations.map((reservation) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.outline.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AppText(
                            DateFormat('MM/dd\nHH:mm').format(reservation.time),
                            style: AppTextStyle.bodySmall,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: AppText(
                            reservation.service,
                            style: AppTextStyle.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: AppText(
                            reservation.customerName,
                            style: AppTextStyle.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStatusSection(BuildContext context) {
    final now = DateTime.now();
    final monthYear = DateFormat('MMMM yyyy').format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.adminDashboardStatusTitle.replaceAll(':date', monthYear),
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _buildStatusCard(
              context,
              context.l10n.adminDashboardStatusReservations,
              '15',
              context.l10n.adminDashboardStatusCasesUnit,
              Icons.event,
              context.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            _buildStatusCard(
              context,
              context.l10n.adminDashboardStatusNewCustomers,
              '23',
              context.l10n.adminDashboardStatusCasesUnit,
              Icons.person_add,
              context.colorScheme.secondary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusCard(
    BuildContext context,
    String title,
    String count,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: AppText(
              title,
              style: AppTextStyle.titleMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                count,
                style: AppTextStyle.headlineMedium,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              AppText(
                unit,
                style: AppTextStyle.bodySmall,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _dismissAnnouncement(AnnouncementItem announcement) {
    setState(() {
      _announcements.remove(announcement);
    });
  }

  List<AnnouncementItem> _generateMockAnnouncements() {
    return [
      AnnouncementItem(
        id: '1',
        title: '[Welcome to Our New Online Reservation System]',
        description:
            'We are excited to announce the launch of our new online reservation system. You...',
        date: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      AnnouncementItem(
        id: '2',
        title: '[Extended Business Hours During Winter Season]',
        description:
            'Starting December 1st, we will be extending our business hours to better...',
        date: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      AnnouncementItem(
        id: '3',
        title: '[Tire Storage Service Now Available]',
        description:
            'We now offer professional tire storage services. Keep your seasonal tires in...',
        date: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];
  }

  List<ContactItem> _generateMockContacts() {
    return [
      ContactItem(
        id: '1',
        customerName: 'Customer',
        subject: 'Aspernatur tempore quis corrupti.',
        receivedAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      ContactItem(
        id: '2',
        customerName: 'Customer',
        subject: 'In hic officia cum accusamus voluptatem.',
        receivedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ContactItem(
        id: '3',
        customerName: 'Customer',
        subject: 'Velit quae earum aut id velit suscipit.',
        receivedAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      ContactItem(
        id: '4',
        customerName: 'Customer',
        subject: 'Et voluptatum et dolorem ut commodi.',
        receivedAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      ContactItem(
        id: '5',
        customerName: 'Customer',
        subject: 'Deleniti soluta atque voluptatum odit.',
        receivedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];
  }

  List<ReservationItem> _generateMockReservations() {
    return [
      ReservationItem(
        id: '1',
        time: DateTime(2025, 8, 29, 6, 0),
        service: 'Installation of tires purchased at our store',
        customerName: 'Myrtice Barton',
      ),
      ReservationItem(
        id: '2',
        time: DateTime(2025, 8, 29, 9, 0),
        service:
            'Replacement and installation of tires brought in (tires shipped directly to our store)',
        customerName: 'Mas Ambarkusum',
      ),
      ReservationItem(
        id: '3',
        time: DateTime(2025, 8, 29, 9, 0),
        service: 'Installation of tires purchased at our store',
        customerName: 'test',
      ),
    ];
  }
}

// Data models
class AnnouncementItem {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  AnnouncementItem({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
}

class ContactItem {
  final String id;
  final String customerName;
  final String subject;
  final DateTime receivedAt;

  ContactItem({
    required this.id,
    required this.customerName,
    required this.subject,
    required this.receivedAt,
  });
}

class ReservationItem {
  final String id;
  final DateTime time;
  final String service;
  final String customerName;

  ReservationItem({
    required this.id,
    required this.time,
    required this.service,
    required this.customerName,
  });
}
