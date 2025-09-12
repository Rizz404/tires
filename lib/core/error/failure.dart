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
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => [message];

  const NetworkFailure({required super.message});
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
