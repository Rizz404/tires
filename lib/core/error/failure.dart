import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  final List<DomainValidationError>? errors;

  @override
  List<Object?> get props => [message, errors];

  ValidationFailure({required super.message, this.errors});

  /// Check if this failure has validation errors
  bool get hasValidationErrors => errors != null && errors!.isNotEmpty;

  /// Get all error messages combined
  String get allErrorMessages {
    if (!hasValidationErrors) return message;

    final validationMessages = errors!
        .map((error) => '${error.field}: ${error.allMessages}')
        .join('\n');

    return '$message\n$validationMessages';
  }

  /// Get error message for a specific field
  String? getErrorForField(String fieldName) {
    if (!hasValidationErrors) return null;

    final fieldError = errors!.firstWhere(
      (error) => error.field == fieldName,
      orElse: () => const DomainValidationError(field: '', messages: []),
    );

    return fieldError.field.isNotEmpty ? fieldError.firstMessage : null;
  }
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => [message];

  const NetworkFailure({required super.message});
}

class DomainValidationError {
  final String field;
  final List<String> messages;

  const DomainValidationError({required this.field, required this.messages});

  /// Get the first message for this field
  String get firstMessage => messages.isNotEmpty ? messages.first : '';

  /// Get all messages joined with newlines
  String get allMessages => messages.join('\n');
}
