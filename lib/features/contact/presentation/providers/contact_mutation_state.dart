import 'package:equatable/equatable.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';

enum ContactMutationStatus { initial, loading, success, error }

class ContactMutationState extends Equatable {
  final ContactMutationStatus status;
  final Contact? createdContact;
  final Contact? updatedContact;
  final Failure? failure;
  final String? successMessage;

  const ContactMutationState({
    this.status = ContactMutationStatus.initial,
    this.createdContact,
    this.updatedContact,
    this.failure,
    this.successMessage,
  });

  ContactMutationState copyWith({
    ContactMutationStatus? status,
    Contact? createdContact,
    Contact? updatedContact,
    Failure? failure,
    String? successMessage,
  }) {
    return ContactMutationState(
      status: status ?? this.status,
      updatedContact: updatedContact ?? this.updatedContact,
      createdContact: createdContact ?? this.createdContact,
      failure: failure ?? this.failure,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  ContactMutationState copyWithClearError() {
    return ContactMutationState(
      status: status,
      updatedContact: updatedContact,
      createdContact: createdContact,
      failure: null,
      successMessage: successMessage,
    );
  }

  ContactMutationState copyWithClearSuccess() {
    return ContactMutationState(
      status: status,
      updatedContact: updatedContact,
      createdContact: createdContact,
      failure: failure,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    updatedContact,
    createdContact,
    failure,
    successMessage,
  ];
}
