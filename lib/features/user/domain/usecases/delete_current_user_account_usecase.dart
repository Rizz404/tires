import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/user/domain/repositories/current_user_repository.dart';

class DeleteCurrentUserAccountUsecase
    implements Usecase<ActionSuccess, DeleteUserAccountParams> {
  final CurrentUserRepository _userRepository;

  DeleteCurrentUserAccountUsecase(this._userRepository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    DeleteUserAccountParams params,
  ) async {
    AppLogger.businessInfo('Executing delete current user account usecase');
    final result = await _userRepository.deleteCurrentUserAccount();
    result.fold(
      (failure) => AppLogger.businessError(
        'Delete current user account usecase failed',
        failure,
      ),
      (success) => AppLogger.businessInfo(
        'Delete current user account usecase completed successfully',
      ),
    );
    return result;
  }
}

class DeleteUserAccountParams extends Equatable {
  const DeleteUserAccountParams();

  @override
  List<Object?> get props => [];
}
