import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/usecases/get_menu_cursor_usecase.dart';

abstract class MenuRepository {
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> getMenuCursor(
    GetMenuCursorParams params,
  );
}
