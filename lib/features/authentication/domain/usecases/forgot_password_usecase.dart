import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';

class ForgotPasswordUsecase
    implements Usecase<ActionSuccess, ForgotPasswordParams> {
  final AuthRepository _authRepository;

  ForgotPasswordUsecase(this._authRepository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    ForgotPasswordParams params,
  ) async {
    return await _authRepository.forgotPassword(params);
  }
}

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({required this.email});

  @override
  List<Object> get props => [email];
}
