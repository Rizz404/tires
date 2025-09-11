import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class TodayReservationsSection extends StatelessWidget {
  final List<Reservation> todayReservations;

  const TodayReservationsSection({super.key, required this.todayReservations});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.adminDashboardReservationTitle,
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        if (todayReservations.isEmpty)
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
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTableHeader(context),
                    const Divider(height: 1, thickness: 1),
                    ...todayReservations.map(
                      (reservation) => _buildTableRow(context, reservation),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: context.colorScheme.surface.withOpacity(0.5),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: AppText(
              context.l10n.adminDashboardReservationTime.toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 200,
            child: AppText(
              context.l10n.adminDashboardReservationService.toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              context.l10n.adminDashboardReservationCustomerName.toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Reservation reservation) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: AppText(
              DateFormat('HH:mm').format(reservation.reservationDatetime),
              style: AppTextStyle.bodySmall,
            ),
          ),
          SizedBox(
            width: 200,
            child: AppText(
              reservation.menu.name,
              style: AppTextStyle.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              reservation.user?.fullName ?? reservation.customerInfo.fullName,
              style: AppTextStyle.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
