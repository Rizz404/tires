import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/usecases/bulk_delete_blocked_periods_usecase.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_mutation_state.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_providers.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class BlockedPeriodTableWidget extends ConsumerStatefulWidget {
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
  ConsumerState<BlockedPeriodTableWidget> createState() =>
      _BlockedPeriodTableWidgetState();
}

class _BlockedPeriodTableWidgetState
    extends ConsumerState<BlockedPeriodTableWidget> {
  final Set<int> _selectedBlockedPeriodIds = <int>{};
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
    // Update fade indicator visibility based on scroll position
    setState(() {
      _showRightFade =
          _scrollController.position.pixels <
          _scrollController.position.maxScrollExtent - 10;
      _showLeftFade = _scrollController.position.pixels > 10;
    });
  }

  void _toggleSelection(int blockedPeriodId) {
    setState(() {
      if (_selectedBlockedPeriodIds.contains(blockedPeriodId)) {
        _selectedBlockedPeriodIds.remove(blockedPeriodId);
      } else {
        _selectedBlockedPeriodIds.add(blockedPeriodId);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedBlockedPeriodIds.clear();
    });
  }

  Future<void> _bulkDelete() async {
    if (_selectedBlockedPeriodIds.isEmpty) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.adminListMenuScreenConfirmDeletionTitle),
        content: Text(
          context.l10n.adminListMenuScreenDeleteMultipleConfirm(
            _selectedBlockedPeriodIds.length.toString(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.adminListMenuScreenCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.l10n.adminListMenuScreenDelete),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      final params = BulkDeleteBlockedPeriodsUsecaseParams(
        _selectedBlockedPeriodIds.toList(),
      );

      await ref
          .read(blockedPeriodMutationNotifierProvider.notifier)
          .bulkDeleteBlockedPeriods(params);

      final mutationState = ref.read(blockedPeriodMutationNotifierProvider);
      if (mutationState.status == BlockedPeriodMutationStatus.success) {
        _clearSelection();
        widget.onRefresh?.call();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                mutationState.errorMessage ??
                    context.l10n.menuNotificationDeleted,
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else if (mutationState.status == BlockedPeriodMutationStatus.error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                mutationState.errorMessage ??
                    context.l10n.adminListMenuScreenJsMessagesDeleteFailed,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to mutation state for bulk delete feedback
    ref.listen(blockedPeriodMutationNotifierProvider, (previous, next) {
      if (previous?.status != next.status) {
        if (next.status == BlockedPeriodMutationStatus.success &&
            next.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
              backgroundColor: Colors.green,
            ),
          );
        } else if (next.status == BlockedPeriodMutationStatus.error &&
            next.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selection header with bulk actions
        if (_selectedBlockedPeriodIds.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: AppText(
                    context.l10n.adminListMenuScreenSelected(
                      _selectedBlockedPeriodIds.length.toString(),
                    ),
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: _bulkDelete,
                  icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                  label: const Text(
                    'Delete Selected',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: _clearSelection,
                  icon: Icon(
                    Icons.clear,
                    color: context.colorScheme.onSurface,
                    size: 18,
                  ),
                  label: Text(
                    'Clear Selection',
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: AppText('Blocked Periods', style: AppTextStyle.titleLarge),
        ),
        Card(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: context.colorScheme.surfaceContainerHighest.withOpacity(
                  0.3,
                ),
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
                          ...widget.blockedPeriods.asMap().entries.map(
                            (entry) =>
                                _buildTableRow(context, entry.value, entry.key),
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
                          if (widget.hasNextPage && !widget.isLoadingMore) ...[
                            const Divider(height: 1, thickness: 1),
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: TextButton.icon(
                                  onPressed: widget.onLoadMore,
                                  icon: const Icon(Icons.expand_more, size: 16),
                                  label: const AppText(
                                    'Load More',
                                    style: AppTextStyle.bodyMedium,
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        context.colorScheme.primary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
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
        ),
      ],
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
          const SizedBox(
            width: 60,
            child: AppText('NO.', fontWeight: FontWeight.bold),
          ),
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

  Widget _buildTableRow(BuildContext context, BlockedPeriod period, int index) {
    final isSelected = _selectedBlockedPeriodIds.contains(period.id);
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

    return GestureDetector(
      onLongPress: _selectedBlockedPeriodIds.isEmpty
          ? () => _toggleSelection(period.id)
          : null,
      onTap: _selectedBlockedPeriodIds.isNotEmpty
          ? () => _toggleSelection(period.id)
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primaryContainer.withOpacity(0.3)
              : null,
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.outlineVariant,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Number Column
            SizedBox(
              width: 60,
              child: AppText(
                '${index + 1}',
                style: AppTextStyle.bodyMedium,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 180,
              child: Row(
                children: [
                  Expanded(child: _buildMenuColumn(context, period)),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      color: context.colorScheme.primary,
                      size: 20,
                    ),
                  ],
                ],
              ),
            ),
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
                  icon: const Icon(Icons.more_horiz, size: 20),
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
