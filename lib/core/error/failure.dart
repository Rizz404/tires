import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});

  @override
  List<Object?> get props => [message, code];
}

class ValidationFailure extends Failure {
  final List<DomainValidationError>? errors;

  @override
  List<Object?> get props => [message, code, errors];

  ValidationFailure({required super.message, super.code, this.errors});
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => [message, code];

  const NetworkFailure({required super.message, super.code});
}

class DomainValidationError {
  final String field;
  final String tag;
  final String value;
  final String message;

  const DomainValidationError({
    required this.field,
    required this.tag,
    required this.value,
    required this.message,
  });
}
