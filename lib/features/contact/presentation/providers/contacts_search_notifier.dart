import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/contact/domain/usecases/get_contacts_cursor_usecase.dart';
import 'package:tires/features/contact/presentation/providers/contacts_state.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';

class ContactsSearchNotifier extends Notifier<ContactsState> {
  late GetContactsCursorUsecase _getContactsCursorUsecase;

  @override
  ContactsState build() {
    _getContactsCursorUsecase = ref.watch(getContactsCursorUsecaseProvider);
    return const ContactsState();
  }

  Future<void> searchContacts({
    required String search,
    String? status,
    int perPage = 10,
  }) async {
    if (state.status == ContactsStatus.loading) return;

    AppLogger.uiInfo('Searching contacts in notifier');
    state = state.copyWith(status: ContactsStatus.loading);

    final params = GetContactsCursorParams(
      paginate: true,
      perPage: perPage,
      search: search,
      status: status,
    );

    final response = await _getContactsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to search contacts', failure);
        state = state.copyWith(
          status: ContactsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Contacts searched successfully in notifier');
        state = state
            .copyWith(
              status: ContactsStatus.success,
              contacts: success.data ?? [],
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  Future<void> loadMoreSearchResults({
    required String search,
    String? status,
    int perPage = 10,
  }) async {
    if (!state.hasNextPage || state.status == ContactsStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more search results in notifier');
    state = state.copyWith(status: ContactsStatus.loadingMore);

    final params = GetContactsCursorParams(
      paginate: true,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
      search: search,
      status: status,
    );

    final response = await _getContactsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more search results', failure);
        state = state.copyWith(
          status: ContactsStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug(
          'More search results loaded successfully in notifier',
        );
        final List<Contact> alls = [
          ...state.contacts,
          ...success.data ?? <Contact>[],
        ];
        state = state
            .copyWith(
              status: ContactsStatus.success,
              contacts: alls,
              cursor: success.cursor,
              hasNextPage: success.cursor?.hasNextPage ?? false,
            )
            .copyWithClearError();
      },
    );
  }

  void clearSearch() {
    AppLogger.uiInfo('Clearing search results');
    state = const ContactsState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
