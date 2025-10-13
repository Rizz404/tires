import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:intl/intl.dart';

class CustomerTableWidget extends StatefulWidget {
  final List<Customer> customers;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasNextPage;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;

  const CustomerTableWidget({
    super.key,
    required this.customers,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasNextPage = false,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  State<CustomerTableWidget> createState() => _CustomerTableWidgetState();
}

class _CustomerTableWidgetState extends State<CustomerTableWidget> {
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

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.customers.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.customers.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_outline,
                size: 64,
                color: context.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 16),
              AppText(
                context.l10n.adminListCustomerManagementTableEmptyTitle,
                style: AppTextStyle.bodyLarge,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              if (widget.onRefresh != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: widget.onRefresh,
                  child: AppText(
                    context.l10n.adminListCustomerManagementFiltersResetButton,
                  ),
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
            color: context.colorScheme.surfaceContainerHighest.withOpacity(0.3),
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
                      ...widget.customers.asMap().entries.map(
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
                                foregroundColor: context.colorScheme.primary,
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
              context.l10n.adminListCustomerManagementTableHeaderCustomer
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 180,
            child: AppText(
              context.l10n.adminListCustomerManagementTableHeaderContactInfo
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              context.l10n.adminListCustomerManagementTableHeaderStatus
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              context.l10n.adminListCustomerManagementTableHeaderReservations
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 140,
            child: AppText(
              context.l10n.adminListCustomerManagementTableHeaderTotalAmount
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 140,
            child: AppText(
              context.l10n.adminListCustomerManagementTableHeaderLastReservation
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText(
                context.l10n.adminListCustomerManagementTableHeaderActions
                    .toUpperCase(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Customer customer, int index) {
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
          // Number Column
          SizedBox(
            width: 60,
            child: AppText(
              '${index + 1}',
              style: AppTextStyle.bodyMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
          // Customer Column
          SizedBox(width: 200, child: _buildCustomerInfo(context, customer)),
          // Contact Info Column
          SizedBox(width: 180, child: _buildContactInfo(context, customer)),
          // Status Column
          SizedBox(width: 120, child: _buildStatusInfo(context, customer)),
          // Reservations Column
          SizedBox(
            width: 120,
            child: _buildReservationsCount(context, customer),
          ),
          // Total Amount Column
          SizedBox(width: 140, child: _buildTotalAmount(context, customer)),
          // Last Reservation Column
          SizedBox(width: 140, child: _buildLastReservation(context, customer)),
          // Actions Column
          SizedBox(width: 80, child: _buildActions(context, customer)),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context, Customer customer) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: context.colorScheme.primary.withValues(alpha: 0.2),
          child: AppText(
            _getInitials(customer.fullName),
            style: AppTextStyle.labelMedium,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                customer.fullName,
                style: AppTextStyle.bodyMedium,
                fontWeight: FontWeight.w500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              AppText(
                customer.fullNameKana,
                style: AppTextStyle.bodySmall,
                color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context, Customer customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          customer.email,
          style: AppTextStyle.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        AppText(
          customer.phoneNumber ?? '',
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStatusInfo(BuildContext context, Customer customer) {
    // Use isRegistered field from customer entity
    final isRegistered = customer.isRegistered == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isRegistered
                ? context.colorScheme.primary.withValues(alpha: 0.1)
                : context.colorScheme.outline.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: AppText(
            isRegistered
                ? context
                      .l10n
                      .adminListCustomerManagementTableStatusBadgeRegistered
                : context.l10n.adminListCustomerManagementTableStatusBadgeGuest,
            style: AppTextStyle.labelSmall,
            fontWeight: FontWeight.w500,
            color: isRegistered
                ? context.colorScheme.primary
                : context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4),
        _buildTypeBadge(context, customer),
      ],
    );
  }

  Widget _buildReservationsCount(BuildContext context, Customer customer) {
    final count = customer.reservationCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          count.toString(),
          style: AppTextStyle.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        AppText(
          context.l10n.adminListCustomerManagementTableReservationsCount
              .replaceFirst(':count', count.toString()),
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildTotalAmount(BuildContext context, Customer customer) {
    // Parse the total amount string to double for formatting
    final amount = double.tryParse(customer.totalAmount) ?? 0.0;
    final formattedAmount = NumberFormat.currency(
      locale: 'ja_JP',
      symbol: '¥',
      decimalDigits: 0,
    ).format(amount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          formattedAmount,
          style: AppTextStyle.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        AppText(
          context.l10n.adminListCustomerManagementTableHeaderTotalAmount,
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildLastReservation(BuildContext context, Customer customer) {
    final lastReservation = customer.latestReservation != null
        ? DateTime.tryParse(customer.latestReservation!)
        : null;

    if (lastReservation == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            context.l10n.adminListCustomerManagementTableEmptyDescription,
            style: AppTextStyle.bodySmall,
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    final now = DateTime.now();
    final difference = now.difference(lastReservation).inDays;
    String relativeDate;

    if (difference == 0) {
      relativeDate = 'Today';
    } else if (difference == 1) {
      relativeDate = 'Yesterday';
    } else if (difference < 7) {
      relativeDate = '$difference days ago';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      relativeDate = weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else {
      relativeDate = DateFormat('MMM dd, yyyy').format(lastReservation);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          relativeDate,
          style: AppTextStyle.bodySmall,
          fontWeight: FontWeight.w500,
        ),
        AppText(
          DateFormat('MMM dd, yyyy').format(lastReservation),
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, Customer customer) {
    return IconButton(
      onPressed: () {
        context.router.push(AdminCustomerDetailRoute(customerId: customer.id));
      },
      icon: Icon(
        Icons.visibility_outlined,
        size: 20,
        color: context.colorScheme.primary,
      ),
      tooltip: context
          .l10n
          .adminListCustomerManagementTableActionsTooltipViewDetails,
    );
  }

  Widget _buildTypeBadge(BuildContext context, Customer customer) {
    final reservationCount = customer.reservationCount;
    final isDormant =
        reservationCount == 0; // Simple logic: dormant if no reservations

    String label;
    Color color;

    if (isDormant) {
      label = context.l10n.adminListCustomerManagementTableTypeBadgeDormant;
      color = Colors.orange;
    } else if (reservationCount == 0) {
      label = context.l10n.adminListCustomerManagementTableTypeBadgeFirstTime;
      color = Colors.blue;
    } else {
      label = context.l10n.adminListCustomerManagementTableTypeBadgeRepeat;
      color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: AppText(
        label,
        style: AppTextStyle.labelSmall,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }

  String _getInitials(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'N/A';
    if (parts.length == 1) {
      return parts[0].isNotEmpty
          ? parts[0].substring(0, 1).toUpperCase()
          : 'N/A';
    }
    final firstInitial = parts[0].isNotEmpty ? parts[0].substring(0, 1) : '';
    final lastInitial = parts[parts.length - 1].isNotEmpty
        ? parts[parts.length - 1].substring(0, 1)
        : '';
    return '$firstInitial$lastInitial'.toUpperCase();
  }

  // Mock data helpers - replace with actual data later
}
