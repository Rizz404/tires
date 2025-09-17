import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum UsersStatus { initial, loading, success, error, loadingMore }

class UsersState extends Equatable {
  final UsersStatus status;
  final List<User> users;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const UsersState({
    this.status = UsersStatus.initial,
    this.users = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  UsersState copyWith({
    UsersStatus? status,
    List<User>? users,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  UsersState copyWithClearError() {
    return UsersState(
      status: status,
      users: users,
      cursor: cursor,
      errorMessage: null,
      hasNextPage: hasNextPage,
    );
  }

  @override
  List<Object?> get props => [status, users, cursor, errorMessage, hasNextPage];
}
