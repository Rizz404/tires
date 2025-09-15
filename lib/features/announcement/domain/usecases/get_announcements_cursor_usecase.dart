import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
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
    return await _userRepository.getAnnouncementsCursor(params);
  }
}

class GetAnnouncementsCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;
  const GetAnnouncementsCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  GetAnnouncementsCursorParams copyWith({
    bool? paginate,
    int? perPage,
    String? cursor,
  }) {
    return GetAnnouncementsCursorParams(
      paginate: paginate ?? this.paginate,
      perPage: perPage ?? this.perPage,
      cursor: cursor ?? this.cursor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate,
      'perPage': perPage,
      'cursor': cursor,
    };
  }

  factory GetAnnouncementsCursorParams.fromMap(Map<String, dynamic> map) {
    return GetAnnouncementsCursorParams(
      paginate: map['paginate'] as bool,
      perPage: map['perPage'] as int,
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
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
  List<Object?> get props => [paginate, perPage, cursor];
}
