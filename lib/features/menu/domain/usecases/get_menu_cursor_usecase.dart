import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class GetMenuCursorUsecase
    implements Usecase<CursorPaginatedSuccess<Menu>, GetMenuCursorParams> {
  final MenuRepository _menuRepository;

  GetMenuCursorUsecase(this._menuRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> call(
    GetMenuCursorParams params,
  ) async {
    return await _menuRepository.getMenuCursor(cursor: params.cursor);
  }
}

class GetMenuCursorParams extends Equatable {
  final String? cursor;

  const GetMenuCursorParams({this.cursor});

  @override
  List<Object?> get props => [cursor];
}
