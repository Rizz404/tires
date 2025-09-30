import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_usecase.dart';
import 'package:tires/features/user/domain/usecases/update_current_user_password_usecase.dart';

abstract class CurrentUserRepository {
  Future<Either<Failure, ItemSuccessResponse<User>>> getCurrentUser();
  Future<Either<Failure, ItemSuccessResponse<User>>> updateCurrentUser(
    UpdateUserParams params,
  );
  Future<Either<Failure, ActionSuccess>> updateCurrentUserPassword(
    UpdateUserPasswordParams params,
  );
  Future<Either<Failure, ActionSuccess>> deleteCurrentUserAccount();
}
