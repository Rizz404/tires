import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class ContactSection extends StatelessWidget {
  final List<Contact> contacts;

  const ContactSection({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.l10n.adminDashboardContactTitle,
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        if (contacts.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Center(
              child: AppText(
                context.l10n.adminDashboardContactNoPending,
                style: AppTextStyle.bodyMedium,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          )
        else
          Card(
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
                    ...contacts
                        .take(5)
                        .map((contact) => _buildTableRow(context, contact)),
                  ],
                ),
              ),
            ),
          ),
        if (contacts.length > 5)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to contacts page
                },
                child: AppText(
                  context.l10n.adminDashboardContactSeeMore,
                  style: AppTextStyle.bodyMedium,
                  color: context.colorScheme.primary,
                ),
              ),
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
            width: 100,
            child: AppText(
              context.l10n.adminDashboardContactReceivedAt.toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              context.l10n.adminDashboardContactCustomerName.toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 200,
            child: AppText(
              context.l10n.adminDashboardContactSubject.toUpperCase(),
              fontWeight: FontWeight.bold,
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
          SizedBox(
            width: 100,
            child: AppText(
              DateFormat('MM/dd\nHH:mm').format(contact.createdAt),
              style: AppTextStyle.bodySmall,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              contact.fullName ?? 'Unknown',
              style: AppTextStyle.bodySmall,
            ),
          ),
          SizedBox(
            width: 200,
            child: AppText(
              contact.subject,
              style: AppTextStyle.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
