import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/announcement/data/datasources/announcement_remote_datasource.dart';
import 'package:tires/features/announcement/data/mapper/announcement_mapper.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/announcement/domain/usecases/bulk_delete_announcements_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/delete_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/update_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/announcement/domain/entities/announcement_statistic.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDatasource _announcementRemoteDatasource;

  AnnouncementRepositoryImpl(this._announcementRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<Announcement>>> createAnnouncement(
    CreateAnnouncementParams params,
  ) async {
    try {
      AppLogger.businessInfo('Creating announcement in repository');
      final result = await _announcementRemoteDatasource.createAnnouncement(
        params,
      );
      AppLogger.businessDebug(
        'Announcement created successfully in repository',
      );
      return Right(
        ItemSuccessResponse<Announcement>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in create announcement', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in create announcement', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Announcement>>>
  getAnnouncementsCursor(GetAnnouncementsCursorParams params) async {
    try {
      AppLogger.businessInfo('Fetching announcements cursor in repository');
      final result = await _announcementRemoteDatasource.getAnnouncementsCursor(
        params,
      );
      AppLogger.businessDebug(
        'Announcements cursor fetched successfully in repository',
      );
      return Right(
        CursorPaginatedSuccess<Announcement>(
          data: result.data
              .map((announcement) => announcement.toEntity())
              .toList(),
          cursor: result.cursor?.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get announcements cursor', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError(
        'Unexpected error in get announcements cursor',
        e,
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Announcement>>> updateAnnouncement(
    UpdateAnnouncementParams params,
  ) async {
    try {
      AppLogger.businessInfo('Updating announcement in repository');
      final result = await _announcementRemoteDatasource.updateAnnouncement(
        params,
      );
      AppLogger.businessDebug(
        'Announcement updated successfully in repository',
      );
      return Right(
        ItemSuccessResponse<Announcement>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in update announcement', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in update announcement', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> deleteAnnouncement(
    DeleteAnnouncementParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting announcement in repository');
      final result = await _announcementRemoteDatasource.deleteAnnouncement(
        params,
      );
      AppLogger.businessDebug(
        'Announcement deleted successfully in repository',
      );
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete announcement', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete announcement', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<AnnouncementStatistic>>>
  getAnnouncementStatistics() async {
    try {
      AppLogger.businessInfo('Fetching announcement statistics in repository');
      final result = await _announcementRemoteDatasource
          .getAnnouncementStatistics();
      AppLogger.businessDebug(
        'Announcement statistics fetched successfully in repository',
      );
      return Right(
        ItemSuccessResponse<AnnouncementStatistic>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get announcement statistics', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError(
        'Unexpected error in get announcement statistics',
        e,
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> bulkDeleteAnnouncements(
    BulkDeleteAnnouncementsUsecaseParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting announcement in repository');
      final result = await _announcementRemoteDatasource
          .bulkDeleteAnnouncements(params);
      AppLogger.businessDebug(
        'Announcement deleted successfully in repository',
      );
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete announcement', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete announcement', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
