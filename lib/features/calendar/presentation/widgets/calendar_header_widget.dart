import 'package:flutter/material.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class CalendarHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const CalendarHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            subtitle,
            style: AppTextStyle.bodyLarge,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
