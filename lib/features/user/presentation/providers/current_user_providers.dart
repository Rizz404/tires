import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_notifier.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_mutation_notifier.dart';
import 'package:tires/features/user/presentation/providers/current_user_mutation_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_reservations_notifier.dart';
import 'package:tires/features/user/presentation/providers/current_user_reservations_state.dart';

final currentUserGetNotifierProvider =
    StateNotifierProvider<CurrentUserGetNotifier, CurrentUserGetState>((ref) {
      final getCurrentUserUsecase = ref.watch(getCurrentUserUsecaseProvider);
      return CurrentUserGetNotifier(getCurrentUserUsecase);
    });

final currentUserMutationNotifierProvider =
    StateNotifierProvider<
      CurrentUserMutationNotifier,
      CurrentUserMutationState
    >((ref) {
      final updateUserUsecase = ref.watch(updateUserUsecaseProvider);
      final updateUserPasswordUsecase = ref.watch(
        updateUserPasswordUsecaseProvider,
      );
      final deleteUserAccountUsecase = ref.watch(
        deleteUserAccountUsecaseProvider,
      );

      return CurrentUserMutationNotifier(
        updateUserUsecase,
        updateUserPasswordUsecase,
        deleteUserAccountUsecase,
      );
    });

final currentUserReservationsNotifierProvider =
    StateNotifierProvider<
      CurrentUserReservationsNotifier,
      CurrentUserReservationsState
    >((ref) {
      final getUserReservationsCursorUsecase = ref.watch(
        getUserReservationsCursorUsecaseProvider,
      );
      return CurrentUserReservationsNotifier(getUserReservationsCursorUsecase);
    });
