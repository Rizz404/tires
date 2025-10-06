import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_notifier.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_notifier.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_statistics_notifier.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_statistics_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_search_notifier.dart';

final announcementGetNotifierProvider =
    NotifierProvider<AnnouncementsNotifier, AnnouncementsState>(
      AnnouncementsNotifier.new,
    );

final announcementMutationNotifierProvider =
    NotifierProvider<AnnouncementMutationNotifier, AnnouncementMutationState>(
      AnnouncementMutationNotifier.new,
    );

final announcementStatisticsNotifierProvider =
    NotifierProvider<
      AnnouncementStatisticsNotifier,
      AnnouncementStatisticsState
    >(AnnouncementStatisticsNotifier.new);

final announcementSearchNotifierProvider =
    NotifierProvider<AnnouncementsSearchNotifier, AnnouncementsState>(
      AnnouncementsSearchNotifier.new,
    );
