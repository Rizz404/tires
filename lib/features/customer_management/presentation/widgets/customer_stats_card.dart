import 'package:flutter/material.dart';
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
            Row(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  size: 24,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                AppText(
                  'Customer Statistics',
                  style: AppTextStyle.titleMedium,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    count: stats.totalCustomers,
                    label: 'Total Customers',
                    icon: Icons.people,
                    color: context.colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    count: stats.registeredCustomers,
                    label: 'Registered',
                    icon: Icons.verified_user,
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    count: stats.guestCustomers,
                    label: 'Guests',
                    icon: Icons.person_outline,
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    count: stats.firstTimeCustomers,
                    label: 'First Time',
                    icon: Icons.fiber_new,
                    color: Colors.blue,
                  ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 8),
          AppText(
            count.toString(),
            style: AppTextStyle.headlineSmall,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          const SizedBox(height: 4),
          AppText(
            label,
            style: AppTextStyle.bodySmall,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  CustomerStats _calculateStats() {
    final totalCustomers = customers.length;
    final registeredCustomers = customers
        .where((c) => c.companyName != null || c.department != null)
        .length;
    final guestCustomers = totalCustomers - registeredCustomers;

    // Mock calculation for first time customers
    final firstTimeCustomers = customers
        .where((c) => _getMockReservationCount(c) == 0)
        .length;

    return CustomerStats(
      totalCustomers: totalCustomers,
      registeredCustomers: registeredCustomers,
      guestCustomers: guestCustomers,
      firstTimeCustomers: firstTimeCustomers,
    );
  }

  // Mock logic - replace with actual data later
  int _getMockReservationCount(User customer) {
    final id = customer.id;
    if (id % 5 == 0) return 0; // First time customers
    if (id % 3 == 0) return (id % 10) + 1;
    return (id % 7) + 1;
  }
}

class CustomerStats {
  final int totalCustomers;
  final int registeredCustomers;
  final int guestCustomers;
  final int firstTimeCustomers;

  const CustomerStats({
    required this.totalCustomers,
    required this.registeredCustomers,
    required this.guestCustomers,
    required this.firstTimeCustomers,
  });
}
