import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';

class GetAnnouncementsCursorUsecase
    implements
        Usecase<
          CursorPaginatedSuccess<Announcement>,
          GetAnnouncementsCursorParams
        > {
  final AnnouncementRepository _userRepository;

  GetAnnouncementsCursorUsecase(this._userRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Announcement>>> call(
    GetAnnouncementsCursorParams params,
  ) async {
    AppLogger.businessInfo('Executing get announcements cursor usecase');
    return await _userRepository.getAnnouncementsCursor(params);
  }
}

class GetAnnouncementsCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;
  final String? search;
  final String? status;
  final DateTime? publishedAt;

  const GetAnnouncementsCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
    this.search,
    this.status,
    this.publishedAt,
  });

  GetAnnouncementsCursorParams copyWith({
    bool? paginate,
    int? perPage,
    String? cursor,
    String? search,
    String? status,
    DateTime? publishedAt,
  }) {
    return GetAnnouncementsCursorParams(
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
      'perPage': perPage,
      'cursor': cursor,
      if (search != null && search!.isNotEmpty) 'search': search,
      if (status != null && status != 'all') 'status': status,
      if (publishedAt != null) 'published_at': publishedAt!.toIso8601String(),
    };
  }

  factory GetAnnouncementsCursorParams.fromMap(Map<String, dynamic> map) {
    return GetAnnouncementsCursorParams(
      paginate: map['paginate'] as bool,
      perPage: map['perPage'] as int,
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
      search: map['search'] != null ? map['search'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      publishedAt: map['published_at'] != null
          ? DateTime.parse(map['published_at'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAnnouncementsCursorParams.fromJson(String source) =>
      GetAnnouncementsCursorParams.fromMap(
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
