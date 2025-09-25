import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AvailabilityTimeSlotItem extends StatelessWidget {
  const AvailabilityTimeSlotItem({
    super.key,
    required this.time,
    required this.isReserved,
    required this.isAvailable,
    required this.isBlocked,
    this.onTap,
  });

  final String time;
  final bool isReserved;
  final bool isAvailable;
  final bool isBlocked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color color;
    Color textColor = context.colorScheme.onSurface;
    String statusText;

    if (isBlocked) {
      color = context.colorScheme.error;
      statusText = 'Blocked';
    } else if (isReserved) {
      color = Colors.orange;
      statusText = 'Reserved';
    } else if (isAvailable) {
      color = Colors.green;
      statusText = 'Available';
    } else {
      color = Colors.grey;
      statusText = 'Unavailable';
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(time, style: AppTextStyle.titleSmall, color: textColor),
            const SizedBox(height: 2),
            AppText(
              statusText,
              style: AppTextStyle.bodySmall,
              color: textColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
