import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_statistic.dart';
import 'package:tires/features/blocked_period/domain/usecases/bulk_delete_blocked_periods_usecase.dart';

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

  Future<Either<Failure, ActionSuccess>> bulkDeleteBlockedPeriods(
    BulkDeleteBlockedPeriodsUsecaseParams params,
  );

  Future<Either<Failure, ItemSuccessResponse<BlockedPeriodStatistic>>>
  getBlockedPeriodStatistics();
}

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (menuId != null) 'menu_id': menuId,
      'start_datetime': startDatetime.toIso8601String(),
      'end_datetime': endDatetime.toIso8601String(),
      'reason': reason,
      'all_menus': allMenus,
    };
  }
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (cursor != null) 'cursor': cursor,
      if (perPage != null) 'per_page': perPage,
      if (search != null) 'search': search,
      if (status != null) 'status': status,
      if (menuId != null) 'menu_id': menuId,
      if (allMenus != null) 'all_menus': allMenus,
      if (startDate != null)
        'start_date': startDate!.toIso8601String().split('T').first,
      if (endDate != null)
        'end_date': endDate!.toIso8601String().split('T').first,
    };
  }
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      if (menuId != null) 'menu_id': menuId,
      if (startDatetime != null)
        'start_datetime': startDatetime!.toIso8601String(),
      if (endDatetime != null) 'end_datetime': endDatetime!.toIso8601String(),
      if (reason != null) 'reason': reason,
      if (allMenus != null) 'all_menus': allMenus,
    };
  }
}

class DeleteBlockedPeriodParams {
  final int id;

  const DeleteBlockedPeriodParams({required this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }
}
