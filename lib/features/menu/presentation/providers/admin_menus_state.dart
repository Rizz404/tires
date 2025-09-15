import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

enum AdminMenusStatus { initial, loading, success, error, loadingMore }

class AdminMenusState extends Equatable {
  final AdminMenusStatus status;
  final List<Menu> menus;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const AdminMenusState({
    this.status = AdminMenusStatus.initial,
    this.menus = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  AdminMenusState copyWith({
    AdminMenusStatus? status,
    List<Menu>? menus,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return AdminMenusState(
      status: status ?? this.status,
      menus: menus ?? this.menus,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  AdminMenusState copyWithClearError() {
    return AdminMenusState(
      status: status,
      menus: menus,
      cursor: cursor,
      errorMessage: null,
      hasNextPage: hasNextPage,
    );
  }

  @override
  List<Object?> get props => [status, menus, cursor, errorMessage, hasNextPage];
}
