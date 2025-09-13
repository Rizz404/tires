// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
    return await _menuRepository.getMenuCursor(params);
  }
}

class GetMenuCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  const GetMenuCursorParams({
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
