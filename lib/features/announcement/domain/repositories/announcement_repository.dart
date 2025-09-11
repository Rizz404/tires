import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';

abstract class AnnouncementRepository {
  Future<Either<Failure, CursorPaginatedSuccess<Announcement>>>
  getAnnouncementsCursor({
    required bool paginate,
    required int perPage,
    String? cursor,
  });
}
