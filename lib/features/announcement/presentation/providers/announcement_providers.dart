import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_notifier.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_notifier.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_state.dart';

final announcementGetNotifierProvider =
    StateNotifierProvider<AnnouncementsNotifier, AnnouncementsState>((ref) {
      final getAnnouncementUsecase = ref.watch(
        getAnnouncementsCursorUsecaseProvider,
      );
      return AnnouncementsNotifier(getAnnouncementUsecase);
    });

final announcementMutationNotifierProvider =
    StateNotifierProvider<
      AnnouncementMutationNotifier,
      AnnouncementMutationState
    >((ref) {
      final createAnnouncementUsecase = ref.watch(
        createAnnouncementUsecaseProvider,
      );
      final updateAnnouncementUsecase = ref.watch(
        updateAnnouncementUsecaseProvider,
      );
      final deleteAnnouncementUsecase = ref.watch(
        deleteAnnouncementUsecaseProvider,
      );

      return AnnouncementMutationNotifier(
        createAnnouncementUsecase,
        updateAnnouncementUsecase,
        deleteAnnouncementUsecase,
      );
    });
