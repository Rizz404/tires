import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class GetAdminMenusCursorUsecase
    implements
        Usecase<CursorPaginatedSuccess<Menu>, GetAdminMenusCursorParams> {
  final MenuRepository _menuRepository;

  GetAdminMenusCursorUsecase(this._menuRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Menu>>> call(
    GetAdminMenusCursorParams params,
  ) async {
    AppLogger.businessInfo('Executing get admin menus cursor usecase');
    return await _menuRepository.getAdminMenusCursor(params);
  }
}

class GetAdminMenusCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;
  final String? search;
  final String? status;
  final double? minPrice;
  final double? maxPrice;

  const GetAdminMenusCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
    this.search,
    this.status,
    this.minPrice,
    this.maxPrice,
  });

  GetAdminMenusCursorParams copyWith({
    bool? paginate,
    int? perPage,
    String? cursor,
    String? search,
    String? status,
    double? minPrice,
    double? maxPrice,
  }) {
    return GetAdminMenusCursorParams(
      paginate: paginate ?? this.paginate,
      perPage: perPage ?? this.perPage,
      cursor: cursor ?? this.cursor,
      search: search ?? this.search,
      status: status ?? this.status,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [
    paginate,
    perPage,
    cursor,
    search,
    status,
    minPrice,
    maxPrice,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate.toString(),
      'per_page': perPage.toString(),
      if (cursor != null) 'cursor': cursor,
      if (search != null && search!.isNotEmpty) 'search': search,
      if (status != null && status != 'all') 'status': status,
      if (minPrice != null) 'min_price': minPrice.toString(),
      if (maxPrice != null) 'max_price': maxPrice.toString(),
    };
  }

  String toJson() => json.encode(toMap());
}
