import 'package:fpdart/fpdart.dart';
import 'package:tires/core/error/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
