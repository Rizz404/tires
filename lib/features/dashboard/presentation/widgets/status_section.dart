import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

class StatusSection extends StatelessWidget {
  final Dashboard dashboard;

  const StatusSection({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthYear = DateFormat('MMMM yyyy').format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.adminDashboardStatusTitle.replaceAll(':date', monthYear),
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            StatTile(
              title: context.l10n.adminDashboardStatusReservations,
              value: dashboard.monthlyReservations.length.toString(),
              icon: Icons.event,
              color: AppTheme.brandSub,
            ),
            const SizedBox(height: 16),
            StatTile(
              title: context.l10n.adminDashboardStatusNewCustomers,
              value: dashboard.statistics.newCustomersThisMonth.toString(),
              icon: Icons.person_add,
              color: AppTheme.brandSub,
            ),
          ],
        ),
      ],
    );
  }
}
