import 'package:equatable/equatable.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum CurrentUserGetStatus { initial, loading, success, error }

class CurrentUserGetState extends Equatable {
  final CurrentUserGetStatus status;
  final User? user;
  final String? errorMessage;

  const CurrentUserGetState({
    this.status = CurrentUserGetStatus.initial,
    this.user,
    this.errorMessage,
  });

  CurrentUserGetState copyWith({
    CurrentUserGetStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return CurrentUserGetState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  CurrentUserGetState copyWithClearError() {
    return CurrentUserGetState(status: status, user: user, errorMessage: null);
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
