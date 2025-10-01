import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/blocked_period/data/datasources/blocked_period_remote_datasource.dart';
import 'package:tires/features/blocked_period/data/mapper/blocked_period_mapper.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';
import 'package:tires/features/blocked_period/domain/usecases/bulk_delete_blocked_periods_usecase.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_statistic.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class BlockedPeriodRepositoryImpl implements BlockedPeriodRepository {
  final BlockedPeriodRemoteDatasource _blockedPeriodRemoteDatasource;

  BlockedPeriodRepositoryImpl(this._blockedPeriodRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<BlockedPeriod>>>
  createBlockedPeriod(CreateBlockedPeriodParams params) async {
    try {
      AppLogger.businessInfo('Creating blocked period in repository');
      final result = await _blockedPeriodRemoteDatasource.createBlockedPeriod(
        params,
      );
      AppLogger.businessDebug(
        'Blocked period created successfully in repository',
      );
      return Right(
        ItemSuccessResponse<BlockedPeriod>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in create blocked period', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in create blocked period', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<BlockedPeriod>>>
  getBlockedPeriodsCursor(GetBlockedPeriodsCursorParams params) async {
    try {
      AppLogger.businessInfo('Getting blocked periods cursor in repository');
      final result = await _blockedPeriodRemoteDatasource
          .getBlockedPeriodsCursor(params);
      AppLogger.businessDebug(
        'Blocked periods cursor retrieved successfully in repository',
      );
      return Right(
        CursorPaginatedSuccess<BlockedPeriod>(
          data: result.data.map((model) => model.toEntity()).toList(),
          cursor: result.cursor?.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get blocked periods cursor', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError(
        'Unexpected error in get blocked periods cursor',
        e,
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<BlockedPeriod>>>
  updateBlockedPeriod(UpdateBlockedPeriodParams params) async {
    try {
      AppLogger.businessInfo('Updating blocked period in repository');
      final result = await _blockedPeriodRemoteDatasource.updateBlockedPeriod(
        params,
      );
      AppLogger.businessDebug(
        'Blocked period updated successfully in repository',
      );
      return Right(
        ItemSuccessResponse<BlockedPeriod>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in update blocked period', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in update blocked period', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> deleteBlockedPeriod(
    DeleteBlockedPeriodParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting blocked period in repository');
      final result = await _blockedPeriodRemoteDatasource.deleteBlockedPeriod(
        params,
      );
      AppLogger.businessDebug(
        'Blocked period deleted successfully in repository',
      );
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete blocked period', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete blocked period', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<BlockedPeriodStatistic>>>
  getBlockedPeriodStatistics() async {
    try {
      AppLogger.businessInfo('Getting blocked period statistics in repository');
      final result = await _blockedPeriodRemoteDatasource
          .getBlockedPeriodStatistics();
      AppLogger.businessDebug(
        'Blocked period statistics retrieved successfully in repository',
      );
      return Right(
        ItemSuccessResponse<BlockedPeriodStatistic>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get blocked period statistics', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError(
        'Unexpected error in get blocked period statistics',
        e,
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> bulkDeleteBlockedPeriods(
    BulkDeleteBlockedPeriodsUsecaseParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting blocked period in repository');
      final result = await _blockedPeriodRemoteDatasource
          .bulkDeleteBlockedPeriods(params);
      AppLogger.businessDebug(
        'Blocked period deleted successfully in repository',
      );
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete blocked period', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete blocked period', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
