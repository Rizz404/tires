import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/storage/session_storage_service.dart';
import 'package:tires/features/user/data/datasources/current_user_remote_datasource.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/domain/repositories/current_user_repository.dart';

class CurrentUserRepositoryImpl implements CurrentUserRepository {
  final CurrentUserRemoteDatasource _userRemoteDatasource;
  final SessionStorageService _sessionStorageService;

  CurrentUserRepositoryImpl(
    this._userRemoteDatasource,
    this._sessionStorageService,
  );

  @override
  Future<Either<Failure, ItemSuccessResponse<User>>> getCurrentUser() async {
    try {
      // First check if user exists in local storage
      final cachedUser = await _sessionStorageService.getUser();
      if (cachedUser != null) {
        return Right(
          ItemSuccessResponse(
            data: cachedUser,
            message: 'User retrieved from cache',
          ),
        );
      }

      // If not cached, fetch from remote
      final result = await _userRemoteDatasource.getCurrentUser();

      final user = result.data.toEntity();
      // Cache the user data for future use
      await _sessionStorageService.saveUser(user);
      return Right(ItemSuccessResponse(data: user, message: result.message));
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<User>>> updateCurrentUser({
    required String fullName,
    required String fullNameKana,
    required String email,
    required String phoneNumber,
    String? companyName,
    String? department,
    String? companyAddress,
    String? homeAddress,
    DateTime? dateOfBirth,
    String? gender,
  }) async {
    try {
      final result = await _userRemoteDatasource.updateCurrentUser(
        fullName: fullName,
        fullNameKana: fullNameKana,
        email: email,
        phoneNumber: phoneNumber,
        companyName: companyName,
        department: department,
        companyAddress: companyAddress,
        homeAddress: homeAddress,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      final updatedUser = result.data.toEntity();
      // Update the cached user data with the new information
      await _sessionStorageService.saveUser(updatedUser);
      return Right(
        ItemSuccessResponse(data: updatedUser, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> updateCurrentUserPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final result = await _userRemoteDatasource.updateCurrentUserPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> deleteCurrentUserAccount() async {
    try {
      final result = await _userRemoteDatasource.deleteCurrentUserAccount();

      // Clear all user data from local storage when account is deleted
      await _sessionStorageService.deleteUser();
      await _sessionStorageService.deleteAccessToken();
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
