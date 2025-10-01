import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class ContactTableWidget extends StatefulWidget {
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
  State<ContactTableWidget> createState() => _ContactTableWidgetState();
}

class _ContactTableWidgetState extends State<ContactTableWidget> {
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
                  child: const AppText('Refresh'),
                ),
              ],
            ],
          ),
        ),
      );
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
                      ...widget.contacts.map(
                        (contact) => _buildTableRow(context, contact),
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

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: context.colorScheme.surface.withOpacity(0.5),
      child: Row(
        children: [
          const SizedBox(width: 50, child: Text('')), // Checkbox
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

  Widget _buildTableRow(BuildContext context, Contact contact) {
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
          SizedBox(width: 50, child: Checkbox(value: false, onChanged: (v) {})),
          SizedBox(
            width: 200,
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
                    color: context.colorScheme.onSurface.withOpacity(0.7),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                icon: const Icon(Icons.visibility_outlined, size: 20),
                onPressed: () {
                  context.router.push(
                    AdminUpsertContactRoute(contact: contact),
                  );
                },
                tooltip:
                    context.l10n.adminListContactScreenTableActionsTooltipView,
              ),
            ),
          ),
        ],
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
