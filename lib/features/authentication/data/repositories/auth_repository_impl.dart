import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/network/validation_error_mapper.dart';
import 'package:tires/core/services/provider_invalidation_service.dart';
import 'package:tires/core/storage/session_storage_service.dart';
import 'package:tires/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:tires/features/authentication/data/mapper/auth_mapper.dart';
import 'package:tires/features/authentication/domain/entities/auth.dart';
import 'package:tires/features/authentication/domain/repositories/auth_repository.dart';
import 'package:tires/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/set_new_password_usecase.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;
  final SessionStorageService _sessionStorageService;
  final ProviderInvalidationService _providerInvalidationService;

  AuthRepositoryImpl(
    this._authRemoteDatasource,
    this._sessionStorageService,
    this._providerInvalidationService,
  );

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
      if (e.errors != null) {
        return Left(
          ValidationFailure(
            message: e.message,
            errors: e.errors?.map((err) => err.toEntity()).toList(),
          ),
        );
      }
      return Left(ServerFailure(message: e.message));
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
      if (e.errors != null) {
        return Left(
          ValidationFailure(
            message: e.message,
            errors: e.errors?.map((err) => err.toEntity()).toList(),
          ),
        );
      }
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> forgotPassword(
    ForgotPasswordParams params,
  ) async {
    try {
      final apiResponse = await _authRemoteDatasource.forgotPassword(
        ForgotPasswordPayload(email: params.email),
      );
      return Right(ActionSuccess(message: apiResponse.message));
    } on ApiErrorResponse catch (e) {
      if (e.errors != null) {
        return Left(
          ValidationFailure(
            message: e.message,
            errors: e.errors?.map((err) => err.toEntity()).toList(),
          ),
        );
      }
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> setNewPassword(
    SetNewPasswordParams params,
  ) async {
    try {
      final apiResponse = await _authRemoteDatasource.setNewPassword(
        SetNewPasswordPayload(
          newPassword: params.newPassword,
          confirmNewPassword: params.confirmNewPassword,
        ),
      );
      return Right(ActionSuccess(message: apiResponse.message));
    } on ApiErrorResponse catch (e) {
      if (e.errors != null) {
        return Left(
          ValidationFailure(
            message: e.message,
            errors: e.errors?.map((err) => err.toEntity()).toList(),
          ),
        );
      }
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> logout() async {
    try {
      final apiResponse = await _authRemoteDatasource.logout();

      await _sessionStorageService.deleteAccessToken();
      await _sessionStorageService.deleteUser();

      // Invalidate all user-related providers to ensure fresh data on next login
      _providerInvalidationService.invalidateUserRelatedProviders();

      return Right(ActionSuccess(message: apiResponse.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Auth?>>> getCurrentAuth() async {
    try {
      final token = await _sessionStorageService.getAccessToken();
      final user = await _sessionStorageService.getUser();

      if (user != null && token != null) {
        return Right(
          ItemSuccessResponse(
            data: Auth(user: user, token: token),
          ),
        );
      }
      return Right(ItemSuccessResponse(data: null));
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
