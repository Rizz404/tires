import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class MenuTile extends StatelessWidget {
  final Menu menu;
  final VoidCallback? onBookPressed;

  const MenuTile({super.key, required this.menu, this.onBookPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shadowColor: context.theme.shadowColor.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian Kiri: Nama menu dan waktu (Fleksibel)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        menu.name,
                        style: AppTextStyle.titleMedium,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.6,
                            ),
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            _formatTime(context, menu.requiredTime),
                            style: AppTextStyle.bodySmall,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.6,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Bagian Kanan: Harga dan tombol (Ukuran Natural)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      menu.price.formatted,
                      style: AppTextStyle.titleMedium,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    // --- PERBAIKAN UTAMA ---
                    // Hapus SizedBox yang membatasi lebar tombol.
                    // Biarkan AppButton menentukan ukurannya sendiri.
                    AppButton(
                      text: l10n.menuBookButton,
                      onPressed: menu.isActive ? onBookPressed : null,
                      color: AppButtonColor.primary,
                      size: AppButtonSize.small,
                    ),
                  ],
                ),
              ],
            ),

            // Deskripsi (jika ada)
            if (menu.description != null && menu.description!.isNotEmpty) ...[
              const Divider(height: 24),
              AppText(
                menu.description!,
                style: AppTextStyle.bodyMedium,
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ],

            // Indikator status jika tidak aktif
            if (!menu.isActive) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colorScheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: AppText(
                  l10n.menuUnavailableStatus,
                  style: AppTextStyle.bodySmall,
                  color: context.colorScheme.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTime(BuildContext context, int minutes) {
    final l10n = context.l10n;
    if (minutes < 60) {
      return '$minutes ${minutes == 1 ? l10n.timeMinute : l10n.timeMinutes}';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;

      if (remainingMinutes == 0) {
        return '$hours ${hours == 1 ? l10n.timeHour : l10n.timeHours}';
      } else {
        return '$hours ${hours == 1 ? l10n.timeHour : l10n.timeHours} $remainingMinutes ${remainingMinutes == 1 ? l10n.timeMinute : l10n.timeMinutes}';
      }
    }
  }
}
