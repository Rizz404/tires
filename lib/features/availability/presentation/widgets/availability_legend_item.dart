import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AvailabilityLegendItem extends StatelessWidget {
  const AvailabilityLegendItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(title, style: AppTextStyle.bodyMedium),
            AppText(
              subtitle,
              style: AppTextStyle.bodySmall,
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ],
        ),
      ],
    );
  }
}
