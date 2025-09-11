import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
// Pastikan path import ini benar sesuai lokasi file entity baru Anda
import 'package:tires/features/user/domain/entities/announcement.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AnnouncementTableWidget extends StatelessWidget {
  final List<Announcement> announcements;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const AnnouncementTableWidget({
    super.key,
    required this.announcements,
    this.isLoading = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && announcements.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (announcements.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.campaign_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              AppText(
                context.l10n.adminListAnnouncementScreenEmptyTitle,
                style: AppTextStyle.bodyLarge,
                color: context.colorScheme.onSurface.withOpacity(0.6),
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
              ...announcements.map((ann) => _buildTableRow(context, ann)),
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
          const SizedBox(width: 50, child: Text('')), // Checkbox
          SizedBox(
            width: 300,
            child: AppText(
              context.l10n.adminListAnnouncementScreenTableHeadersTitle
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              context.l10n.adminListAnnouncementScreenTableHeadersPublishDate
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              context.l10n.adminListAnnouncementScreenTableHeadersStatus
                  .toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText(
                context.l10n.adminListAnnouncementScreenTableHeadersActions
                    .toUpperCase(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Announcement announcement) {
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
            width: 300,
            child: AppText(
              announcement.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              announcement.startDate != null
                  ? DateFormat('dd MMM yyyy').format(announcement.startDate!)
                  : '-',
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(width: 120, child: _buildStatusChip(context, announcement)),
          SizedBox(
            width: 80,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.visibility_outlined, size: 20),
                onPressed: () {},
                tooltip: context
                    .l10n
                    .adminListAnnouncementScreenTableActionsTooltipView,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, Announcement announcement) {
    return Chip(
      label: Text(
        announcement.isActive
            ? context.l10n.adminUpsertAnnouncementScreenStatusActive
            : context.l10n.adminUpsertAnnouncementScreenStatusInactive,
      ),
      backgroundColor: announcement.isActive
          ? Colors.green.shade100
          : Colors.grey.shade300,
      labelStyle: TextStyle(
        color: announcement.isActive
            ? Colors.green.shade800
            : Colors.grey.shade800,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
      side: BorderSide.none,
    );
  }
}
