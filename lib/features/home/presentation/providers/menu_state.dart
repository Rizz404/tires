import 'package:equatable/equatable.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

enum MenuStatus { initial, loading, loaded, error }

class MenuState extends Equatable {
  final MenuStatus status;
  final List<Menu> menus;
  final String? errorMessage;

  const MenuState({
    this.status = MenuStatus.initial,
    this.menus = const [],
    this.errorMessage,
  });

  MenuState copyWith({
    MenuStatus? status,
    List<Menu>? menus,
    String? errorMessage,
  }) {
    return MenuState(
      status: status ?? this.status,
      menus: menus ?? this.menus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, menus, errorMessage];

  @override
  bool get stringify => true;
}
