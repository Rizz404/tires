import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/update_announcement_usecase.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';

abstract class AnnouncementRepository {
  Future<Either<Failure, ItemSuccessResponse<Announcement>>> createAnnouncement(
    CreateAnnouncementParams params,
  );
  Future<Either<Failure, CursorPaginatedSuccess<Announcement>>>
  getAnnouncementsCursor(GetUserAnnouncementsCursorParams params);
  Future<Either<Failure, ItemSuccessResponse<Announcement>>> updateAnnouncement(
    UpdateAnnouncementParams params,
  );
}
