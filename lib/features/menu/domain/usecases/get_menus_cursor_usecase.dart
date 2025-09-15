import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class GetMenusCursorUsecase
    implements Usecase<CursorPaginatedSuccess<Menu>, GetMenusCursorParams> {
  final MenuRepository _menuRepository;

  GetMenusCursorUsecase(this._menuRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> call(
    GetMenusCursorParams params,
  ) async {
    return await _menuRepository.getMenusCursor(params);
  }
}

class GetMenusCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  const GetMenusCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  @override
  List<Object?> get props => [paginate, perPage, cursor];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate.toString(),
      'per_page': perPage.toString(),
      if (cursor != null) 'cursor': cursor,
    };
  }

  String toJson() => json.encode(toMap());
}
