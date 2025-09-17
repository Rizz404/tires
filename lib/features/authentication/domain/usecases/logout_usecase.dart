import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';

class LogoutUsecase implements Usecase<ActionSuccess, NoParams> {
  final AuthRepository _authRepository;

  LogoutUsecase(this._authRepository);

  @override
  Future<Either<Failure, ActionSuccess>> call(NoParams params) async {
    AppLogger.businessInfo('Executing logout usecase');
    return await _authRepository.logout();
  }
}
