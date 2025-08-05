import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';

extension FailureValidationMapper on DomainValidationError {
  ValidationError toModel() {
    return ValidationError(
      field: field,
      tag: tag,
      value: value,
      message: message,
    );
  }
}

extension NetworkValidationMapper on ValidationError {
  DomainValidationError toEntity() {
    return DomainValidationError(
      field: field,
      tag: tag,
      value: value,
      message: message,
    );
  }
}
