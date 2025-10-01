import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/menu/domain/usecases/bulk_delete_menus_usecase.dart';
import 'package:tires/features/menu/domain/usecases/create_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/delete_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_admin_menus_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_menus_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/update_menu_usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/entities/menu_statistic.dart';

abstract class MenuRepository {
  Future<Either<Failure, ItemSuccessResponse<Menu>>> createMenu(
    CreateMenuParams params,
  );
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> getMenusCursor(
    GetMenusCursorParams params,
  );
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> getAdminMenusCursor(
    GetAdminMenusCursorParams params,
  );
  Future<Either<Failure, ItemSuccessResponse<Menu>>> updateMenu(
    UpdateMenuParams params,
  );
  Future<Either<Failure, ActionSuccess>> deleteMenu(DeleteMenuParams params);
  Future<Either<Failure, ActionSuccess>> bulkDeleteMenus(
    BulkDeleteMenusUsecaseParams params,
  );
  Future<Either<Failure, ItemSuccessResponse<MenuStatistic>>>
  getMenuStatistics();
}
