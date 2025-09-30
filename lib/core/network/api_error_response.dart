import 'dart:convert';

import 'package:equatable/equatable.dart';

class ApiErrorResponse extends Equatable {
  final String message;
  final List<ValidationError>? errors;

  const ApiErrorResponse({required this.message, this.errors});

  ApiErrorResponse copyWith({String? message, List<ValidationError>? errors}) {
    return ApiErrorResponse(
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'errors': errors?.map((x) => x.toMap()).toList(),
    };
  }

  factory ApiErrorResponse.fromMap(Map<String, dynamic> map) {
    return ApiErrorResponse(
      message: map['message'] is String
          ? map['message']
          : (map['message']?.toString() ?? 'Unknown errors'),
      errors: map['errors'] != null && map['errors'] is Map
          ? (map['errors'] as Map<String, dynamic>).entries
                .map(
                  (entry) => ValidationError(
                    field: entry.key,
                    messages: entry.value is List
                        ? List<String>.from(
                            entry.value.map((msg) => msg?.toString() ?? ''),
                          )
                        : [entry.value?.toString() ?? ''],
                  ),
                )
                .toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiErrorResponse.fromJson(String source) =>
      ApiErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Check if this response has validation errors
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
      orElse: () => const ValidationError(field: '', messages: []),
    );

    return fieldError.field.isNotEmpty ? fieldError.firstMessage : null;
  }

  @override
  String toString() => 'ApiErrorResponse(message: $message, errors: $errors)';

  @override
  List<Object?> get props => [message, errors];
}

class ValidationError extends Equatable {
  final String field;
  final List<String> messages;

  const ValidationError({required this.field, required this.messages});

  ValidationError copyWith({String? field, List<String>? messages}) {
    return ValidationError(
      field: field ?? this.field,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'field': field, 'messages': messages};
  }

  String toJson() => json.encode(toMap());

  /// Get the first message for this field
  String get firstMessage => messages.isNotEmpty ? messages.first : '';

  /// Get all messages joined with newlines
  String get allMessages => messages.join('\n');

  @override
  String toString() {
    return 'ValidationError(field: $field, messages: $messages)';
  }

  @override
  List<Object> get props => [field, messages];
}
