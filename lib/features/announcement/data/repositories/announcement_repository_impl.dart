import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/features/announcement/data/datasources/announcement_remote_datasource.dart';
import 'package:tires/features/announcement/data/mapper/announcement_mapper.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
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
      final result = await _announcementRemoteDatasource.createAnnouncement(
        params,
      );

      return Right(
        ItemSuccessResponse<Announcement>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Announcement>>>
  getAnnouncementsCursor(GetAnnouncementsCursorParams params) async {
    try {
      final result = await _announcementRemoteDatasource.getAnnouncementsCursor(
        params,
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
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Announcement>>> updateAnnouncement(
    UpdateAnnouncementParams params,
  ) async {
    try {
      final result = await _announcementRemoteDatasource.updateAnnouncement(
        params,
      );

      return Right(
        ItemSuccessResponse<Announcement>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> deleteAnnouncement(
    DeleteAnnouncementParams params,
  ) async {
    try {
      final result = await _announcementRemoteDatasource.deleteAnnouncement(
        params,
      );

      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<AnnouncementStatistic>>>
  getAnnouncementStatistics() async {
    try {
      final result = await _announcementRemoteDatasource
          .getAnnouncementStatistics();

      return Right(
        ItemSuccessResponse<AnnouncementStatistic>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
