import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/features/reservation/domain/entities/reservation_user.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_providers.dart';
import 'package:tires/features/user/presentation/providers/current_user_providers.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_state.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class ConfirmReservationScreen extends ConsumerWidget {
  const ConfirmReservationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Listener untuk memperbarui data reservasi dengan info user
    ref.listen<CurrentUserGetState>(currentUserGetNotifierProvider, (
      previous,
      next,
    ) {
      // * Jalankan logika hanya saat data user berhasil dimuat
      final isDataLoaded =
          previous?.status != CurrentUserGetStatus.success &&
          next.status == CurrentUserGetStatus.success;

      if (isDataLoaded && next.user != null) {
        final currentUser = next.user!;
        final currentReservation = ref.read(pendingReservationProvider);

        if (currentReservation != null) {
          // * Buat objek customer info dari data user
          final customerInfoFromUser = ReservationCustomerInfo(
            fullName: currentUser.fullName,
            fullNameKana: currentUser.fullNameKana,
            email: currentUser.email,
            phoneNumber: currentUser.phoneNumber,
            isGuest: false, // * User sudah login, jadi bukan guest
          );
          final userReservationFromUser = ReservationUser(
            id: currentUser.id,
            fullName: currentUser.fullName,
            email: currentUser.email,
            phoneNumber: currentUser.phoneNumber,
          );

          // * Salin objek reservasi dan perbarui field customerInfo dan user
          final updatedReservation = currentReservation.copyWith(
            customerInfo: customerInfoFromUser,
            user: userReservationFromUser,
          );

          // * Simpan kembali ke provider
          ref.read(pendingReservationProvider.notifier).state =
              updatedReservation;
        }
      }
    });

    return Scaffold(
      appBar: UserAppBar(title: context.l10n.appBarConfirmReservation),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildBannerInfo(context),
              const SizedBox(height: 24),
              _buildUserInfo(context, ref),
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
                AppText(
                  l10n.confirmReservationBannerTitle,
                  style: AppTextStyle.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(height: 4),
                AppText(
                  l10n.confirmReservationBannerSubtitle,
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

  Widget _buildUserInfo(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final currentUserState = ref.watch(currentUserGetNotifierProvider);

    if (currentUserState.status == CurrentUserGetStatus.loading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final userName = currentUserState.user?.fullName ?? 'User';

    return Card(
      elevation: 4,
      shadowColor: context.theme.shadowColor.withValues(alpha: 0.1),
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
            AppText(
              l10n.confirmReservationWelcomeBack(userName),
              style: AppTextStyle.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            AppText(
              l10n.confirmReservationLoggedInAs,
              style: AppTextStyle.bodyMedium,
              color: context.colorScheme.onSurface.withValues(alpha: 0.7),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.warning.withValues(alpha: 0.15),
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
