import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_notifier.dart';
import 'package:tires/features/announcement/presentation/providers/announcements_state.dart';

final announcementGetNotifierProvider =
    StateNotifierProvider<AnnouncementsNotifier, AnnouncementsState>((ref) {
      final getAnnouncementUsecase = ref.watch(
        getAnnouncementsCursorUsecaseProvider,
      );
      return AnnouncementsNotifier(getAnnouncementUsecase);
    });

// final announcementMutationNotifierProvider =
//     StateNotifierProvider<
//       AnnouncementMutationNotifier,
//       AnnouncementMutationState
//     >((ref) {
//       final updateUserUsecase = ref.watch(updateUserUsecaseProvider);
//       final updateUserPasswordUsecase = ref.watch(
//         updateUserPasswordUsecaseProvider,
//       );
//       final deleteUserAccountUsecase = ref.watch(
//         deleteUserAccountUsecaseProvider,
//       );

//       return AnnouncementMutationNotifier(
//         updateUserUsecase,
//         updateUserPasswordUsecase,
//         deleteUserAccountUsecase,
//       );
//     });
