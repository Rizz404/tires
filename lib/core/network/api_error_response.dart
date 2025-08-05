import 'dart:convert';

import 'package:equatable/equatable.dart';

// Todo: Nanti jadiin plural, masa error doang bukan errors padahal array
class ApiErrorResponse extends Equatable {
  final String message;
  final int? code;
  final List<ValidationError>? error;

  const ApiErrorResponse({required this.message, this.code, this.error});

  ApiErrorResponse copyWith({
    String? message,
    int? code,
    List<ValidationError>? error,
  }) {
    return ApiErrorResponse(
      message: message ?? this.message,
      code: code ?? this.code,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'error': error?.map((x) => x.toMap()).toList(),
    };
  }

  factory ApiErrorResponse.fromMap(Map<String, dynamic> map) {
    return ApiErrorResponse(
      message: map['message'] as String,
      code: map['code'] != null ? map['code'] as int : null,
      error: map['error'] != null
          ? List<ValidationError>.from(
              (map['error'] as List<int>).map<ValidationError?>(
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
  String toString() =>
      'ApiErrorResponse(message: $message, code: $code, error: $error)';

  @override
  List<Object> get props => [message, ?code, ?error];
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
      field: map['field'] as String,
      tag: map['tag'] as String,
      value: map['value'] as String,
      message: map['message'] as String,
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
