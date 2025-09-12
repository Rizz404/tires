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
      errors: map['errors'] != null
          ? List<ValidationError>.from(
              (map['errors'] as List).map<ValidationError?>(
                (x) => ValidationError.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiErrorResponse.fromJson(String source) =>
      ApiErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApiErrorResponse(message: $message, errors: $errors)';

  @override
  List<Object> get props => [message, ?errors];
}

class ValidationError extends Equatable {
  final String field;
  final String tag;
  final String value;
  final String message;

  const ValidationError({
    required this.field,
    required this.tag,
    required this.value,
    required this.message,
  });

  ValidationError copyWith({
    String? field,
    String? tag,
    String? value,
    String? message,
  }) {
    return ValidationError(
      field: field ?? this.field,
      tag: tag ?? this.tag,
      value: value ?? this.value,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'field': field,
      'tag': tag,
      'value': value,
      'message': message,
    };
  }

  factory ValidationError.fromMap(Map<String, dynamic> map) {
    return ValidationError(
      field: map['field'] is String
          ? map['field']
          : (map['field']?.toString() ?? ''),
      tag: map['tag'] is String ? map['tag'] : (map['tag']?.toString() ?? ''),
      value: map['value'] is String
          ? map['value']
          : (map['value']?.toString() ?? ''),
      message: map['message'] is String
          ? map['message']
          : (map['message']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidationError.fromJson(String source) =>
      ValidationError.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ValidationError(field: $field, tag: $tag, value: $value, message: $message)';
  }

  @override
  List<Object> get props => [field, tag, value, message];
}
