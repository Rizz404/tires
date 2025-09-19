import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_statistic.dart';

abstract class BlockedPeriodRepository {
  Future<Either<Failure, ItemSuccessResponse<BlockedPeriod>>>
  createBlockedPeriod(CreateBlockedPeriodParams params);

  Future<Either<Failure, CursorPaginatedSuccess<BlockedPeriod>>>
  getBlockedPeriodsCursor(GetBlockedPeriodsCursorParams params);

  Future<Either<Failure, ItemSuccessResponse<BlockedPeriod>>>
  updateBlockedPeriod(UpdateBlockedPeriodParams params);

  Future<Either<Failure, ActionSuccess>> deleteBlockedPeriod(
    DeleteBlockedPeriodParams params,
  );

  Future<Either<Failure, ItemSuccessResponse<BlockedPeriodStatistic>>>
  getBlockedPeriodStatistics();
}

// Parameter classes for type safety
class CreateBlockedPeriodParams {
  final int? menuId;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final String reason;
  final bool allMenus;

  const CreateBlockedPeriodParams({
    this.menuId,
    required this.startDatetime,
    required this.endDatetime,
    required this.reason,
    required this.allMenus,
  });
}

class GetBlockedPeriodsCursorParams {
  final String? cursor;
  final int? perPage;
  final String? search;
  final String? status;
  final int? menuId;
  final bool? allMenus;
  final DateTime? startDate;
  final DateTime? endDate;

  const GetBlockedPeriodsCursorParams({
    this.cursor,
    this.perPage,
    this.search,
    this.status,
    this.menuId,
    this.allMenus,
    this.startDate,
    this.endDate,
  });
}

class UpdateBlockedPeriodParams {
  final int id;
  final int? menuId;
  final DateTime? startDatetime;
  final DateTime? endDatetime;
  final String? reason;
  final bool? allMenus;

  const UpdateBlockedPeriodParams({
    required this.id,
    this.menuId,
    this.startDatetime,
    this.endDatetime,
    this.reason,
    this.allMenus,
  });
}

class DeleteBlockedPeriodParams {
  final int id;

  const DeleteBlockedPeriodParams({required this.id});
}
