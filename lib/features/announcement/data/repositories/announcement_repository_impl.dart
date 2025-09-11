import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/features/announcement/data/datasources/announcement_remote_datasource.dart';
import 'package:tires/features/announcement/data/mapper/announcement_mapper.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDatasource _announcementRemoteDatasource;

  AnnouncementRepositoryImpl(this._announcementRemoteDatasource);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Announcement>>>
  getAnnouncementsCursor({
    required bool paginate,
    required int perPage,
    String? cursor,
  }) async {
    try {
      final result = await _announcementRemoteDatasource.getAnnouncementsCursor(
        paginate: paginate,
        perPage: perPage,
        cursor: cursor,
      );

      return Right(
        CursorPaginatedSuccess<Announcement>(
          data: result.data
              .map((announcement) => announcement.toEntity())
              .toList(),
          cursor: result.cursor?.toEntity(),
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
