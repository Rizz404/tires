import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AnnouncementsSection extends StatelessWidget {
  final List<Announcement> announcements;

  const AnnouncementsSection({super.key, required this.announcements});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  // Handle close action, e.g., remove announcement
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
