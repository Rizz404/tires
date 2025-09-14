import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/user/domain/entities/blocked_period.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class BlockedPeriodTableWidget extends StatelessWidget {
  final List<BlockedPeriod> blockedPeriods;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const BlockedPeriodTableWidget({
    super.key,
    required this.blockedPeriods,
    this.isLoading = false,
    this.onRefresh,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && blockedPeriods.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (blockedPeriods.isEmpty) {
      return _buildEmptyState(context);
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTableHeader(context),
                  const Divider(height: 1, thickness: 1),
                  ...blockedPeriods.map(
                    (period) => _buildTableRow(context, period),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1),
          _buildPaginationControls(context),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.block_flipped,
              size: 64,
              color: context.colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            AppText(
              'No blocked periods found',
              style: AppTextStyle.bodyLarge,
              color: context.colorScheme.onSurface.withOpacity(0.6),
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRefresh,
                child: const AppText('Refresh'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: context.colorScheme.surface.withOpacity(0.5),
      child: Row(
        children: const [
          SizedBox(
            width: 200,
            child: AppText('MENU', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 150,
            child: AppText('START DATE', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 150,
            child: AppText('END DATE', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 120,
            child: AppText('STATUS', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 250,
            child: AppText('REASON', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText('ACTION', fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, BlockedPeriod period) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: AppText(
              period.allMenus ? 'All Menus' : (period.menu?.name ?? 'N/A'),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              fontWeight: period.allMenus ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              dateFormat.format(period.startDatetime),
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              dateFormat.format(period.endDatetime),
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(width: 120, child: _buildStatusChip(context, period)),
          SizedBox(
            width: 250,
            child: AppText(
              period.reason,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {},
                tooltip: 'Edit Period',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, BlockedPeriod period) {
    final now = DateTime.now();
    final String label;
    final Color backgroundColor;
    final Color textColor;

    if (now.isAfter(period.startDatetime) && now.isBefore(period.endDatetime)) {
      label = 'Active';
      backgroundColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
    } else if (now.isBefore(period.startDatetime)) {
      label = 'Upcoming';
      backgroundColor = Colors.yellow.shade200;
      textColor = Colors.yellow.shade900;
    } else {
      label = 'Expired';
      backgroundColor = Colors.grey.shade300;
      textColor = Colors.grey.shade800;
    }

    return Chip(
      label: Text(label),
      backgroundColor: backgroundColor,
      labelStyle: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
      side: BorderSide.none,
    );
  }

  Widget _buildPaginationControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppText(
            'Page $currentPage of $totalPages',
            style: AppTextStyle.bodyMedium,
            color: context.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentPage > 1
                ? () => onPageChanged(currentPage - 1)
                : null,
            tooltip: 'Previous Page',
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: currentPage < totalPages
                ? () => onPageChanged(currentPage + 1)
                : null,
            tooltip: 'Next Page',
          ),
        ],
      ),
    );
  }
}
