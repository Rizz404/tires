import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
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
    return await _userRepository.deleteCurrentUserAccount();
  }
}

class DeleteUserAccountParams extends Equatable {
  const DeleteUserAccountParams();

  @override
  List<Object?> get props => [];
}
