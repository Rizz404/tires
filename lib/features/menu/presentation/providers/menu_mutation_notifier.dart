import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/menu/domain/usecases/create_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/delete_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/update_menu_usecase.dart';
import 'package:tires/features/menu/presentation/providers/menu_mutation_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';

class MenuMutationNotifier extends Notifier<MenuMutationState> {
  late final CreateMenuUsecase _createMenuUsecase;
  late final UpdateMenuUsecase _updateMenuUsecase;
  late final DeleteMenuUsecase _deleteMenuUsecase;

  @override
  MenuMutationState build() {
    _createMenuUsecase = ref.watch(createMenuUsecaseProvider);
    _updateMenuUsecase = ref.watch(updateMenuUsecaseProvider);
    _deleteMenuUsecase = ref.watch(deleteMenuUsecaseProvider);
    return const MenuMutationState();
  }

  Future<void> createMenu(CreateMenuParams params) async {
    state = state.copyWith(status: MenuMutationStatus.loading);

    final response = await _createMenuUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: MenuMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: MenuMutationStatus.success,
              createdMenu: success.data,
              successMessage: success.message ?? 'Menu created successfully',
            )
            .copyWithClearError();
        ref.invalidate(adminMenuGetNotifierProvider);
      },
    );
  }

  Future<void> updateMenu(UpdateMenuParams params) async {
    state = state.copyWith(status: MenuMutationStatus.loading);

    final response = await _updateMenuUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: MenuMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: MenuMutationStatus.success,
              updatedMenu: success.data,
              successMessage: success.message ?? 'Menu updated successfully',
            )
            .copyWithClearError();
        ref.invalidate(adminMenuGetNotifierProvider);
      },
    );
  }

  Future<void> deleteMenu(DeleteMenuParams params) async {
    state = state.copyWith(status: MenuMutationStatus.loading);

    final response = await _deleteMenuUsecase(params);

    response.fold(
      (failure) {
        state = state.copyWith(
          status: MenuMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        state = state
            .copyWith(
              status: MenuMutationStatus.success,
              successMessage: success.message ?? 'Menu deleted successfully',
            )
            .copyWithClearError();
        ref.invalidate(adminMenuGetNotifierProvider);
      },
    );
  }

  void clearState() {
    state = const MenuMutationState();
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
