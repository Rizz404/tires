import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/user/domain/repositories/current_user_repository.dart';

class UpdateCurrentUserPasswordUsecase
    implements Usecase<ActionSuccess, UpdateUserPasswordParams> {
  final CurrentUserRepository _userRepository;

  UpdateCurrentUserPasswordUsecase(this._userRepository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    UpdateUserPasswordParams params,
  ) async {
    return await _userRepository.updateCurrentUserPassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
      confirmPassword: params.confirmPassword,
    );
  }
}

class UpdateUserPasswordParams extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const UpdateUserPasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];
}
