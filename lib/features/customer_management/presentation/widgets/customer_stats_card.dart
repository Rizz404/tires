import 'package:flutter/material.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class CustomerStatsCard extends StatelessWidget {
  final List<User> customers;

  const CustomerStatsCard({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats();

    return Card(
      elevation: 2,
      shadowColor: context.theme.shadowColor.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildStatItem(
                  context,
                  count: stats.firstTimeCustomers,
                  label: context.l10n.adminListCustomerManagementStatsFirstTime,
                  icon: Icons.fiber_new,
                  color: Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildStatItem(
                  context,
                  count: stats.repeatCustomers,
                  label: context.l10n.adminListCustomerManagementStatsRepeat,
                  icon: Icons.repeat,
                  color: Colors.green,
                ),
                const SizedBox(height: 12),
                _buildStatItem(
                  context,
                  count: stats.dormantCustomers,
                  label: context.l10n.adminListCustomerManagementStatsDormant,
                  icon: Icons.schedule,
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required int count,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  style: AppTextStyle.bodyMedium,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                AppText(
                  count.toString(),
                  style: AppTextStyle.headlineSmall,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomerStats _calculateStats() {
    final totalCustomers = customers.length;

    // Mock calculation for customer types based on reservation history
    final firstTimeCustomers = customers
        .where((c) => _getMockReservationCount(c) == 0)
        .length;
    final repeatCustomers = customers
        .where((c) => _getMockReservationCount(c) >= 2)
        .length;
    final dormantCustomers = customers
        .where((c) => _isDormantCustomer(c))
        .length;

    return CustomerStats(
      totalCustomers: totalCustomers,
      firstTimeCustomers: firstTimeCustomers,
      repeatCustomers: repeatCustomers,
      dormantCustomers: dormantCustomers,
    );
  }

  // Mock logic - replace with actual data later
  int _getMockReservationCount(User customer) {
    final id = customer.id;
    if (id % 5 == 0) return 0; // First time customers
    if (id % 3 == 0) return (id % 10) + 1;
    return (id % 7) + 1;
  }

  // Mock logic for dormant customers (no reservations in last 6 months)
  bool _isDormantCustomer(User customer) {
    final id = customer.id;
    // Simulate some customers being dormant
    return id % 8 == 0;
  }
}

class CustomerStats {
  final int totalCustomers;
  final int firstTimeCustomers;
  final int repeatCustomers;
  final int dormantCustomers;

  const CustomerStats({
    required this.totalCustomers,
    required this.firstTimeCustomers,
    required this.repeatCustomers,
    required this.dormantCustomers,
  });
}
