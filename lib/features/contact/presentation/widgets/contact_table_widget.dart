import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/contact/domain/usecases/bulk_delete_contacts_usecase.dart';
import 'package:tires/features/contact/presentation/providers/contact_mutation_state.dart';
import 'package:tires/features/contact/presentation/providers/contact_providers.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class ContactTableWidget extends ConsumerStatefulWidget {
  final List<Contact> contacts;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasNextPage;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;

  const ContactTableWidget({
    super.key,
    required this.contacts,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasNextPage = false,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  ConsumerState<ContactTableWidget> createState() => _ContactTableWidgetState();
}

class _ContactTableWidgetState extends ConsumerState<ContactTableWidget> {
  final Set<int> _selectedContactIds = <int>{};
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

  void _toggleSelection(int contactId) {
    setState(() {
      if (_selectedContactIds.contains(contactId)) {
        _selectedContactIds.remove(contactId);
      } else {
        _selectedContactIds.add(contactId);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedContactIds.clear();
    });
  }

  Future<void> _bulkDelete() async {
    if (_selectedContactIds.isEmpty) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.adminListContactScreenModalDeleteTitle),
        content: Text(
          context.l10n.adminListContactScreenModalDeleteConfirmMessageMultiple(
            _selectedContactIds.length.toString(),
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
            child: Text(
              context.l10n.adminListContactScreenModalDeleteConfirmButton,
            ),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      final params = BulkDeleteContactsUsecaseParams(
        _selectedContactIds.toList(),
      );

      await ref
          .read(contactMutationNotifierProvider.notifier)
          .bulkDeleteContacts(params);

      final mutationState = ref.read(contactMutationNotifierProvider);
      if (mutationState.status == ContactMutationStatus.success) {
        _clearSelection();
        widget.onRefresh?.call();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                mutationState.successMessage ??
                    context.l10n.adminListContactScreenAlertDeleteSuccess,
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else if (mutationState.status == ContactMutationStatus.error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                mutationState.failure?.message ??
                    context.l10n.adminListContactScreenAlertDeleteError,
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
    ref.listen(contactMutationNotifierProvider, (previous, next) {
      if (previous?.status != next.status) {
        if (next.status == ContactMutationStatus.success &&
            next.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.successMessage!),
              backgroundColor: Colors.green,
            ),
          );
        } else if (next.status == ContactMutationStatus.error &&
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
    if (widget.isLoading && widget.contacts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.contacts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.contact_mail_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              AppText(
                context.l10n.adminListContactScreenEmptyTitle,
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
        if (_selectedContactIds.isNotEmpty) ...[
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
                    context.l10n.adminListContactScreenBulkActionsItemsSelected(
                      _selectedContactIds.length.toString(),
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
                    context.l10n.adminListContactScreenBulkActionsDeleteButton,
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
          child: AppText('Contacts', style: AppTextStyle.titleLarge),
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
                          ...widget.contacts.asMap().entries.map(
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
            width: 200,
            child: AppText(
              context.l10n.adminListContactScreenTableHeadersName.toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 250,
            child: AppText(
              context.l10n.adminListContactScreenTableHeadersSubject
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              context.l10n.adminListContactScreenTableHeadersStatus
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              context.l10n.adminListContactScreenTableHeadersCreatedAt
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText(
                context.l10n.adminListContactScreenTableHeadersActions
                    .toUpperCase(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Contact contact, int index) {
    final isSelected = _selectedContactIds.contains(contact.id);

    return GestureDetector(
      onLongPress: isSelected ? null : () => _toggleSelection(contact.id),
      onTap: () => _toggleSelection(contact.id),
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
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          contact.fullName ?? contact.email ?? 'Unknown',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (contact.email != null && contact.fullName != null)
                          AppText(
                            contact.email!,
                            style: AppTextStyle.bodySmall,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.7,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
              width: 250,
              child: AppText(
                contact.subject,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 120, child: _buildStatusChip(context, contact)),
            SizedBox(
              width: 150,
              child: AppText(
                DateFormat('dd MMM yyyy').format(contact.createdAt),
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.more_horiz, size: 20),
                  onPressed: () {
                    context.router.push(
                      AdminUpsertContactRoute(contact: contact),
                    );
                  },
                  tooltip: context
                      .l10n
                      .adminListContactScreenTableActionsTooltipView,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, Contact contact) {
    return Chip(
      label: Text(
        contact.status == ContactStatus.pending
            ? context.l10n.adminUpsertContactScreenStatusPending
            : context.l10n.adminUpsertContactScreenStatusReplied,
      ),
      backgroundColor: contact.status == ContactStatus.pending
          ? Colors.orange.shade100
          : Colors.green.shade100,
      labelStyle: TextStyle(
        color: contact.status == ContactStatus.pending
            ? Colors.orange.shade800
            : Colors.green.shade800,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
      side: BorderSide.none,
    );
  }
}
