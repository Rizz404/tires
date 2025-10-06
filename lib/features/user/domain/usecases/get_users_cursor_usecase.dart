import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/user/domain/repositories/users_repository.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class GetUsersCursorUsecase
    implements Usecase<CursorPaginatedSuccess<User>, GetUsersCursorParams> {
  final UsersRepository _usersRepository;

  GetUsersCursorUsecase(this._usersRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<User>>> call(
    GetUsersCursorParams params,
  ) async {
    AppLogger.businessInfo('Executing get users cursor usecase');
    return await _usersRepository.getUsersCursor(params);
  }
}

class GetUsersCursorParams extends Equatable {
  final String? createdFrom;
  final String? createdTo;
  final String? cursor;
  final String? locale;
  final bool paginate;
  final int perPage;
  final String? role;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  final String? status;

  const GetUsersCursorParams({
    this.createdFrom,
    this.createdTo,
    this.cursor,
    this.locale,
    required this.paginate,
    required this.perPage,
    this.role,
    this.search,
    this.sortBy,
    this.sortOrder,
    this.status,
  });

  GetUsersCursorParams copyWith({
    String? createdFrom,
    String? createdTo,
    String? cursor,
    String? locale,
    bool? paginate,
    int? perPage,
    String? role,
    String? search,
    String? sortBy,
    String? sortOrder,
    String? status,
  }) {
    return GetUsersCursorParams(
      createdFrom: createdFrom ?? this.createdFrom,
      createdTo: createdTo ?? this.createdTo,
      cursor: cursor ?? this.cursor,
      locale: locale ?? this.locale,
      paginate: paginate ?? this.paginate,
      perPage: perPage ?? this.perPage,
      role: role ?? this.role,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (createdFrom != null) 'created_from': createdFrom,
      if (createdTo != null) 'created_to': createdTo,
      if (cursor != null) 'cursor': cursor,
      if (locale != null) 'locale': locale,
      'paginate': paginate.toString(),
      'per_page': perPage,
      if (role != null) 'role': role,
      if (search != null) 'search': search,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (status != null) 'status': status,
    };
  }

  factory GetUsersCursorParams.fromMap(Map<String, dynamic> map) {
    return GetUsersCursorParams(
      createdFrom: map['created_from'] != null
          ? map['created_from'] as String
          : null,
      createdTo: map['created_to'] != null ? map['created_to'] as String : null,
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
      locale: map['locale'] != null ? map['locale'] as String : null,
      paginate: map['paginate'] == 'true' || map['paginate'] == true,
      perPage: map['per_page'] as int,
      role: map['role'] != null ? map['role'] as String : null,
      search: map['search'] != null ? map['search'] as String : null,
      sortBy: map['sort_by'] != null ? map['sort_by'] as String : null,
      sortOrder: map['sort_order'] != null ? map['sort_order'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetUsersCursorParams.fromJson(String source) =>
      GetUsersCursorParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    createdFrom,
    createdTo,
    cursor,
    locale,
    paginate,
    perPage,
    role,
    search,
    sortBy,
    sortOrder,
    status,
  ];
}
