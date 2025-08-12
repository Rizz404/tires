import 'package:fpdart/fpdart.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<Menu>>> getMenus();
}
