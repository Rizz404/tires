import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:intl/intl.dart';

class ReservationTableWidget extends StatelessWidget {
  final List<Reservation> reservations;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const ReservationTableWidget({
    super.key,
    required this.reservations,
    this.isLoading = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && reservations.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (reservations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 16),
              AppText(
                'No reservations found',
                style: AppTextStyle.bodyLarge,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 8),
              AppText(
                'Try adjusting your filters or check back later',
                style: AppTextStyle.bodyMedium,
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              if (onRefresh != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(onPressed: onRefresh, child: AppText('Refresh')),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTableHeader(context),
              const Divider(height: 1, thickness: 1),
              ...reservations.map(
                (reservation) => _buildTableRow(context, reservation),
              ),
            ],
          ),
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
            width: 200,
            child: AppText('CUSTOMER', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 180,
            child: AppText('DATE & TIME', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 150,
            child: AppText('MENU', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 100,
            child: AppText('PEOPLE', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 120,
            child: AppText('STATUS', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText('ACTIONS', fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Reservation reservation) {
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
          // Customer Column
          SizedBox(width: 200, child: _buildCustomerInfo(context, reservation)),
          // Date & Time Column
          SizedBox(width: 180, child: _buildDateTimeInfo(context, reservation)),
          // Menu Column
          SizedBox(width: 150, child: _buildMenuInfo(context, reservation)),
          // People Column
          SizedBox(width: 100, child: _buildPeopleCount(context, reservation)),
          // Status Column
          SizedBox(width: 120, child: _buildStatusInfo(context, reservation)),
          // Actions Column
          SizedBox(width: 80, child: _buildActions(context, reservation)),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context, Reservation reservation) {
    final customerName = reservation.customerInfo.fullName;
    final customerEmail = reservation.customerInfo.email;
    final customerPhone = reservation.customerInfo.phoneNumber;

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: context.colorScheme.primary.withValues(alpha: 0.2),
          child: AppText(
            _getInitials(customerName),
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
                customerName,
                style: AppTextStyle.bodyMedium,
                fontWeight: FontWeight.w500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (customerEmail.isNotEmpty) ...[
                const SizedBox(height: 2),
                AppText(
                  customerEmail,
                  style: AppTextStyle.bodySmall,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (customerPhone.isNotEmpty) ...[
                const SizedBox(height: 1),
                AppText(
                  customerPhone,
                  style: AppTextStyle.bodySmall,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeInfo(BuildContext context, Reservation reservation) {
    final reservationDateTime = reservation.reservationDatetime;
    final dateStr = DateFormat('MMM dd, yyyy').format(reservationDateTime);
    final timeStr = DateFormat('HH:mm').format(reservationDateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          dateStr,
          style: AppTextStyle.bodyMedium,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 2),
        AppText(
          timeStr,
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
        const SizedBox(height: 1),
        AppText(
          _getRelativeTime(reservationDateTime),
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildMenuInfo(BuildContext context, Reservation reservation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          reservation.menu.name,
          style: AppTextStyle.bodyMedium,
          fontWeight: FontWeight.w500,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        AppText(
          reservation.menu.price.formatted,
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
        const SizedBox(height: 1),
        AppText(
          '${reservation.menu.requiredTime} min',
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildPeopleCount(BuildContext context, Reservation reservation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          reservation.numberOfPeople.toString(),
          style: AppTextStyle.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        AppText(
          reservation.numberOfPeople == 1 ? 'person' : 'people',
          style: AppTextStyle.bodySmall,
          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildStatusInfo(BuildContext context, Reservation reservation) {
    final status = reservation.status.label.toLowerCase();

    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
        break;
      case 'confirmed':
        statusColor = Colors.blue;
        statusIcon = Icons.check_circle_outline;
        break;
      case 'completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel_outlined;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 14, color: statusColor),
          const SizedBox(width: 4),
          AppText(
            reservation.status.label,
            style: AppTextStyle.labelSmall,
            fontWeight: FontWeight.w500,
            color: statusColor,
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, Reservation reservation) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 20, color: context.colorScheme.primary),
      onSelected: (value) {
        switch (value) {
          case 'view':
            // Navigate to reservation detail - we need to convert CalendarReservation to Reservation
            // For now, just navigate without reservation object
            context.router.push(AdminUpsertReservationRoute());
            break;
          case 'edit':
            // Navigate to edit reservation - we need to convert CalendarReservation to Reservation
            // For now, just navigate without reservation object
            context.router.push(AdminUpsertReservationRoute());
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'view',
          child: Row(
            children: [
              Icon(Icons.visibility_outlined, size: 16),
              SizedBox(width: 8),
              Text('View Details'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 16),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
      ],
    );
  }

  String _getInitials(String fullName) {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty) return 'NA';
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0].substring(0, 1)}${parts[parts.length - 1].substring(0, 1)}'
        .toUpperCase();
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.isNegative) {
      final daysPast = now.difference(dateTime).inDays;
      if (daysPast == 0) return 'Today (past)';
      if (daysPast == 1) return 'Yesterday';
      if (daysPast < 7) return '$daysPast days ago';
      return 'Past';
    } else {
      final daysAhead = difference.inDays;
      if (daysAhead == 0) return 'Today';
      if (daysAhead == 1) return 'Tomorrow';
      if (daysAhead < 7) return 'In $daysAhead days';
      return 'Future';
    }
  }
}
