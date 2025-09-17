import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/user/domain/usecases/delete_current_user_account_usecase.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_password_usecase.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_usecase.dart';
import 'package:tires/features/user/presentation/providers/current_user_mutation_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_providers.dart';

class CurrentUserMutationNotifier extends Notifier<CurrentUserMutationState> {
  late UpdateCurrentUserUsecase _updateCurrentUserUsecase;
  late UpdateCurrentUserPasswordUsecase _updateCurrentUserPasswordUsecase;
  late DeleteCurrentUserAccountUsecase _deleteCurrentUserAccountUsecase;

  @override
  CurrentUserMutationState build() {
    _updateCurrentUserUsecase = ref.watch(updateCurrentUserUsecaseProvider);
    _updateCurrentUserPasswordUsecase = ref.watch(
      updateCurrentUserPasswordUsecaseProvider,
    );
    _deleteCurrentUserAccountUsecase = ref.watch(
      deleteCurrentUserAccountUsecaseProvider,
    );
    return const CurrentUserMutationState();
  }

  Future<void> updateCurrentUser({
    required String fullName,
    required String fullNameKana,
    required String email,
    required String phoneNumber,
    String? companyName,
    String? department,
    String? companyAddress,
    String? homeAddress,
    DateTime? dateOfBirth,
    String? gender,
  }) async {
    AppLogger.uiInfo('Updating current user');
    state = state.copyWith(status: CurrentUserMutationStatus.loading);

    final params = UpdateUserParams(
      fullName: fullName,
      fullNameKana: fullNameKana,
      email: email,
      phoneNumber: phoneNumber,
      companyName: companyName,
      department: department,
      companyAddress: companyAddress,
      homeAddress: homeAddress,
      dateOfBirth: dateOfBirth,
      gender: gender,
    );

    final response = await _updateCurrentUserUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to update current user', failure);
        state = state.copyWith(
          status: CurrentUserMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Current user updated successfully');
        state = state
            .copyWith(
              status: CurrentUserMutationStatus.success,
              updatedUser: success.data,
              successMessage: success.message ?? 'User updated successfully',
            )
            .copyWithClearError();
        ref.invalidate(currentUserGetNotifierProvider);
      },
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    AppLogger.uiInfo('Updating current user password');
    state = state.copyWith(status: CurrentUserMutationStatus.loading);

    final params = UpdateUserPasswordParams(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    final response = await _updateCurrentUserPasswordUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to update current user password', failure);
        state = state.copyWith(
          status: CurrentUserMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Current user password updated successfully');
        state = state
            .copyWith(
              status: CurrentUserMutationStatus.success,
              successMessage:
                  success.message ?? 'Password updated successfully',
            )
            .copyWithClearError();
        ref.invalidate(currentUserGetNotifierProvider);
      },
    );
  }

  Future<void> deleteAccount() async {
    AppLogger.uiInfo('Deleting current user account');
    state = state.copyWith(status: CurrentUserMutationStatus.loading);

    const params = DeleteUserAccountParams();
    final response = await _deleteCurrentUserAccountUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to delete current user account', failure);
        state = state.copyWith(
          status: CurrentUserMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Current user account deleted successfully');
        state = state
            .copyWith(
              status: CurrentUserMutationStatus.success,
              successMessage: success.message ?? 'Account deleted successfully',
            )
            .copyWithClearError();
        ref.invalidate(currentUserGetNotifierProvider);
      },
    );
  }

  void clearState() {
    AppLogger.uiInfo('Clearing current user mutation state');
    state = const CurrentUserMutationState();
  }

  void clearError() {
    if (state.failure != null) {
      AppLogger.uiInfo('Clearing current user mutation error');
      state = state.copyWithClearError();
    }
  }

  void clearSuccess() {
    if (state.successMessage != null) {
      AppLogger.uiInfo('Clearing current user mutation success');
      state = state.copyWithClearSuccess();
    }
  }
}
