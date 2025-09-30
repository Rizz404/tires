import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';

class SetNewPasswordUsecase
    implements Usecase<ActionSuccess, SetNewPasswordParams> {
  final AuthRepository _authRepository;

  SetNewPasswordUsecase(this._authRepository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    SetNewPasswordParams params,
  ) async {
    AppLogger.businessInfo('Executing set new password usecase');
    return await _authRepository.setNewPassword(params);
  }
}

class SetNewPasswordParams extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  const SetNewPasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword, confirmNewPassword];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmNewPassword,
    };
  }

  String toJson() => json.encode(toMap());
}
