import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/user/domain/entities/user.dart';

abstract class CurrentUserRepository {
  Future<Either<Failure, ItemSuccessResponse<User>>> getCurrentUser();
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
  });
  Future<Either<Failure, ActionSuccess>> updateCurrentUserPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<Either<Failure, ActionSuccess>> deleteCurrentUserAccount();
}
