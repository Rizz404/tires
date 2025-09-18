import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';

enum ContactsStatus { initial, loading, success, error, loadingMore }

class ContactsState extends Equatable {
  final ContactsStatus status;
  final List<Contact> contacts;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const ContactsState({
    this.status = ContactsStatus.initial,
    this.contacts = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  ContactsState copyWith({
    ContactsStatus? status,
    List<Contact>? contacts,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return ContactsState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  ContactsState copyWithClearError() {
    return ContactsState(
      status: status,
      contacts: contacts,
      cursor: cursor,
      errorMessage: null,
      hasNextPage: hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    contacts,
    cursor,
    errorMessage,
    hasNextPage,
  ];
}
