import 'package:equatable/equatable.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum CurrentUserMutationStatus { initial, loading, success, error }

class CurrentUserMutationState extends Equatable {
  final CurrentUserMutationStatus status;
  final User? updatedUser;
  final Failure? failure;
  final String? successMessage;

  const CurrentUserMutationState({
    this.status = CurrentUserMutationStatus.initial,
    this.updatedUser,
    this.failure,
    this.successMessage,
  });

  CurrentUserMutationState copyWith({
    CurrentUserMutationStatus? status,
    User? updatedUser,
    Failure? failure,
    String? successMessage,
  }) {
    return CurrentUserMutationState(
      status: status ?? this.status,
      updatedUser: updatedUser ?? this.updatedUser,
      failure: failure ?? this.failure,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  CurrentUserMutationState copyWithClearError() {
    return CurrentUserMutationState(
      status: status,
      updatedUser: updatedUser,
      failure: null,
      successMessage: successMessage,
    );
  }

  CurrentUserMutationState copyWithClearSuccess() {
    return CurrentUserMutationState(
      status: status,
      updatedUser: updatedUser,
      failure: failure,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, updatedUser, failure, successMessage];
}
