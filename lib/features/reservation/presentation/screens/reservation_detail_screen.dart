import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class ReservationDetailScreen extends ConsumerStatefulWidget {
  final Reservation reservation;

  const ReservationDetailScreen({super.key, required this.reservation});

  @override
  ConsumerState<ReservationDetailScreen> createState() =>
      _ReservationDetailScreenState();
}

class _ReservationDetailScreenState
    extends ConsumerState<ReservationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(title: context.l10n.reservationDetailTitle),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusBanner(context),
              const SizedBox(height: 16),
              _buildBasicInfoCard(context),
              const SizedBox(height: 16),
              _buildServiceInfoCard(context),
              const SizedBox(height: 16),
              _buildCustomerInfoCard(context),
              const SizedBox(height: 16),
              _buildActionsCard(context),
              const SizedBox(height: 16),
              _buildBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context) {
    final reservation = widget.reservation;
    Color statusColor;
    IconData statusIcon;

    switch (reservation.status.value) {
      case ReservationStatusValue.confirmed:
        statusColor = AppTheme.success;
        statusIcon = Icons.check_circle;
        break;
      case ReservationStatusValue.pending:
        statusColor = AppTheme.warning;
        statusIcon = Icons.schedule;
        break;
      case ReservationStatusValue.completed:
        statusColor = AppTheme.info;
        statusIcon = Icons.done_all;
        break;
      case ReservationStatusValue.cancelled:
        statusColor = AppTheme.error;
        statusIcon = Icons.cancel;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  reservation.status.label,
                  style: AppTextStyle.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
                AppText(
                  reservation.menu.name,
                  style: AppTextStyle.bodyMedium,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoCard(BuildContext context) {
    return _buildInfoCard(
      context,
      title: context.l10n.reservationDetailBasicInfoTitle,
      icon: Icons.info_outline,
      children: [
        _buildDetailRow(
          context.l10n.reservationDetailReservationNumber,
          widget.reservation.reservationNumber,
        ),
        _buildDetailRow(
          context.l10n.reservationSummaryLabelDate,
          DateFormat.yMMMMd(
            Localizations.localeOf(context).toString(),
          ).format(widget.reservation.reservationDatetime),
        ),
        _buildDetailRow(
          context.l10n.reservationSummaryLabelTime,
          DateFormat.Hm(
            Localizations.localeOf(context).toString(),
          ).format(widget.reservation.reservationDatetime),
        ),
        _buildDetailRow(
          context.l10n.reservationSummaryLabelStatus,
          widget.reservation.status.label,
        ),
        _buildDetailRow(
          context.l10n.reservationDetailCreatedAt,
          DateFormat.yMMMMd(
            Localizations.localeOf(context).toString(),
          ).add_Hm().format(widget.reservation.createdAt),
        ),
        _buildDetailRow(
          context.l10n.reservationDetailUpdatedAt,
          DateFormat.yMMMMd(
            Localizations.localeOf(context).toString(),
          ).add_Hm().format(widget.reservation.updatedAt),
        ),
      ],
    );
  }

  Widget _buildServiceInfoCard(BuildContext context) {
    return _buildInfoCard(
      context,
      title: context.l10n.reservationDetailServiceInfoTitle,
      icon: Icons.room_service_outlined,
      children: [
        _buildDetailRow(
          context.l10n.reservationSummaryLabelService,
          widget.reservation.menu.name,
        ),
        _buildDetailRow(
          context.l10n.reservationSummaryLabelDuration,
          '${widget.reservation.menu.requiredTime} ${context.l10n.timeMinutes}',
        ),
        _buildDetailRow('Price', widget.reservation.menu.price.formatted),
        if (widget.reservation.menu.description != null &&
            widget.reservation.menu.description!.isNotEmpty)
          _buildDetailRow(
            'Description',
            widget.reservation.menu.description!,
            isMultiline: true,
          ),
      ],
    );
  }

  Widget _buildCustomerInfoCard(BuildContext context) {
    return _buildInfoCard(
      context,
      title: context.l10n.reservationDetailCustomerInfoTitle,
      icon: Icons.person_outline,
      children: [
        _buildDetailRow(
          context.l10n.reservationSummaryLabelName,
          widget.reservation.customerInfo.fullName,
        ),
        _buildDetailRow(
          context.l10n.reservationSummaryLabelNameKana,
          widget.reservation.customerInfo.fullNameKana,
        ),
        _buildDetailRow(
          context.l10n.reservationSummaryLabelEmail,
          widget.reservation.customerInfo.email,
        ),
        _buildDetailRow(
          context.l10n.reservationSummaryLabelPhone,
          widget.reservation.customerInfo.phoneNumber,
        ),
      ],
    );
  }

  Widget _buildActionsCard(BuildContext context) {
    final canEdit =
        widget.reservation.status.value == ReservationStatusValue.pending;
    final canCancel = [
      ReservationStatusValue.pending,
      ReservationStatusValue.confirmed,
    ].contains(widget.reservation.status.value);

    return _buildInfoCard(
      context,
      title: context.l10n.reservationDetailActionsTitle,
      icon: Icons.settings_outlined,
      children: [
        if (canCancel)
          AppButton(
            onPressed: () {
              _showCancelConfirmationDialog(context);
            },
            text: context.l10n.reservationDetailCancelButton,
            variant: AppButtonVariant.outlined,
            isFullWidth: true,
            color: AppButtonColor.error,
          ),
        if (!canEdit && !canCancel)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: AppText(
              'No actions available for this reservation',
              style: AppTextStyle.bodyMedium,
              textAlign: TextAlign.center,
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shadowColor: context.theme.shadowColor.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: context.colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                AppText(
                  title,
                  style: AppTextStyle.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isMultiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: isMultiline
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  style: AppTextStyle.labelMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                const SizedBox(height: 4),
                AppText(
                  value,
                  style: AppTextStyle.bodyMedium,
                  color: context.colorScheme.onSurface,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: AppText(
                    label,
                    style: AppTextStyle.labelMedium,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: AppText(
                    value,
                    style: AppTextStyle.bodyMedium,
                    textAlign: TextAlign.end,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return AppButton(
      onPressed: () {
        context.router.pushAndPopUntil(
          const MyReservationsRoute(),
          predicate: (route) => false,
        );
      },
      text: context.l10n.reservationDetailBackButton,
      variant: AppButtonVariant.filled,
      isFullWidth: true,
    );
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText(
            context.l10n.myReservationModalCancelTitle,
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          content: AppText(
            context.l10n.myReservationModalCancelBody,
            style: AppTextStyle.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: AppText(
                context.l10n.myReservationModalKeepButton,
                style: AppTextStyle.labelLarge,
                color: context.colorScheme.primary,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showFeatureComingSoonDialog(context);
              },
              child: AppText(
                context.l10n.myReservationModalConfirmCancelButton,
                style: AppTextStyle.labelLarge,
                color: AppTheme.error,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFeatureComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText(
            context.l10n.myReservationModalFeatureSoonTitle,
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          content: AppText(
            context.l10n.myReservationModalFeatureSoonBody,
            style: AppTextStyle.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: AppText(
                context.l10n.myReservationModalGotItButton,
                style: AppTextStyle.labelLarge,
                color: context.colorScheme.primary,
              ),
            ),
          ],
        );
      },
    );
  }
}
