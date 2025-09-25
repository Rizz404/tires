import 'package:flutter/material.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AvailabilityStatusChip extends StatelessWidget {
  const AvailabilityStatusChip({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          AppText(label, style: AppTextStyle.bodySmall, color: color),
        ],
      ),
    );
  }
}
