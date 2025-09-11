import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/theme/app_theme.dart';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

class ToDoSection extends StatelessWidget {
  final Dashboard dashboard;

  const ToDoSection({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.adminDashboardTodoTitle,
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        StatTile(
          title: context.l10n.adminDashboardTodoTodayReservations,
          value: '${dashboard.todayReservations.length}',
          icon: Icons.event,
          color: AppTheme.brandSub,
        ),
        const SizedBox(height: 16),
        StatTile(
          title: context.l10n.adminDashboardTodoContacts,
          value: '${dashboard.pendingContacts.length}',
          icon: Icons.mail,
          color: AppTheme.brandSub,
        ),
      ],
    );
  }
}
