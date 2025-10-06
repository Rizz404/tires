import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum UsersSearchStatus { initial, loading, success, error, loadingMore }

class UsersSearchState extends Equatable {
  final UsersSearchStatus status;
  final List<User> users;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const UsersSearchState({
    this.status = UsersSearchStatus.initial,
    this.users = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  UsersSearchState copyWith({
    UsersSearchStatus? status,
    List<User>? users,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return UsersSearchState(
      status: status ?? this.status,
      users: users ?? this.users,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  UsersSearchState copyWithClearError() {
    return UsersSearchState(
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
