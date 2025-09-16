import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/features/menu/data/datasources/menu_remote_datasource.dart';
import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';
import 'package:tires/features/menu/domain/usecases/create_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/delete_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_admin_menus_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_menus_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/update_menu_usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/entities/menu_statistic.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDatasource _menuRemoteDatasource;

  MenuRepositoryImpl(this._menuRemoteDatasource);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> getMenusCursor(
    GetMenusCursorParams params,
  ) async {
    try {
      final result = await _menuRemoteDatasource.getMenusCursor(params);

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

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> getAdminMenusCursor(
    GetAdminMenusCursorParams params,
  ) async {
    try {
      final result = await _menuRemoteDatasource.getAdminMenusCursor(params);
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

  @override
  Future<Either<Failure, ItemSuccessResponse<Menu>>> createMenu(
    CreateMenuParams params,
  ) async {
    try {
      final result = await _menuRemoteDatasource.createMenu(params);

      return Right(
        ItemSuccessResponse<Menu>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Menu>>> updateMenu(
    UpdateMenuParams params,
  ) async {
    try {
      final result = await _menuRemoteDatasource.updateMenu(params);

      return Right(
        ItemSuccessResponse<Menu>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> deleteMenu(
    DeleteMenuParams params,
  ) async {
    try {
      final result = await _menuRemoteDatasource.deleteMenu(params);

      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<MenuStatistic>>>
  getMenuStatistics() async {
    try {
      final result = await _menuRemoteDatasource.getMenuStatistics();

      return Right(
        ItemSuccessResponse<MenuStatistic>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
