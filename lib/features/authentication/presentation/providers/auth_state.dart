import 'package:equatable/equatable.dart';

import 'package:tires/core/error/failure.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final Failure? failure;

  AuthState({this.status = AuthStatus.initial, this.user, this.failure});

  AuthState copyWith({AuthStatus? status, User? user, Failure? failure}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  // Todo: Objectnya yang jadiin nullable bukan propnya, nanti benerin ada yang salah
  @override
  List<Object?> get props => [status, user, failure];
}
