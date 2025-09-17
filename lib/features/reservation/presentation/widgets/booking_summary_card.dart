import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class BookingSummaryCard extends StatelessWidget {
  final Menu menu;
  final DateTime selectedDate;
  final String selectedTime;

  const BookingSummaryCard({
    super.key,
    required this.menu,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.success.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Booking Summary',
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(context, 'Service:', menu.name),
          _buildSummaryRow(
            context,
            'Duration:',
            '${menu.requiredTime} minutes',
          ),
          _buildSummaryRow(
            context,
            'Date:',
            DateFormat('EEEE, MMMM d, y', locale).format(selectedDate),
          ),
          _buildSummaryRow(context, 'Time:', selectedTime),
          const Divider(height: 20),
          _buildSummaryRow(
            context,
            'Total:',
            menu.price.formatted,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final textStyle = isTotal
        ? context.textTheme.titleMedium
        : context.textTheme.bodyMedium;
    final valueStyle = textStyle?.copyWith(
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Agar rapi saat wrapping
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          const SizedBox(width: 16), // Beri jarak agar tidak menempel
          Expanded(
            child: Text(
              value,
              style: valueStyle,
              textAlign: TextAlign.right, // Teks rata kanan agar terlihat rapi
            ),
          ),
        ],
      ),
    );
  }
}
