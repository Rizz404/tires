import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/usecases/bulk_delete_menus_usecase.dart';

import 'package:tires/features/menu/presentation/providers/menu_mutation_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class MenuTableWidget extends ConsumerStatefulWidget {
  final List<Menu> menus;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasNextPage;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;

  const MenuTableWidget({
    super.key,
    required this.menus,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasNextPage = false,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  ConsumerState<MenuTableWidget> createState() => _MenuTableWidgetState();
}

class _MenuTableWidgetState extends ConsumerState<MenuTableWidget> {
  final Set<int> _selectedMenuIds = <int>{};
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

  void _toggleSelection(int menuId) {
    setState(() {
      if (_selectedMenuIds.contains(menuId)) {
        _selectedMenuIds.remove(menuId);
      } else {
        _selectedMenuIds.add(menuId);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedMenuIds.clear();
    });
  }

  Future<void> _bulkDelete() async {
    if (_selectedMenuIds.isEmpty) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.adminListMenuScreenConfirmDeletionTitle),
        content: Text(
          context.l10n.adminListMenuScreenDeleteMultipleConfirm(
            _selectedMenuIds.length.toString(),
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
      final params = BulkDeleteMenusUsecaseParams(_selectedMenuIds.toList());

      await ref
          .read(menuMutationNotifierProvider.notifier)
          .bulkDeleteMenus(params);

      final mutationState = ref.read(menuMutationNotifierProvider);
      if (mutationState.status == MenuMutationStatus.success) {
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
      } else if (mutationState.status == MenuMutationStatus.error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                mutationState.failure?.message ??
                    context.l10n.adminListMenuScreenJsMessagesDeleteFailed,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Color _colorFromHex(String hexColor) {
    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      // Return default color if parsing fails
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to mutation state for bulk delete feedback
    ref.listen(menuMutationNotifierProvider, (previous, next) {
      if (previous?.status != next.status) {
        if (next.status == MenuMutationStatus.success &&
            next.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.successMessage!),
              backgroundColor: Colors.green,
            ),
          );
        } else if (next.status == MenuMutationStatus.error &&
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

    if (widget.isLoading && widget.menus.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.menus.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              AppText(
                context.l10n.adminListMenuScreenNoMenusTitle,
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
        if (_selectedMenuIds.isNotEmpty) ...[
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
                      _selectedMenuIds.length.toString(),
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
                  label: Text(
                    context.l10n.adminListMenuScreenDeleteSelected,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: _clearSelection,
                  child: Text(
                    context.l10n.adminListMenuScreenClearSelection,
                    style: TextStyle(fontSize: 12),
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

        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: AppText(
            context.l10n.adminListMenuScreenMenuList,
            style: AppTextStyle.titleLarge,
          ),
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
                          ...widget.menus.asMap().entries.map(
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
                                  label: AppText(
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
          SizedBox(
            width: 60,
            child: AppText('NO.'.toUpperCase(), fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 320,
            child: AppText(
              context.l10n.adminListMenuScreenThMenu,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              context.l10n.adminListMenuScreenThPrice,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              context.l10n.adminListMenuScreenThTimeRequired,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: 80,
            child: AppText(
              context.l10n.adminListMenuScreenThOrder,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              context.l10n.adminListMenuScreenThStatus,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText(
                context.l10n.adminListMenuScreenThActions,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Menu menu, int index) {
    final isSelected = _selectedMenuIds.contains(menu.id);

    return GestureDetector(
      onLongPress: isSelected ? null : () => _toggleSelection(menu.id),
      onTap: () => _toggleSelection(menu.id),
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
              width: 320,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: _colorFromHex(menu.color.hex),
                    child: AppText(
                      menu.name.isNotEmpty ? menu.name[0].toUpperCase() : 'M',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          menu.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                        if (menu.description != null) ...[
                          const SizedBox(height: 2),
                          AppText(
                            menu.description!,
                            style: AppTextStyle.bodySmall,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.7,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
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
              width: 120,
              child: AppText(
                menu.price.formatted,
                color: context.colorScheme.onSurface.withOpacity(0.9),
              ),
            ),
            SizedBox(
              width: 150,
              child: AppText(
                '${menu.requiredTime} ${context.l10n.adminListMenuScreenMinUnit}',
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(
              width: 80,
              child: AppText(
                '${Random().nextInt(150)}',
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(width: 120, child: _buildStatusChip(context, menu)),
            SizedBox(
              width: 80,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.more_horiz, size: 20),
                  onPressed: () {
                    context.router.push(AdminUpsertMenuRoute(menu: menu));
                  },
                  tooltip: context.l10n.adminListMenuScreenViewDetails,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, Menu menu) {
    return Chip(
      label: Text(
        menu.isActive
            ? context.l10n.adminListMenuScreenActive
            : context.l10n.adminListMenuScreenInactive,
      ),
      backgroundColor: menu.isActive
          ? Colors.green.shade100
          : Colors.grey.shade300,
      labelStyle: TextStyle(
        color: menu.isActive ? Colors.green.shade800 : Colors.grey.shade800,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
      side: BorderSide.none,
    );
  }
}
