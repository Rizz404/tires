import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/network/validation_error_mapper.dart';
import 'package:tires/core/storage/session_storage_service.dart';
import 'package:tires/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:tires/features/authentication/data/mapper/auth_mapper.dart';
import 'package:tires/features/authentication/domain/entities/auth.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;
  final SessionStorageService _sessionStorageService;

  AuthRepositoryImpl(this._authRemoteDatasource, this._sessionStorageService);

  @override
  Future<Either<Failure, ItemSuccessResponse<Auth>>> register(
    RegisterParams params,
  ) async {
    try {
      final apiResponse = await _authRemoteDatasource.register(
        RegisterPayload(
          username: params.fullName,
          email: params.email,
          password: params.password,
        ),
      );
      return Right(ItemSuccessResponse(data: apiResponse.data.toEntity()));
    } on ApiErrorResponse catch (e) {
      if (e.code == 422 || e.error != null) {
        return Left(
          ValidationFailure(
            message: e.message,
            code: e.code,
            errors: e.error?.map((err) => err.toEntity()).toList(),
          ),
        );
      }
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Auth>>> login(
    LoginParams params,
  ) async {
    try {
      final apiResponse = await _authRemoteDatasource.login(
        LoginPayload(email: params.email, password: params.password),
      );

      await _sessionStorageService.saveAccessToken(apiResponse.data.token);
      await _sessionStorageService.saveUser(apiResponse.data.user);

      return Right(ItemSuccessResponse(data: apiResponse.data.toEntity()));
    } on ApiErrorResponse catch (e) {
      if (e.code == 422 || e.error != null) {
        return Left(
          ValidationFailure(
            message: e.message,
            code: e.code,
            errors: e.error?.map((err) => err.toEntity()).toList(),
          ),
        );
      }
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> logout() async {
    try {
      await _sessionStorageService.deleteAccessToken();
      await _sessionStorageService.deleteUser();

      return Right(ActionSuccess(message: "Logout successfully"));
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
