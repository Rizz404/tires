import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/user/data/datasources/users_remote_datasource.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/domain/repositories/users_repository.dart';
import 'package:tires/features/user/domain/usecases/get_users_cursor_usecase.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDatasource _datasource;

  UsersRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<User>>> getUsersCursor(
    GetUsersCursorParams params,
  ) async {
    try {
      AppLogger.businessInfo('Fetching users cursor in repository');
      final result = await _datasource.getUsersCursor(params);

      AppLogger.businessDebug(
        'Users cursor fetched successfully in repository',
      );
      return Right(
        CursorPaginatedSuccess<User>(
          data: result.data.map((userModel) => userModel.toEntity()).toList(),
          cursor: result.cursor?.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get users cursor', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in get users cursor', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
