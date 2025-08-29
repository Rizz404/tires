import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:intl/intl.dart';

class CustomerTableWidget extends StatelessWidget {
  final List<User> customers;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const CustomerTableWidget({
    super.key,
    required this.customers,
    this.isLoading = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && customers.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (customers.isEmpty) {
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
                'No customers found',
                style: AppTextStyle.bodyLarge,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
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

    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildTableHeader(context),
          const Divider(height: 1),
          ...customers.map((customer) => _buildTableRow(context, customer)),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: AppText(
              'Customer',
              style: AppTextStyle.titleSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(
            flex: 3,
            child: AppText(
              'Contact Info',
              style: AppTextStyle.titleSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(
            flex: 2,
            child: AppText(
              'Status',
              style: AppTextStyle.titleSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(
            flex: 2,
            child: AppText(
              'Reservations',
              style: AppTextStyle.titleSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(
            flex: 2,
            child: AppText(
              'Last Reservation',
              style: AppTextStyle.titleSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 48,
            child: AppText(
              'Actions',
              style: AppTextStyle.titleSmall,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, User customer) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Customer Column
          Expanded(flex: 3, child: _buildCustomerInfo(context, customer)),
          // Contact Info Column
          Expanded(flex: 3, child: _buildContactInfo(context, customer)),
          // Status Column
          Expanded(flex: 2, child: _buildStatusInfo(context, customer)),
          // Reservations Column
          Expanded(flex: 2, child: _buildReservationsCount(context, customer)),
          // Last Reservation Column
          Expanded(flex: 2, child: _buildLastReservation(context, customer)),
          // Actions Column
          SizedBox(width: 48, child: _buildActions(context, customer)),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context, User customer) {
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

  Widget _buildContactInfo(BuildContext context, User customer) {
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
          customer.phoneNumber,
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStatusInfo(BuildContext context, User customer) {
    // Use a different logic for guest vs registered - guests might have recent verification dates
    final isRegistered =
        customer.companyName != null || customer.department != null;
    final bool isFirstTime = _getMockReservationCount(customer) == 0;

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
            isRegistered ? 'Registered' : 'Guest',
            style: AppTextStyle.labelSmall,
            fontWeight: FontWeight.w500,
            color: isRegistered
                ? context.colorScheme.primary
                : context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4),
        AppText(
          isFirstTime ? 'First Time' : 'Repeat',
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildReservationsCount(BuildContext context, User customer) {
    final count = _getMockReservationCount(customer);
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
          count == 1 ? 'reservation' : 'reservations',
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildLastReservation(BuildContext context, User customer) {
    final lastReservation = _getMockLastReservationDate(customer);

    if (lastReservation == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            'No reservations',
            style: AppTextStyle.bodySmall,
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
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

  Widget _buildActions(BuildContext context, User customer) {
    return IconButton(
      onPressed: () {
        // TODO: Navigate to customer details
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppText('View details for ${customer.fullName}'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      icon: Icon(
        Icons.visibility_outlined,
        size: 20,
        color: context.colorScheme.primary,
      ),
      tooltip: 'View customer details',
    );
  }

  String _getInitials(String fullName) {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty) return 'N/A';
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0].substring(0, 1)}${parts[parts.length - 1].substring(0, 1)}'
        .toUpperCase();
  }

  // Mock data helpers - replace with actual data later
  int _getMockReservationCount(User customer) {
    // Mock logic based on user ID
    final id = customer.id;
    if (id % 5 == 0) return 0; // First time customers
    if (id % 3 == 0) return (id % 10) + 1;
    return (id % 7) + 1;
  }

  DateTime? _getMockLastReservationDate(User customer) {
    final count = _getMockReservationCount(customer);
    if (count == 0) return null;

    final now = DateTime.now();
    final daysAgo = (customer.id % 30) + 1;
    return now.subtract(Duration(days: daysAgo));
  }
}
