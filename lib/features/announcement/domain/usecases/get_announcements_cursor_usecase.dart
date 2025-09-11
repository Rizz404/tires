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
    return await _userRepository.getAnnouncementsCursor(
      paginate: params.paginate,
      perPage: params.perPage,
      cursor: params.cursor,
    );
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

  @override
  List<Object?> get props => [paginate, perPage, cursor];
}
