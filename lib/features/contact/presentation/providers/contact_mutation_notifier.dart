import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/contact/domain/usecases/create_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/delete_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/update_contact_usecase.dart';
import 'package:tires/features/contact/presentation/providers/contact_mutation_state.dart';
import 'package:tires/features/contact/presentation/providers/contact_providers.dart';

class ContactMutationNotifier extends Notifier<ContactMutationState> {
  late CreateContactUsecase _createContactUsecase;
  late UpdateContactUsecase _updateContactUsecase;
  late DeleteContactUsecase _deleteContactUsecase;

  @override
  ContactMutationState build() {
    _createContactUsecase = ref.watch(createContactUsecaseProvider);
    _updateContactUsecase = ref.watch(updateContactUsecaseProvider);
    _deleteContactUsecase = ref.watch(deleteContactUsecaseProvider);
    return const ContactMutationState();
  }

  Future<void> createContact(CreateContactParams params) async {
    AppLogger.uiInfo('Creating contact in notifier');
    state = state.copyWith(status: ContactMutationStatus.loading);

    final response = await _createContactUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to create contact', failure);
        state = state.copyWith(
          status: ContactMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiDebug('Contact created successfully in notifier');
        state = state
            .copyWith(
              status: ContactMutationStatus.success,
              createdContact: success.data,
              successMessage: success.message ?? 'Contact created successfully',
            )
            .copyWithClearError();
        ref.invalidate(contactGetNotifierProvider);
      },
    );
  }

  Future<void> updateContact(UpdateContactParams params) async {
    AppLogger.uiInfo('Updating contact in notifier');
    state = state.copyWith(status: ContactMutationStatus.loading);

    final response = await _updateContactUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to update contact', failure);
        state = state.copyWith(
          status: ContactMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiDebug('Contact updated successfully in notifier');
        state = state
            .copyWith(
              status: ContactMutationStatus.success,
              updatedContact: success.data,
              successMessage: success.message ?? 'Contact updated successfully',
            )
            .copyWithClearError();
        ref.invalidate(contactGetNotifierProvider);
      },
    );
  }

  Future<void> deleteContact(DeleteContactParams params) async {
    AppLogger.uiInfo('Deleting contact in notifier');
    state = state.copyWith(status: ContactMutationStatus.loading);

    final response = await _deleteContactUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to delete contact', failure);
        state = state.copyWith(
          status: ContactMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiDebug('Contact deleted successfully in notifier');
        state = state
            .copyWith(
              status: ContactMutationStatus.success,
              successMessage: success.message ?? 'Contact deleted successfully',
            )
            .copyWithClearError();
        ref.invalidate(contactGetNotifierProvider);
      },
    );
  }

  void clearState() {
    state = const ContactMutationState();
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
