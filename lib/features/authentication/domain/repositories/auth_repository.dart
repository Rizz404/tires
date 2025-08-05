import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/user/domain/entities/user.dart';

// * Return Type Sukses (Right): Se-spesifik mungkin (gunakan subclass).
// * Return Type Gagal (Left): Se-umum mungkin (gunakan abstract class).
abstract class AuthRepository {
  Future<Either<Failure, ItemSuccessResponse<User>>> register(
    RegisterParams params,
  );
  Future<Either<Failure, ItemSuccessResponse<User>>> login(LoginParams params);
  Future<Either<Failure, ActionSuccess>> logout();
}
