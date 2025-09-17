import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/domain/repositories/current_user_repository.dart';

class GetCurrentUserUsecase
    implements Usecase<ItemSuccessResponse<User>, GetCurrentUserParams> {
  final CurrentUserRepository _userRepository;

  GetCurrentUserUsecase(this._userRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<User>>> call(
    GetCurrentUserParams params,
  ) async {
    AppLogger.businessInfo('Executing get current user usecase');
    final result = await _userRepository.getCurrentUser();
    result.fold(
      (failure) =>
          AppLogger.businessError('Get current user usecase failed', failure),
      (success) => AppLogger.businessInfo(
        'Get current user usecase completed successfully',
      ),
    );
    return result;
  }
}

class GetCurrentUserParams extends Equatable {
  const GetCurrentUserParams();

  @override
  List<Object?> get props => [];
}
