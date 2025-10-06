import 'package:equatable/equatable.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

enum MenuStatus { initial, loading, loaded, loadingMore, error }

class MenuState extends Equatable {
  final MenuStatus status;
  final List<Menu> menus;
  final String? errorMessage;
  final bool hasNextPage;
  final String? nextCursor;

  const MenuState({
    this.status = MenuStatus.initial,
    this.menus = const [],
    this.errorMessage,
    this.hasNextPage = false,
    this.nextCursor,
  });

  MenuState copyWith({
    MenuStatus? status,
    List<Menu>? menus,
    String? errorMessage,
    bool? hasNextPage,
    String? nextCursor,
    bool forceErrorMessageNull = false,
    bool forceNextCursorNull = false,
  }) {
    return MenuState(
      status: status ?? this.status,
      menus: menus ?? this.menus,
      errorMessage: forceErrorMessageNull
          ? null
          : errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      nextCursor: forceNextCursorNull ? null : nextCursor ?? this.nextCursor,
    );
  }

  @override
  List<Object?> get props => [
    status,
    menus,
    errorMessage,
    hasNextPage,
    nextCursor,
  ];
}
