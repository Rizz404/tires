import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/features/menu/data/datasources/menu_remote_datasource.dart';
import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDatasource _menuRemoteDatasource;

  MenuRepositoryImpl(this._menuRemoteDatasource);

  @override
  Future<Either<Failure, List<Menu>>> getMenus() async {
    try {
      final result = await _menuRemoteDatasource.getMenus();

      return Right(result.map((menu) => menu.toEntity()).toList());
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
