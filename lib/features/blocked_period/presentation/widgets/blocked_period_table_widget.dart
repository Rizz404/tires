import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class BlockedPeriodTableWidget extends StatefulWidget {
  final List<BlockedPeriod> blockedPeriods;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasNextPage;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;

  const BlockedPeriodTableWidget({
    super.key,
    required this.blockedPeriods,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasNextPage = false,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  State<BlockedPeriodTableWidget> createState() =>
      _BlockedPeriodTableWidgetState();
}

class _BlockedPeriodTableWidgetState extends State<BlockedPeriodTableWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _showRightFade = true;
  bool _showLeftFade = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Auto-load more when scrolling to 80% of the content
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (widget.hasNextPage && !widget.isLoadingMore) {
        widget.onLoadMore?.call();
      }
    }

    // Update fade indicator visibility based on scroll position
    setState(() {
      _showRightFade =
          _scrollController.position.pixels <
          _scrollController.position.maxScrollExtent - 10;
      _showLeftFade = _scrollController.position.pixels > 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.blockedPeriods.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.blockedPeriods.isEmpty) {
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
          // Horizontal scroll indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: context.colorScheme.surfaceVariant.withOpacity(0.3),
            child: Row(
              children: [
                Icon(
                  Icons.swipe,
                  size: 16,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                AppText(
                  'Swipe horizontally to see more columns',
                  style: AppTextStyle.bodySmall,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTableHeader(context),
                      const Divider(height: 1, thickness: 1),
                      ...widget.blockedPeriods.map(
                        (period) => _buildTableRow(context, period),
                      ),
                      if (widget.isLoadingMore) ...[
                        const Divider(height: 1, thickness: 1),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // Left fade indicator - show when scrolled from the start
              if (_showLeftFade)
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  width: 30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          context.colorScheme.surface,
                          context.colorScheme.surface.withOpacity(0.8),
                          context.colorScheme.surface.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              // Right fade indicator - only show when there's more content to scroll
              if (_showRightFade)
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  width: 30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          context.colorScheme.surface,
                          context.colorScheme.surface.withOpacity(0.8),
                          context.colorScheme.surface.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
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
              context.l10n.adminListBlockedPeriodScreenTableEmptyMessage,
              style: AppTextStyle.bodyLarge,
              color: context.colorScheme.onSurface.withOpacity(0.6),
            ),
            if (widget.onRefresh != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: widget.onRefresh,
                child: AppText(
                  context.l10n.adminListBlockedPeriodScreenTableRefreshButton,
                ),
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
        children: [
          SizedBox(
            width: 180,
            child: AppText(
              context.l10n.adminListBlockedPeriodScreenTableHeaderMenu,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 200,
            child: AppText(
              context.l10n.adminListBlockedPeriodScreenTableHeaderTime,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 100,
            child: AppText(
              context.l10n.adminListBlockedPeriodScreenTableHeaderDuration,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 200,
            child: AppText(
              context.l10n.adminListBlockedPeriodScreenTableHeaderReason,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              context.l10n.adminListBlockedPeriodScreenTableHeaderStatus,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText(
                context.l10n.adminListBlockedPeriodScreenTableHeaderActions,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, BlockedPeriod period) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
    final timeFormat = DateFormat('HH:mm');
    final dateOnlyFormat = DateFormat('dd MMM yyyy');

    // Format time period - if same day, show "dd MMM yyyy: HH:mm - HH:mm", otherwise full dates
    String timePeriod;
    if (dateOnlyFormat.format(period.startDatetime) ==
        dateOnlyFormat.format(period.endDatetime)) {
      timePeriod =
          '${dateOnlyFormat.format(period.startDatetime)}\n${timeFormat.format(period.startDatetime)} - ${timeFormat.format(period.endDatetime)}';
    } else {
      timePeriod =
          '${dateFormat.format(period.startDatetime)}\n${dateFormat.format(period.endDatetime)}';
    }

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
          SizedBox(width: 180, child: _buildMenuColumn(context, period)),
          SizedBox(
            width: 200,
            child: AppText(
              timePeriod,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              color: context.colorScheme.onSurface.withOpacity(0.7),
              style: AppTextStyle.bodySmall,
            ),
          ),
          SizedBox(
            width: 100,
            child: AppText(
              period.duration.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: context.colorScheme.onSurface.withOpacity(0.7),
              style: AppTextStyle.bodySmall,
            ),
          ),
          SizedBox(
            width: 200,
            child: AppText(
              period.reason,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(width: 120, child: _buildStatusChip(context, period)),
          SizedBox(
            width: 80,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {
                  context.router.push(
                    AdminUpsertBlockedPeriodRoute(blockedPeriod: period),
                  );
                },
                tooltip: context
                    .l10n
                    .adminListBlockedPeriodScreenTablePaginationPrevious,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuColumn(BuildContext context, BlockedPeriod period) {
    if (period.allMenuForBlockedPeriods) {
      return Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: AppText(
              'All Menus',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    if (period.menu == null) {
      return AppText(
        context.l10n.adminListBlockedPeriodScreenTableNotAvailable,
        color: Colors.grey,
      );
    }

    // Parse menu color from hex string
    Color menuColor = Colors.blue.shade400; // default color
    try {
      final colorHex = period.menu!.color.replaceFirst('#', '');
      menuColor = Color(int.parse('FF$colorHex', radix: 16));
    } catch (e) {
      // Use default color if parsing fails
    }

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: menuColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AppText(
            period.menu!.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, BlockedPeriod period) {
    final now = DateTime.now();
    final String label;
    final Color backgroundColor;
    final Color textColor;

    if (now.isAfter(period.startDatetime) && now.isBefore(period.endDatetime)) {
      label = context.l10n.adminListBlockedPeriodScreenFiltersStatusActive;
      backgroundColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
    } else if (now.isBefore(period.startDatetime)) {
      label = context.l10n.adminListBlockedPeriodScreenFiltersStatusUpcoming;
      backgroundColor = Colors.yellow.shade200;
      textColor = Colors.yellow.shade900;
    } else {
      label = context.l10n.adminListBlockedPeriodScreenFiltersStatusExpired;
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
}
