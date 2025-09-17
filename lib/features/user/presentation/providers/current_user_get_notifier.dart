import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/user/domain/usecases/get_current_user_usecase.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_state.dart';

class CurrentUserGetNotifier extends Notifier<CurrentUserGetState> {
  late GetCurrentUserUsecase _getCurrentUserUsecase;

  @override
  CurrentUserGetState build() {
    _getCurrentUserUsecase = ref.watch(getCurrentUserUsecaseProvider);
    Future.microtask(() => getInitialUser());
    return const CurrentUserGetState();
  }

  Future<void> getInitialUser() async {
    // Prevent duplicate loading if already in progress
    if (state.status == CurrentUserGetStatus.loading) return;

    AppLogger.uiInfo('Getting initial user');
    state = state.copyWith(status: CurrentUserGetStatus.loading);

    final params = const GetCurrentUserParams();
    final response = await _getCurrentUserUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to get initial user', failure);
        state = state.copyWith(
          status: CurrentUserGetStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiInfo('Initial user retrieved successfully');
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
    AppLogger.uiInfo('Clearing current user get state');
    state = const CurrentUserGetState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      AppLogger.uiInfo('Clearing current user get error');
      state = state.copyWithClearError();
    }
  }
}
