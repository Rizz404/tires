import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class MenuTile extends StatelessWidget {
  final Menu menu;
  final VoidCallback? onBookPressed;

  const MenuTile({super.key, required this.menu, this.onBookPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan nama dan waktu
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(menu.name, style: AppTextStyle.title),
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
                            _formatTime(menu.requiredTime),
                            style: AppTextStyle.caption,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.6,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Price dan Book Button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      menu.price.formatted,
                      style: AppTextStyle.title,
                      color: Color(
                        int.parse(menu.color.hex.replaceFirst('#', '0xFF')),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: menu.isActive ? onBookPressed : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                          int.parse(menu.color.hex.replaceFirst('#', '0xFF')),
                        ),
                        foregroundColor: Color(
                          int.parse(
                            menu.color.textColor.replaceFirst('#', '0xFF'),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        minimumSize: const Size(80, 36),
                      ),
                      child: const AppText('Book', style: AppTextStyle.caption),
                    ),
                  ],
                ),
              ],
            ),

            // Description (jika ada)
            if (menu.description != null && menu.description!.isNotEmpty) ...[
              const SizedBox(height: 12),
              AppText(
                menu.description!,
                style: AppTextStyle.body,
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ],

            // Status indicator jika tidak aktif
            if (!menu.isActive) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colorScheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: AppText(
                  'Currently Unavailable',
                  style: AppTextStyle.caption,
                  color: context.colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTime(int minutes) {
    if (minutes < 60) {
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;

      if (remainingMinutes == 0) {
        return '$hours ${hours == 1 ? 'hour' : 'hours'}';
      } else {
        return '$hours ${hours == 1 ? 'hour' : 'hours'} $remainingMinutes ${remainingMinutes == 1 ? 'minute' : 'minutes'}';
      }
    }
  }
}
