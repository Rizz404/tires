import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/domain/usecases/get_users_cursor_usecase.dart';

abstract class UsersRepository {
  Future<Either<Failure, CursorPaginatedSuccess<User>>> getUsersCursor(
    GetUsersCursorParams params,
  );
}
