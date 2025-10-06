import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/announcement/domain/usecases/bulk_delete_announcements_usecase.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_providers.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AnnouncementTableWidget extends ConsumerStatefulWidget {
  final List<Announcement> announcements;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasNextPage;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;

  const AnnouncementTableWidget({
    super.key,
    required this.announcements,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasNextPage = false,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  ConsumerState<AnnouncementTableWidget> createState() =>
      _AnnouncementTableWidgetState();
}

class _AnnouncementTableWidgetState
    extends ConsumerState<AnnouncementTableWidget> {
  final Set<int> _selectedAnnouncementIds = <int>{};
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

  void _toggleSelection(int announcementId) {
    setState(() {
      if (_selectedAnnouncementIds.contains(announcementId)) {
        _selectedAnnouncementIds.remove(announcementId);
      } else {
        _selectedAnnouncementIds.add(announcementId);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedAnnouncementIds.clear();
    });
  }

  Future<void> _bulkDelete() async {
    if (_selectedAnnouncementIds.isEmpty) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.adminListAnnouncementScreenDeleteModalTitle),
        content: Text(
          context.l10n.adminListAnnouncementScreenJsDeleteMultipleConfirm(
            _selectedAnnouncementIds.length.toString(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              context.l10n.adminListAnnouncementScreenDeleteModalCancelButton,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(
              context.l10n.adminListAnnouncementScreenDeleteModalDeleteButton,
            ),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      final params = BulkDeleteAnnouncementsUsecaseParams(
        _selectedAnnouncementIds.toList(),
      );

      await ref
          .read(announcementMutationNotifierProvider.notifier)
          .bulkDeleteAnnouncements(params);

      final mutationState = ref.read(announcementMutationNotifierProvider);
      if (mutationState.status == AnnouncementMutationStatus.success) {
        _clearSelection();
        widget.onRefresh?.call();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                mutationState.successMessage ??
                    context.l10n.menuNotificationDeleted,
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else if (mutationState.status == AnnouncementMutationStatus.error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                mutationState.failure?.message ??
                    context.l10n.adminListAnnouncementScreenJsErrorDelete,
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
    ref.listen(announcementMutationNotifierProvider, (previous, next) {
      if (previous?.status != next.status) {
        if (next.status == AnnouncementMutationStatus.success &&
            next.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.successMessage!),
              backgroundColor: Colors.green,
            ),
          );
        } else if (next.status == AnnouncementMutationStatus.error &&
            next.failure != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.failure!.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });
    if (widget.isLoading && widget.announcements.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.announcements.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.campaign_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              AppText(
                context.l10n.adminListAnnouncementScreenEmptyTitle,
                style: AppTextStyle.bodyLarge,
                color: context.colorScheme.onSurface.withOpacity(0.6),
              ),
              if (widget.onRefresh != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: widget.onRefresh,
                  child: AppText(context.l10n.adminListMenuScreenRefresh),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selection header with bulk actions
        if (_selectedAnnouncementIds.isNotEmpty) ...[
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
                      _selectedAnnouncementIds.length.toString(),
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
          child: AppText('Announcements', style: AppTextStyle.titleLarge),
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
                          ...widget.announcements.asMap().entries.map(
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
            width: 300,
            child: AppText(
              context.l10n.adminListAnnouncementScreenTableHeadersTitle
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              context.l10n.adminListAnnouncementScreenTableHeadersPublishDate
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              context.l10n.adminListAnnouncementScreenTableHeadersStatus
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText(
                context.l10n.adminListAnnouncementScreenTableHeadersActions
                    .toUpperCase(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(
    BuildContext context,
    Announcement announcement,
    int index,
  ) {
    final isSelected = _selectedAnnouncementIds.contains(announcement.id);

    return GestureDetector(
      onLongPress: _selectedAnnouncementIds.isEmpty
          ? () => _toggleSelection(announcement.id)
          : null,
      onTap: _selectedAnnouncementIds.isNotEmpty
          ? () => _toggleSelection(announcement.id)
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
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    child: AppText(
                      announcement.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
              width: 150,
              child: AppText(
                announcement.publishedAt != null
                    ? DateFormat(
                        'dd MMM yyyy',
                      ).format(announcement.publishedAt!)
                    : '-',
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(
              width: 120,
              child: _buildStatusChip(context, announcement),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.more_horiz, size: 20),
                  onPressed: () {
                    context.router.push(
                      AdminUpsertAnnouncementRoute(announcement: announcement),
                    );
                  },
                  tooltip: context
                      .l10n
                      .adminListAnnouncementScreenTableActionsTooltipView,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, Announcement announcement) {
    return Chip(
      label: Text(
        announcement.isActive
            ? context.l10n.adminUpsertAnnouncementScreenStatusActive
            : context.l10n.adminUpsertAnnouncementScreenStatusInactive,
      ),
      backgroundColor: announcement.isActive
          ? Colors.green.shade100
          : Colors.grey.shade300,
      labelStyle: TextStyle(
        color: announcement.isActive
            ? Colors.green.shade800
            : Colors.grey.shade800,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
      side: BorderSide.none,
    );
  }
}
