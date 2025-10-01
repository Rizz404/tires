import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/menu/data/datasources/menu_remote_datasource.dart';
import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';
import 'package:tires/features/menu/domain/usecases/bulk_delete_menus_usecase.dart';
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
      AppLogger.businessInfo('Fetching menus cursor in repository');
      final result = await _menuRemoteDatasource.getMenusCursor(params);
      AppLogger.businessDebug(
        'Menus cursor fetched successfully in repository',
      );
      return Right(
        CursorPaginatedSuccess<Menu>(
          data: result.data.map((menu) => menu.toEntity()).toList(),
          cursor: result.cursor?.toEntity(),
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get menus cursor', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in get menus cursor', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> getAdminMenusCursor(
    GetAdminMenusCursorParams params,
  ) async {
    try {
      AppLogger.businessInfo('Fetching admin menus cursor in repository');
      final result = await _menuRemoteDatasource.getAdminMenusCursor(params);
      AppLogger.businessDebug(
        'Admin menus cursor fetched successfully in repository',
      );
      return Right(
        CursorPaginatedSuccess<Menu>(
          data: result.data.map((menu) => menu.toEntity()).toList(),
          cursor: result.cursor?.toEntity(),
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get admin menus cursor', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in get admin menus cursor', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Menu>>> createMenu(
    CreateMenuParams params,
  ) async {
    try {
      AppLogger.businessInfo('Creating menu in repository');
      final result = await _menuRemoteDatasource.createMenu(params);
      AppLogger.businessDebug('Menu created successfully in repository');
      return Right(
        ItemSuccessResponse<Menu>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in create menu', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in create menu', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Menu>>> updateMenu(
    UpdateMenuParams params,
  ) async {
    try {
      AppLogger.businessInfo('Updating menu in repository');
      final result = await _menuRemoteDatasource.updateMenu(params);
      AppLogger.businessDebug('Menu updated successfully in repository');
      return Right(
        ItemSuccessResponse<Menu>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in update menu', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in update menu', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> deleteMenu(
    DeleteMenuParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting menu in repository');
      final result = await _menuRemoteDatasource.deleteMenu(params);
      AppLogger.businessDebug('Menu deleted successfully in repository');
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete menu', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete menu', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> bulkDeleteMenus(
    BulkDeleteMenusUsecaseParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting menu in repository');
      final result = await _menuRemoteDatasource.bulkDeleteMenus(params);
      AppLogger.businessDebug('Menu deleted successfully in repository');
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete menu', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete menu', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<MenuStatistic>>>
  getMenuStatistics() async {
    try {
      AppLogger.businessInfo('Fetching menu statistics in repository');
      final result = await _menuRemoteDatasource.getMenuStatistics();
      AppLogger.businessDebug(
        'Menu statistics fetched successfully in repository',
      );
      return Right(
        ItemSuccessResponse<MenuStatistic>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get menu statistics', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in get menu statistics', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
