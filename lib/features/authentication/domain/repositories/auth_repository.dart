import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/authentication/domain/entities/auth.dart';
import 'package:tires/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/set_new_password_usecase.dart';

// * Return Type Sukses (Right): Se-spesifik mungkin (gunakan subclass).
// * Return Type Gagal (Left): Se-umum mungkin (gunakan abstract class).
abstract class AuthRepository {
  Future<Either<Failure, ItemSuccessResponse<Auth>>> register(
    RegisterParams params,
  );
  Future<Either<Failure, ItemSuccessResponse<Auth>>> login(LoginParams params);
  Future<Either<Failure, ActionSuccess>> forgotPassword(
    ForgotPasswordParams params,
  );
  Future<Either<Failure, ActionSuccess>> setNewPassword(
    SetNewPasswordParams params,
  );
  Future<Either<Failure, ActionSuccess>> logout();
  Future<Either<Failure, ItemSuccessResponse<Auth?>>> getCurrentAuth();
}
