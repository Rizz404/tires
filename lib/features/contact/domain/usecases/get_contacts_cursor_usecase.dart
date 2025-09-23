import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/contact/domain/repositories/contact_repository.dart';

class GetContactsCursorUsecase
    implements
        Usecase<CursorPaginatedSuccess<Contact>, GetContactsCursorParams> {
  final ContactRepository _userRepository;

  GetContactsCursorUsecase(this._userRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Contact>>> call(
    GetContactsCursorParams params,
  ) async {
    AppLogger.businessInfo('Executing get contacts cursor usecase');
    return await _userRepository.getContactsCursor(params);
  }
}

class GetContactsCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;
  final String? search;
  final String? status;
  final DateTime? publishedAt;

  const GetContactsCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
    this.search,
    this.status,
    this.publishedAt,
  });

  GetContactsCursorParams copyWith({
    bool? paginate,
    int? perPage,
    String? cursor,
    String? search,
    String? status,
    DateTime? publishedAt,
  }) {
    return GetContactsCursorParams(
      paginate: paginate ?? this.paginate,
      perPage: perPage ?? this.perPage,
      cursor: cursor ?? this.cursor,
      search: search ?? this.search,
      status: status ?? this.status,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate,
      'per_page': perPage,
      'cursor': cursor,
      if (search != null && search!.isNotEmpty) 'search': search,
      if (status != null && status != 'all') 'status': status,
      if (publishedAt != null) 'published_at': publishedAt!.toIso8601String(),
    };
  }

  factory GetContactsCursorParams.fromMap(Map<String, dynamic> map) {
    return GetContactsCursorParams(
      paginate: map['paginate'] as bool,
      perPage: map['per_page'] as int,
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
      search: map['search'] != null ? map['search'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      publishedAt: map['published_at'] != null
          ? DateTime.parse(map['published_at'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetContactsCursorParams.fromJson(String source) =>
      GetContactsCursorParams.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    paginate,
    perPage,
    cursor,
    search,
    status,
    publishedAt,
  ];
}
