import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_notifier.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_notifier.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_state.dart';

final announcementGetNotifierProvider =
    NotifierProvider<AnnouncementsNotifier, AnnouncementsState>(
      AnnouncementsNotifier.new,
    );

final announcementMutationNotifierProvider =
    NotifierProvider<AnnouncementMutationNotifier, AnnouncementMutationState>(
      AnnouncementMutationNotifier.new,
    );
