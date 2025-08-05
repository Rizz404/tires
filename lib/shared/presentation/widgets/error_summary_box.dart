import 'package:flutter/material.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class ErrorSummaryBox extends StatelessWidget {
  final List<DomainValidationError> errors;

  const ErrorSummaryBox({super.key, required this.errors});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: errorColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: errorColor),
              const SizedBox(width: 8),
              AppText(
                'Please fix the following errors:',
                style: AppTextStyle.title,
                color: theme.colorScheme.onErrorContainer,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...errors.map(
            (error) => Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: AppText(
                '• ${error.message}', // * Hanya menampilkan pesan error
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
