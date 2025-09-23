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
  final bool paginate;
  final int perPage;
  final String? cursor;
  const GetUsersCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  GetUsersCursorParams copyWith({
    bool? paginate,
    int? perPage,
    String? cursor,
  }) {
    return GetUsersCursorParams(
      paginate: paginate ?? this.paginate,
      perPage: perPage ?? this.perPage,
      cursor: cursor ?? this.cursor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate,
      'per_page': perPage,
      'cursor': cursor,
    };
  }

  factory GetUsersCursorParams.fromMap(Map<String, dynamic> map) {
    return GetUsersCursorParams(
      paginate: map['paginate'] as bool,
      perPage: map['per_page'] as int,
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetUsersCursorParams.fromJson(String source) =>
      GetUsersCursorParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [paginate, perPage, cursor];
}
