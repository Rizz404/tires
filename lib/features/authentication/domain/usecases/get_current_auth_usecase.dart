import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/entities/auth.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';

class GetCurrentAuthUsecase
    implements Usecase<ItemSuccessResponse<Auth?>, NoParams> {
  final AuthRepository _authRepository;

  GetCurrentAuthUsecase(this._authRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Auth?>>> call(
    NoParams params,
  ) async {
    AppLogger.businessInfo('Executing get current auth usecase');
    return await _authRepository.getCurrentAuth();
  }
}
