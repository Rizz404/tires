import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class GetMenusUsecase
    implements Usecase<CursorPaginatedSuccess<Menu>, GetMenusParams> {
  final MenuRepository _menuRepository;

  GetMenusUsecase(this._menuRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> call(
    GetMenusParams params,
  ) async {
    return await _menuRepository.getMenuCursor(cursor: params.cursor);
  }
}

class GetMenusParams extends Equatable {
  final String? cursor;

  const GetMenusParams({this.cursor});

  @override
  List<Object?> get props => [cursor];
}
