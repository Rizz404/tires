import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_providers.dart';
import 'package:tires/features/customer_management/domain/entities/customer_detail.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_detail_state.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

@RoutePage()
class AdminCustomerDetailScreen extends ConsumerStatefulWidget {
  final String customerId;
  const AdminCustomerDetailScreen({super.key, required this.customerId});

  @override
  ConsumerState<AdminCustomerDetailScreen> createState() =>
      _AdminCustomerDetailScreenState();
}

class _AdminCustomerDetailScreenState
    extends ConsumerState<AdminCustomerDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCustomerDetails();
    });
  }

  Future<void> _fetchCustomerDetails() async {
    await ref
        .read(customerDetailNotifierProvider.notifier)
        .getCustomerDetail(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerDetailNotifierProvider);

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _fetchCustomerDetails,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              _buildBody(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(CustomerDetailState state) {
    switch (state.status) {
      case CustomerDetailStatus.loading:
        return const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        );
      case CustomerDetailStatus.error:
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage ?? 'Failed to load customer details.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _fetchCustomerDetails,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      case CustomerDetailStatus.success:
        final customer = state.customerDetail;
        if (customer == null) {
          return const SliverFillRemaining(
            child: Center(child: Text('Customer not found.')),
          );
        }
        return SliverList(
          delegate: SliverChildListDelegate([
            StatTile(
              title: context
                  .l10n
                  .adminUpsertCustomerManagementStatsTotalReservations,
              value: customer.stats.reservationCount.toString(),
              icon: Icons.calendar_today,
              color: Colors.blue.shade100,
            ),
            const SizedBox(height: 12),
            StatTile(
              title: context.l10n.adminUpsertCustomerManagementStatsTireStorage,
              value: customer.stats.tireStorageCount.toString(),
              icon: Icons.warehouse_outlined,
              color: Colors.purple.shade100,
            ),
            const SizedBox(height: 24),
            _buildCustomerCard(context, customer),
            const SizedBox(height: 24),
            _buildCustomerInfoSection(context, customer),
            const SizedBox(height: 80),
          ]),
        );
      default:
        return const SliverFillRemaining(
          child: Center(child: Text('Something went wrong.')),
        );
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            context.l10n.adminUpsertCustomerManagementHeaderTitle,
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            context.l10n.adminUpsertCustomerManagementHeaderSubtitle,
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(BuildContext context, CustomerDetail customer) {
    final initials = customer.customer.fullName.isNotEmpty
        ? customer.customer.fullName.split(' ').map((e) => e[0]).take(2).join()
        : 'N/A';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: context.colorScheme.primary,
              child: AppText(
                initials,
                style: AppTextStyle.headlineMedium,
                color: context.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 12),
            AppText(
              customer.customer.fullName,
              style: AppTextStyle.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            if (customer.customer.fullNameKana.isNotEmpty) ...[
              const SizedBox(height: 2),
              AppText(
                customer.customer.fullNameKana,
                style: AppTextStyle.bodyMedium,
                color: context.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ],
            const SizedBox(height: 8),
            Chip(
              avatar: Icon(
                Icons.check_circle,
                color: Colors.green.shade700,
                size: 16,
              ),
              label: AppText(
                context
                    .l10n
                    .adminUpsertCustomerManagementSidebarStatusRegistered,
                style: AppTextStyle.labelMedium,
              ),
              backgroundColor: Colors.green.shade100,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              icon: Icons.email_outlined,
              label: context.l10n.adminUpsertCustomerManagementSidebarEmail,
              value: customer.customer.email,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.phone_outlined,
              label: context.l10n.adminUpsertCustomerManagementSidebarPhone,
              value: customer.customer.phoneNumber,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.cake_outlined,
              label: context.l10n.adminUpsertCustomerManagementSidebarDob,
              value: customer.customer.dateOfBirth ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfoSection(
    BuildContext context,
    CustomerDetail customer,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoTitle,
              style: AppTextStyle.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoFullName,
              value: customer.customer.fullName,
            ),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoFullNameKana,
              value: customer.customer.fullNameKana,
            ),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoEmail,
              value: customer.customer.email,
            ),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoPhoneNumber,
              value: customer.customer.phoneNumber,
            ),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoCompanyName,
              value: customer.customer.companyName ?? '',
            ),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoDepartment,
              value: customer.customer.department ?? '',
            ),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoDob,
              value: customer.customer.dateOfBirth ?? '',
            ),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoGender,
              value: customer.customer.gender ?? '',
            ),
            const SizedBox(height: 16),
            AppText(
              context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoAddressesTitle,
              style: AppTextStyle.titleMedium,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              label: context
                  .l10n
                  .adminUpsertCustomerManagementMainContentCustomerInfoCompanyAddress,
              value: customer.customer.companyAddress ?? '',
              isVertical: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: context.colorScheme.onSurfaceVariant),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(label, style: AppTextStyle.labelMedium),
              AppText(
                value.isNotEmpty ? value : 'N/A',
                style: AppTextStyle.bodyMedium,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    bool isVertical = false,
  }) {
    final valueWidget = AppText(
      value.isNotEmpty ? value : 'N/A',
      style: AppTextStyle.bodyLarge,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isVertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  style: AppTextStyle.bodyMedium,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                const SizedBox(height: 4),
                valueWidget,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: AppText(
                    label,
                    style: AppTextStyle.bodyMedium,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(flex: 3, child: valueWidget),
              ],
            ),
    );
  }
}
