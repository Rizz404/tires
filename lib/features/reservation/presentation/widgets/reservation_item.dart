// file: lib/features/reservation/presentation/widgets/reservation_item.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/user/domain/entities/reservation.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class ReservationItem extends StatelessWidget {
  final Reservation reservation;
  final bool isExpanded;
  final VoidCallback onTap;

  const ReservationItem({
    super.key,
    required this.reservation,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isExpanded ? 4 : 2,
      shadowColor: context.theme.shadowColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCollapsedHeader(context),
              _buildExpandedDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsedHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                reservation.menu.name,
                style: AppTextStyle.titleMedium,
                fontWeight: FontWeight.bold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // --- PERBAIKAN OVERFLOW ---
                  // Bungkus dengan Flexible agar bisa menyusut jika ruang terbatas.
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: AppText(
                        '#${reservation.reservationNumber}',
                        style: AppTextStyle.labelSmall,
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow
                            .ellipsis, // Cegah teks overflow di dalam chip
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  AppText(
                    '${reservation.menu.requiredTime} ${context.l10n.timeMinutes}',
                    style: AppTextStyle.bodySmall,
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildStatusBadge(context, reservation.status),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context, ReservationStatus status) {
    final l10n = context.l10n;
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case ReservationStatus.confirmed:
        backgroundColor = AppTheme.success.withOpacity(0.15);
        textColor = AppTheme.success;
        text = l10n.reservationStatusConfirmed;
        break;
      case ReservationStatus.pending:
        backgroundColor = AppTheme.warning.withOpacity(0.15);
        textColor = AppTheme.warning;
        text = l10n.reservationStatusPending;
        break;
      case ReservationStatus.completed:
        backgroundColor = context.colorScheme.primary.withOpacity(0.15);
        textColor = context.colorScheme.primary;
        text = l10n.reservationStatusCompleted;
        break;
      case ReservationStatus.cancelled:
        backgroundColor = context.colorScheme.error.withOpacity(0.1);
        textColor = context.colorScheme.error;
        text = l10n.reservationStatusCancelled;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: AppText(
        text,
        style: AppTextStyle.labelSmall,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildExpandedDetails(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final l10n = context.l10n;
    return AnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: Column(
        children: [
          const Divider(height: 24),
          _buildDetailRowWithIcon(
            context,
            icon: Icons.calendar_today,
            label: l10n.reservationItemLabelDate,
            value: DateFormat.yMMMMd(
              locale,
            ).format(reservation.reservationDatetime),
          ),
          _buildDetailRowWithIcon(
            context,
            icon: Icons.access_time_filled,
            label: l10n.reservationItemLabelTime,
            value: DateFormat.Hm(
              locale,
            ).format(reservation.reservationDatetime),
          ),
          _buildDetailRowWithIcon(
            context,
            icon: Icons.people,
            label: l10n.reservationItemLabelPeople,
            value:
                '${reservation.numberOfPeople} ${l10n.reservationItemPeopleUnit}',
          ),
          if (reservation.notes != null && reservation.notes!.isNotEmpty)
            _buildDetailRowWithIcon(
              context,
              icon: Icons.notes,
              label: l10n.reservationItemLabelNotes,
              value: reservation.notes!,
            ),
          if (reservation.status == ReservationStatus.pending ||
              reservation.status == ReservationStatus.confirmed)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: l10n.reservationItemCancelButton,
                  color: AppButtonColor.error,
                  onPressed: () {
                    // TODO: Implement cancel logic
                  },
                ),
              ),
            ),
        ],
      ),
      crossFadeState: isExpanded
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildDetailRowWithIcon(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: AppText(
              value,
              style: AppTextStyle.bodyLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
