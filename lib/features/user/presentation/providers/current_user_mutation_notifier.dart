import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/user/domain/usecases/delete_current_user_account_usecase.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_password_usecase.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_usecase.dart';
import 'package:tires/features/user/presentation/providers/current_user_mutation_state.dart';

class CurrentUserMutationNotifier
    extends StateNotifier<CurrentUserMutationState> {
  final UpdateCurrentUserUsecase _updateCurrentUserUsecase;
  final UpdateCurrentUserPasswordUsecase _updateCurrentUserPasswordUsecase;
  final DeleteCurrentUserAccountUsecase _deleteCurrentUserAccountUsecase;

  CurrentUserMutationNotifier(
    this._updateCurrentUserUsecase,
    this._updateCurrentUserPasswordUsecase,
    this._deleteCurrentUserAccountUsecase,
  ) : super(const CurrentUserMutationState());

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
        state = state.copyWith(
          status: CurrentUserMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: CurrentUserMutationStatus.success,
              updatedUser: success.data,
              successMessage: success.message ?? 'User updated successfully',
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    state = state.copyWith(status: CurrentUserMutationStatus.loading);

    final params = UpdateUserPasswordParams(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    final response = await _updateCurrentUserPasswordUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: CurrentUserMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: CurrentUserMutationStatus.success,
              successMessage:
                  success.message ?? 'Password updated successfully',
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> deleteAccount() async {
    state = state.copyWith(status: CurrentUserMutationStatus.loading);

    const params = DeleteUserAccountParams();
    final response = await _deleteCurrentUserAccountUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: CurrentUserMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: CurrentUserMutationStatus.success,
              successMessage: success.message ?? 'Account deleted successfully',
            )
            .copyWithClearError();
      },
    );
  }

  void clearState() {
    state = const CurrentUserMutationState();
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
