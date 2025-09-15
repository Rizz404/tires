import 'package:equatable/equatable.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

enum MenuMutationStatus { initial, loading, success, error }

class MenuMutationState extends Equatable {
  final MenuMutationStatus status;
  final Menu? createdMenu;
  final Menu? updatedMenu;
  final Failure? failure;
  final String? successMessage;

  const MenuMutationState({
    this.status = MenuMutationStatus.initial,
    this.createdMenu,
    this.updatedMenu,
    this.failure,
    this.successMessage,
  });

  MenuMutationState copyWith({
    MenuMutationStatus? status,
    Menu? createdMenu,
    Menu? updatedMenu,
    Failure? failure,
    String? successMessage,
  }) {
    return MenuMutationState(
      status: status ?? this.status,
      updatedMenu: updatedMenu ?? this.updatedMenu,
      createdMenu: createdMenu ?? this.createdMenu,
      failure: failure ?? this.failure,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  MenuMutationState copyWithClearError() {
    return MenuMutationState(
      status: status,
      updatedMenu: updatedMenu,
      createdMenu: createdMenu,
      failure: null,
      successMessage: successMessage,
    );
  }

  MenuMutationState copyWithClearSuccess() {
    return MenuMutationState(
      status: status,
      updatedMenu: updatedMenu,
      createdMenu: createdMenu,
      failure: failure,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    updatedMenu,
    createdMenu,
    failure,
    successMessage,
  ];
}
