import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';

class GetAnnouncementsCursorUsecase
    implements
        Usecase<
          CursorPaginatedSuccess<Announcement>,
          GetUserAnnouncementsCursorParams
        > {
  final AnnouncementRepository _userRepository;

  GetAnnouncementsCursorUsecase(this._userRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Announcement>>> call(
    GetUserAnnouncementsCursorParams params,
  ) async {
    return await _userRepository.getAnnouncementsCursor(params);
  }
}

class GetUserAnnouncementsCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;
  const GetUserAnnouncementsCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  GetUserAnnouncementsCursorParams copyWith({
    bool? paginate,
    int? perPage,
    String? cursor,
  }) {
    return GetUserAnnouncementsCursorParams(
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

  factory GetUserAnnouncementsCursorParams.fromMap(Map<String, dynamic> map) {
    return GetUserAnnouncementsCursorParams(
      paginate: map['paginate'] as bool,
      perPage: map['perPage'] as int,
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetUserAnnouncementsCursorParams.fromJson(String source) =>
      GetUserAnnouncementsCursorParams.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [paginate, perPage, cursor];
}
