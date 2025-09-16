import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/delete_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/update_announcement_usecase.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_providers.dart';

class AnnouncementMutationNotifier extends Notifier<AnnouncementMutationState> {
  late CreateAnnouncementUsecase _createAnnouncementUsecase;
  late UpdateAnnouncementUsecase _updateAnnouncementUsecase;
  late DeleteAnnouncementUsecase _deleteAnnouncementUsecase;

  @override
  AnnouncementMutationState build() {
    _createAnnouncementUsecase = ref.watch(createAnnouncementUsecaseProvider);
    _updateAnnouncementUsecase = ref.watch(updateAnnouncementUsecaseProvider);
    _deleteAnnouncementUsecase = ref.watch(deleteAnnouncementUsecaseProvider);
    return const AnnouncementMutationState();
  }

  Future<void> createAnnouncement(CreateAnnouncementParams params) async {
    state = state.copyWith(status: AnnouncementMutationStatus.loading);

    final response = await _createAnnouncementUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: AnnouncementMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: AnnouncementMutationStatus.success,
              createdAnnouncement: success.data,
              successMessage:
                  success.message ?? 'Announcement created successfully',
            )
            .copyWithClearError();
        ref.invalidate(announcementGetNotifierProvider);
      },
    );
  }

  Future<void> updateAnnouncement(UpdateAnnouncementParams params) async {
    state = state.copyWith(status: AnnouncementMutationStatus.loading);

    final response = await _updateAnnouncementUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: AnnouncementMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: AnnouncementMutationStatus.success,
              updatedAnnouncement: success.data,
              successMessage:
                  success.message ?? 'Announcement updated successfully',
            )
            .copyWithClearError();
        ref.invalidate(announcementGetNotifierProvider);
      },
    );
  }

  Future<void> deleteAnnouncement(DeleteAnnouncementParams params) async {
    state = state.copyWith(status: AnnouncementMutationStatus.loading);

    final response = await _deleteAnnouncementUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: AnnouncementMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: AnnouncementMutationStatus.success,
              successMessage: success.message ?? 'Account deleted successfully',
            )
            .copyWithClearError();
        ref.invalidate(announcementGetNotifierProvider);
      },
    );
  }

  void clearState() {
    state = const AnnouncementMutationState();
  }

  void clearError() {
    if (state.failure != null) {
      state = state.copyWithClearError();
    }
  }

  void clearSuccess() {
    if (state.successMessage != null) {
      state = state.copyWithClearSuccess();
    }
  }
}
