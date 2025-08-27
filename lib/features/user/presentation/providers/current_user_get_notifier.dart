import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/user/domain/usecases/get_current_user_usecase.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_state.dart';

class CurrentUserGetNotifier extends StateNotifier<CurrentUserGetState> {
  final GetCurrentUserUsecase _getCurrentUserUsecase;

  CurrentUserGetNotifier(this._getCurrentUserUsecase)
    : super(const CurrentUserGetState()) {
    getInitialUser();
  }

  Future<void> getInitialUser() async {
    // Prevent duplicate loading if already in progress
    if (state.status == CurrentUserGetStatus.loading) return;

    state = state.copyWith(status: CurrentUserGetStatus.loading);

    final params = const GetCurrentUserParams();
    final response = await _getCurrentUserUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: CurrentUserGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state
            .copyWith(status: CurrentUserGetStatus.success, user: success.data)
            .copyWithClearError();
      },
    );
  }

  Future<void> getCurrentUser() async {
    await getInitialUser();
  }

  Future<void> refreshCurrentUser() async {
    await getInitialUser();
  }

  void clearState() {
    state = const CurrentUserGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
