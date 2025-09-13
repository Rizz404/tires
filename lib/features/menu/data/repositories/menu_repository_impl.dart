import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/features/menu/data/datasources/menu_remote_datasource.dart';
import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';
import 'package:tires/features/menu/domain/usecases/get_menu_cursor_usecase.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDatasource _menuRemoteDatasource;

  MenuRepositoryImpl(this._menuRemoteDatasource);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> getMenuCursor(
    GetMenuCursorParams params,
  ) async {
    try {
      final result = await _menuRemoteDatasource.getMenuCursor(params);

      return Right(
        CursorPaginatedSuccess<Menu>(
          data: result.data.map((menu) => menu.toEntity()).toList(),
          cursor: result.cursor?.toEntity(),
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
