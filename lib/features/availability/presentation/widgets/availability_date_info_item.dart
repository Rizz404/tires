import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AvailabilityDateInfoItem extends StatelessWidget {
  const AvailabilityDateInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(title, style: AppTextStyle.bodySmall),
        const SizedBox(height: 4),
        AppText(
          value,
          style: AppTextStyle.titleLarge,
          color: context.colorScheme.primary,
        ),
      ],
    );
  }
}
