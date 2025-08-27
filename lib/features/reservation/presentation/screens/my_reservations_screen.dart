import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/reservation/presentation/widgets/reservation_item.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class MyReservationsScreen extends StatefulWidget {
  const MyReservationsScreen({super.key});

  @override
  State<MyReservationsScreen> createState() => _MyReservationsScreenState();
}

class _MyReservationsScreenState extends State<MyReservationsScreen> {
  String? _expandedReservationId;

  final List<Reservation> _mockReservations = [
    Reservation(
      id: 1,
      reservationNumber: '202508121514',
      menu: const Menu(
        id: 101,
        name:
            'Change tires by bringing your own (removal and removal of season tires, etc.)',
        description: 'Includes tire balancing and pressure check.',
        requiredTime: 30,
        price: Price(amount: '30000', formatted: '¥30,000', currency: 'JPY'),
        displayOrder: 1,
        isActive: true,
        color: ColorInfo(hex: '#FFA726', rgbaLight: '', textColor: ''),
      ),
      status: ReservationStatus.pending,
      reservationDatetime: DateTime(2025, 8, 27, 17, 0),
      numberOfPeople: 1,
      notes: 'Booking via website. Customer will wait in the lounge.',
      amount: 30000,
      fullName: 'Budi Santoso',
      fullNameKana: 'ブディ サントソ',
      email: 'budi.santoso@example.com',
      phoneNumber: '0812-3456-7890',
      createdAt: DateTime(2025, 8, 12, 15, 14),
      updatedAt: DateTime(2025, 8, 12, 15, 14),
    ),
    Reservation(
      id: 2,
      reservationNumber: '202507201030',
      menu: const Menu(
        id: 102,
        name: 'Premium Car Wash & Wax',
        description:
            'Exterior wash, interior vacuum, and premium waxing service.',
        requiredTime: 60,
        price: Price(amount: '50000', formatted: '¥50,000', currency: 'JPY'),
        displayOrder: 2,
        isActive: true,
        color: ColorInfo(hex: '#42A5F5', rgbaLight: '', textColor: ''),
      ),
      status: ReservationStatus.confirmed,
      reservationDatetime: DateTime(2025, 8, 20, 10, 30),
      numberOfPeople: 1,
      amount: 50000,
      fullName: 'Citra Lestari',
      fullNameKana: 'チトラ レスタリ',
      email: 'citra.lestari@example.com',
      phoneNumber: '0811-2233-4455',
      notes: null,
      createdAt: DateTime(2025, 7, 20, 10, 30),
      updatedAt: DateTime(2025, 7, 21, 11, 0),
    ),
    Reservation(
      id: 3,
      reservationNumber: '202506150900',
      menu: const Menu(
        id: 103,
        name: 'Basic Maintenance Check',
        description: 'Includes oil check, fluid levels, and brake inspection.',
        requiredTime: 45,
        price: Price(amount: '45000', formatted: '¥45,000', currency: 'JPY'),
        displayOrder: 3,
        isActive: true,
        color: ColorInfo(hex: '#66BB6A', rgbaLight: '', textColor: ''),
      ),
      status: ReservationStatus.completed,
      reservationDatetime: DateTime(2025, 6, 15, 9, 0),
      numberOfPeople: 1,
      amount: 45000,
      fullName: 'Ahmad Subarjo',
      fullNameKana: 'アフマド スバルジョ',
      email: 'ahmad.subarjo@example.com',
      phoneNumber: '0856-7890-1234',
      notes: 'Customer reported a slight noise from the front right wheel.',
      createdAt: DateTime(2025, 6, 1, 18, 0),
      updatedAt: DateTime(2025, 6, 15, 10, 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(child: _buildStatsCard(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            _buildReservationList(context), // Gunakan SliverList untuk daftar
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.router.push( CreateReservationRoute(menu: menu));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Method untuk membuat daftar reservasi dengan header tanggal
  Widget _buildReservationList(BuildContext context) {
    if (_mockReservations.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: AppText('No reservations found.')),
      );
    }

    // Urutkan reservasi dari yang terbaru ke terlama
    final sortedReservations = List<Reservation>.from(_mockReservations)
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

  Widget _buildStatsCard(BuildContext context) {
    final pendingCount = _mockReservations
        .where((r) => r.status == ReservationStatus.pending)
        .length;
    final confirmedCount = _mockReservations
        .where((r) => r.status == ReservationStatus.confirmed)
        .length;

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
              count: _mockReservations.length,
              label: 'Total Reservations',
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
