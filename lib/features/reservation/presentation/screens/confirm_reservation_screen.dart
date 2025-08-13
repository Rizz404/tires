import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart'; // Import AppText
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class ConfirmReservationScreen extends StatelessWidget {
  const ConfirmReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(title: context.l10n.appBarConfirmReservation),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildBannerInfo(context),
              const SizedBox(height: 24),
              _buildUserInfo(context),
            ],
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
            Icons.info_outline,
            color: context.colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menggunakan style 'titleMedium' untuk judul di banner.
                AppText(
                  l10n.confirmReservationBannerTitle,
                  style: AppTextStyle.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(height: 4),
                // Menggunakan style 'bodyMedium' untuk sub-judul atau teks deskriptif.
                AppText(
                  l10n.confirmReservationBannerSubtitle,
                  style: AppTextStyle.bodyMedium,
                  color: context.colorScheme.onSurface.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      elevation: 4,
      shadowColor: context.theme.shadowColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: context.colorScheme.primary,
              child: Icon(
                Icons.person,
                size: 40,
                color: context.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 20),
            // Menggunakan style 'headlineSmall' untuk teks sambutan yang menonjol.
            AppText(
              l10n.confirmReservationWelcomeBack,
              style: AppTextStyle.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // Menggunakan 'bodyMedium' lagi untuk info tambahan di bawah sambutan.
            AppText(
              l10n.confirmReservationLoggedInAs,
              style: AppTextStyle.bodyMedium,
              color: context.colorScheme.onSurface.withOpacity(0.7),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.warning.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppTheme.warning,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    // Menggunakan style 'bodySmall' untuk teks peringatan yang lebih kecil namun penting.
                    child: AppText(
                      l10n.confirmReservationInfoUsageWarning,
                      style: AppTextStyle.bodySmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: l10n.confirmReservationContinueButton,
                onPressed: () {
                  context.router.push(const ReservationSummaryRoute());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
