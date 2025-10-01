import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/menu/domain/usecases/bulk_delete_menus_usecase.dart';
import 'package:tires/features/menu/domain/usecases/create_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/delete_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/update_menu_usecase.dart';
import 'package:tires/features/menu/presentation/providers/menu_mutation_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';

class MenuMutationNotifier extends Notifier<MenuMutationState> {
  late CreateMenuUsecase _createMenuUsecase;
  late UpdateMenuUsecase _updateMenuUsecase;
  late DeleteMenuUsecase _deleteMenuUsecase;
  late BulkDeleteMenusUsecase _bulkDeleteMenusUsecase;

  @override
  MenuMutationState build() {
    _createMenuUsecase = ref.watch(createMenuUsecaseProvider);
    _updateMenuUsecase = ref.watch(updateMenuUsecaseProvider);
    _deleteMenuUsecase = ref.watch(deleteMenuUsecaseProvider);
    _bulkDeleteMenusUsecase = ref.watch(bulkDeleteMenuUsecaseProvider);
    return const MenuMutationState();
  }

  Future<void> createMenu(CreateMenuParams params) async {
    AppLogger.uiInfo('Creating menu in notifier');
    state = state.copyWith(status: MenuMutationStatus.loading);

    final response = await _createMenuUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to create menu', failure);
        state = state.copyWith(
          status: MenuMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully created menu');
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
    AppLogger.uiInfo('Updating menu in notifier');
    state = state.copyWith(status: MenuMutationStatus.loading);

    final response = await _updateMenuUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to update menu', failure);
        state = state.copyWith(
          status: MenuMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully updated menu');
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
    AppLogger.uiInfo('Deleting menu in notifier');
    state = state.copyWith(status: MenuMutationStatus.loading);

    final response = await _deleteMenuUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to delete menu', failure);
        state = state.copyWith(
          status: MenuMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully deleted menu');
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

  Future<void> bulkDeleteMenus(BulkDeleteMenusUsecaseParams params) async {
    AppLogger.uiInfo('Bulk deleting menus in notifier');
    state = state.copyWith(status: MenuMutationStatus.loading);

    final response = await _bulkDeleteMenusUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to bulk delete menus', failure);
        state = state.copyWith(
          status: MenuMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Successfully bulk deleted menus');
        state = state
            .copyWith(
              status: MenuMutationStatus.success,
              successMessage: success.message ?? 'Menus deleted successfully',
            )
            .copyWithClearError();
        ref.invalidate(adminMenuGetNotifierProvider);
      },
    );
  }

  void clearState() {
    AppLogger.uiInfo('Clearing menu mutation state');
    state = const MenuMutationState();
  }

  void clearError() {
    if (state.failure != null) {
      AppLogger.uiInfo('Clearing menu mutation error');
      state = state.copyWithClearError();
    }
  }

  void clearSuccess() {
    if (state.successMessage != null) {
      AppLogger.uiInfo('Clearing menu mutation success message');
      state = state.copyWithClearSuccess();
    }
  }
}
