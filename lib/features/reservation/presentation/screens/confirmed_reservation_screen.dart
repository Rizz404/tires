import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/features/reservation/domain/entities/reservation_user.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class ConfirmedReservationScreen extends StatelessWidget {
  const ConfirmedReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockReservation = Reservation(
      id: 1,
      reservationNumber: 'RES-20250812-001',
      user: const ReservationUser(
        id: 1,
        fullName: 'Rizki Darmawan',
        email: 'rizki.darmawan@example.com',
        phoneNumber: '081234567890',
      ),
      customerInfo: const ReservationCustomerInfo(
        fullName: 'Rizki Darmawan',
        fullNameKana: 'リズキ ダルマワン',
        email: 'rizki.darmawan@example.com',
        phoneNumber: '081234567890',
        isGuest: true,
      ),
      menu: const Menu(
        id: 1,
        name: 'Premium Oil Change',
        description: 'High-quality synthetic oil change',
        requiredTime: 45,
        price: Price(amount: '75000', formatted: '¥75,000', currency: 'JPY'),
        displayOrder: 1,
        isActive: true,
        color: ColorInfo(hex: '#FF6B6B', rgbaLight: '', textColor: ''),
      ),
      reservationDatetime: DateTime(2025, 8, 15, 14, 0),
      numberOfPeople: 1,
      amount: const ReservationAmount(raw: '75000', formatted: '¥75,000'),
      status: const ReservationStatus(
        value: ReservationStatusValue.confirmed,
        label: 'Confirmed',
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return Scaffold(
      appBar: UserAppBar(title: context.l10n.appBarConfirmedReservation),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBannerInfo(context),
              const SizedBox(height: 24),
              _buildReservationNumber(
                context,
                mockReservation.reservationNumber,
              ),
              const SizedBox(height: 24),
              _buildWhatsNext(context),
              const SizedBox(height: 24),
              _buildSummary(context, mockReservation),
              const SizedBox(height: 24),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerInfo(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: AppTheme.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: AppTheme.success, size: 48),
          const SizedBox(height: 12),
          AppText(
            l10n.confirmedReservationBannerTitle,
            style: AppTextStyle.headlineSmall,
            fontWeight: FontWeight.bold,
            color: AppTheme.success,
          ),
          const SizedBox(height: 4),
          AppText(
            l10n.confirmedReservationBannerSubtitle,
            style: AppTextStyle.bodyMedium,
            textAlign: TextAlign.center,
            color: context.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationNumber(
    BuildContext context,
    String reservationNumber,
  ) {
    final l10n = context.l10n;
    return Card(
      elevation: 0,
      color: context.colorScheme.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppText(
              l10n.confirmedReservationYourReservationNumber,
              style: AppTextStyle.bodyMedium,
              color: context.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 4),
            AppText(
              reservationNumber,
              style: AppTextStyle.titleLarge,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhatsNext(BuildContext context) {
    final l10n = context.l10n;
    final notes = [
      l10n.confirmedReservationWhatsNext1,
      l10n.confirmedReservationWhatsNext2,
      l10n.confirmedReservationWhatsNext3,
      l10n.confirmedReservationWhatsNext4,
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            l10n.confirmedReservationWhatsNextTitle,
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          ...notes.map(
            (note) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppText(note, style: AppTextStyle.bodyMedium),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context, Reservation reservation) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    return Card(
      elevation: 2,
      shadowColor: context.theme.shadowColor.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            context,
            l10n.reservationSummaryServiceDetailsTitle,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelService,
            reservation.menu.name,
            context,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelDuration,
            '${reservation.menu.requiredTime} minutes',
            context,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelDate,
            DateFormat.yMMMMd(locale).format(reservation.reservationDatetime),
            context,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelTime,
            DateFormat.Hm(locale).format(reservation.reservationDatetime),
            context,
          ),
          const Divider(height: 32),
          _buildSectionHeader(
            context,
            l10n.reservationSummaryCustomerInfoTitle,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelName,
            reservation.customerInfo.fullName,
            context,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelNameKana,
            reservation.customerInfo.fullNameKana,
            context,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelEmail,
            reservation.customerInfo.email,
            context,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelPhone,
            reservation.customerInfo.phoneNumber,
            context,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelStatus,
            reservation.status.label,
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: l10n.confirmedReservationViewMyReservationsButton,
          color: AppButtonColor.primary,
          onPressed: () {
            context.router.replaceAll([const MyReservationsRoute()]);
          },
        ),
        const SizedBox(height: 12),
        AppButton(
          text: l10n.confirmedReservationBackToHomeButton,
          color: AppButtonColor.secondary,
          onPressed: () {
            context.router.popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppText(
        title,
        style: AppTextStyle.titleLarge,
        fontWeight: FontWeight.bold,
        color: context.colorScheme.primary,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            label,
            style: AppTextStyle.bodyMedium,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppText(
              value,
              style: AppTextStyle.bodyMedium,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
