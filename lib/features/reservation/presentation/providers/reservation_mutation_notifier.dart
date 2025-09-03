import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:tires/features/reservation/domain/usecases/update_reservation_usecase.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_mutation_state.dart';

class ReservationMutationNotifier
    extends StateNotifier<ReservationMutationState> {
  final CreateReservationUsecase _createReservationUsecase;
  final UpdateReservationUsecase _updateReservationUsecase;
  final DeleteReservationUsecase _deleteReservationUsecase;

  ReservationMutationNotifier(
    this._createReservationUsecase,
    this._updateReservationUsecase,
    this._deleteReservationUsecase,
  ) : super(const ReservationMutationState());

  Future<void> createReservation() async {
    state = state.copyWith(status: ReservationMutationStatus.loading);

    const params = CreateReservationParams();
    final response = await _createReservationUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: ReservationMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: ReservationMutationStatus.success,
              reservation: success.data,
              successMessage:
                  success.message ?? 'Reservation created successfully',
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> updateReservation({required String id}) async {
    state = state.copyWith(status: ReservationMutationStatus.loading);

    final params = UpdateReservationParams(id: id);
    final response = await _updateReservationUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: ReservationMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: ReservationMutationStatus.success,
              reservation: success.data,
              successMessage:
                  success.message ?? 'Reservation updated successfully',
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> deleteReservation({required String id}) async {
    state = state.copyWith(status: ReservationMutationStatus.loading);

    final params = DeleteReservationParams(id: id);
    final response = await _deleteReservationUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: ReservationMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: ReservationMutationStatus.success,
              reservation: success.data,
              successMessage:
                  success.message ?? 'Reservation deleted successfully',
            )
            .copyWithClearError();
      },
    );
  }

  void clearState() {
    state = const ReservationMutationState();
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
