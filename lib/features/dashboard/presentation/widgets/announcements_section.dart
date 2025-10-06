import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/announcement/domain/usecases/delete_announcement_usecase.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_providers.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AnnouncementsSection extends ConsumerWidget {
  final List<Announcement> announcements;
  final VoidCallback? onPressed;

  const AnnouncementsSection({
    super.key,
    required this.announcements,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: announcements.map((announcement) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: context.colorScheme.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.colorScheme.secondary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.campaign,
                  color: context.colorScheme.secondary,
                  size: 20,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        announcement.title,
                        style: AppTextStyle.titleMedium,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.primary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        DateFormat(
                          'yyyy-MM-dd HH:mm',
                        ).format(announcement.publishedAt ?? DateTime.now()),
                        style: AppTextStyle.bodySmall,
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        announcement.content,
                        style: AppTextStyle.bodyMedium,
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.8,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 20,
                ),
                onPressed: () =>
                    _showDeleteConfirmation(context, ref, announcement),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    Announcement announcement,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Announcement'),
          content: Text(
            'Are you sure you want to delete "${announcement.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAnnouncement(ref, announcement);
              },
              style: TextButton.styleFrom(
                foregroundColor: context.colorScheme.error,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAnnouncement(WidgetRef ref, Announcement announcement) {
    ref
        .read(announcementMutationNotifierProvider.notifier)
        .deleteAnnouncement(DeleteAnnouncementParams(announcement.id));
  }
}
