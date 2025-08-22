import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/string_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_checkbox.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class ReservationSummaryScreen extends StatefulWidget {
  const ReservationSummaryScreen({super.key});

  @override
  State<ReservationSummaryScreen> createState() =>
      _ReservationSummaryScreenState();
}

class _ReservationSummaryScreenState extends State<ReservationSummaryScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Mock reservation data for demonstration
    final mockReservation = Reservation(
      id: 1,
      reservationNumber: 'RES-20250812-001',
      fullName: 'Rizki Darmawan',
      fullNameKana: 'リズキ ダルマワン',
      email: 'rizki.darmawan@example.com',
      phoneNumber: '081234567890',
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
      reservationDatetime: DateTime.now().add(
        const Duration(days: 3, hours: 2),
      ),
      numberOfPeople: 1,
      amount: 75000,
      status: ReservationStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return Scaffold(
      appBar: UserAppBar(title: context.l10n.appBarReservationSummary),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBannerInfo(context),
                const SizedBox(height: 24),
                _buildSummary(context, mockReservation),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerInfo(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: context.colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  l10n.reservationSummaryBannerTitle,
                  style: AppTextStyle.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(height: 4),
                AppText(
                  l10n.reservationSummaryBannerSubtitle,
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
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelDuration,
            '${reservation.menu.requiredTime} minutes',
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelDate,
            DateFormat.yMMMMd(locale).format(reservation.reservationDatetime),
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelTime,
            DateFormat.Hm(locale).format(reservation.reservationDatetime),
          ),
          const Divider(height: 32),
          _buildSectionHeader(
            context,
            l10n.reservationSummaryCustomerInfoTitle,
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelName,
            reservation.fullName ?? '-',
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelNameKana,
            reservation.fullNameKana ?? '-',
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelEmail,
            reservation.email ?? '-',
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelPhone,
            reservation.phoneNumber ?? '-',
          ),
          _buildDetailRow(
            l10n.reservationSummaryLabelStatus,
            reservation.status.name.capitalize(),
          ),
          const Divider(height: 32),
          _buildReservationSummaryNotes(context),
          const SizedBox(height: 24),
          _buildTermsCheckbox(context),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: "Complete booking",
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  // All validations passed.
                  context.router.push(const ConfirmedReservationRoute());
                }
              },
            ),
          ),
        ],
      ),
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

  Widget _buildDetailRow(String label, String value) {
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

  Widget _buildReservationSummaryNotes(BuildContext context) {
    final l10n = context.l10n;
    final notes = [
      l10n.reservationSummaryNotesContent1,
      l10n.reservationSummaryNotesContent2,
      l10n.reservationSummaryNotesContent3,
      l10n.reservationSummaryNotesContent4,
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            l10n.reservationSummaryNotesTitle,
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
            color: AppTheme.warning,
          ),
          const SizedBox(height: 8),
          ...notes.map(
            (note) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppText(
                      note,
                      style: AppTextStyle.bodySmall,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox(BuildContext context) {
    final l10n = context.l10n;
    return AppCheckbox(
      name: 'terms_agreement',
      validator: FormBuilderValidators.required(
        errorText: "You must accept the terms to continue",
      ),
      title: RichText(
        text: TextSpan(
          style: context.textTheme.bodyMedium,
          children: [
            TextSpan(text: l10n.reservationSummaryTermsAndCondition),
            TextSpan(
              text: l10n.reservationSummaryPrivacyPolicy,
              style: TextStyle(
                color: context.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // TODO: Open privacy policy link
                  debugPrint('Privacy Policy tapped');
                },
            ),
          ],
        ),
      ),
    );
  }
}
