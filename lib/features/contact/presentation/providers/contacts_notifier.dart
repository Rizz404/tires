import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/contact/domain/usecases/get_contacts_cursor_usecase.dart';
import 'package:tires/features/contact/presentation/providers/contacts_state.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';

class ContactsNotifier extends Notifier<ContactsState> {
  late GetContactsCursorUsecase _getContactsCursorUsecase;

  @override
  ContactsState build() {
    _getContactsCursorUsecase = ref.watch(getContactsCursorUsecaseProvider);
    Future.microtask(() => getInitialContacts());
    return const ContactsState();
  }

  Future<void> getInitialContacts({
    bool paginate = true,
    int perPage = 10,
    String? search,
    String? status,
  }) async {
    if (state.status == ContactsStatus.loading) return;

    AppLogger.uiInfo('Fetching initial contacts in notifier');

    state = state.copyWith(status: ContactsStatus.loading);

    final params = GetContactsCursorParams(
      paginate: paginate,
      perPage: perPage,
      search: search,
      status: status,
    );

    final response = await _getContactsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to fetch initial contacts', failure);
        state = state.copyWith(
          status: ContactsStatus.error,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('Initial contacts fetched successfully in notifier');
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

  Future<void> getContacts({
    bool paginate = true,
    int perPage = 10,
    String? search,
    String? status,
  }) async {
    await getInitialContacts(
      paginate: paginate,
      perPage: perPage,
      search: search,
      status: status,
    );
  }

  Future<void> loadMore({
    bool paginate = true,
    int perPage = 10,
    String? search,
    String? status,
  }) async {
    if (!state.hasNextPage || state.status == ContactsStatus.loadingMore) {
      return;
    }

    AppLogger.uiInfo('Loading more contacts in notifier');
    state = state.copyWith(status: ContactsStatus.loadingMore);

    final params = GetContactsCursorParams(
      paginate: paginate,
      perPage: perPage,
      cursor: state.cursor?.nextCursor,
      search: search,
      status: status,
    );

    final response = await _getContactsCursorUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to load more contacts', failure);
        state = state.copyWith(
          status: ContactsStatus.success,
          errorMessage: failure.message,
        );
      },
      (success) {
        AppLogger.uiDebug('More contacts loaded successfully in notifier');
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

  Future<void> refresh({
    bool paginate = true,
    int perPage = 10,
    String? search,
    String? status,
  }) async {
    await getInitialContacts(
      paginate: paginate,
      perPage: perPage,
      search: search,
      status: status,
    );
  }

  void clearState() {
    state = const ContactsState();
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWithClearError();
    }
  }
}
