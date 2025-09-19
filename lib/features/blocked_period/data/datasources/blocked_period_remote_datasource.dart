import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/blocked_period/data/models/blocked_period_model.dart';
import 'package:tires/features/blocked_period/data/models/blocked_period_statistic_model.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';

abstract class BlockedPeriodRemoteDatasource {
  Future<ApiResponse<BlockedPeriodModel>> createBlockedPeriod(
    CreateBlockedPeriodParams params,
  );

  Future<ApiCursorPaginationResponse<BlockedPeriodModel>>
  getBlockedPeriodsCursor(GetBlockedPeriodsCursorParams params);

  Future<ApiResponse<BlockedPeriodModel>> updateBlockedPeriod(
    UpdateBlockedPeriodParams params,
  );

  Future<ApiResponse<dynamic>> deleteBlockedPeriod(
    DeleteBlockedPeriodParams params,
  );

  Future<ApiResponse<BlockedPeriodStatisticModel>> getBlockedPeriodStatistics();
}

class BlockedPeriodRemoteDatasourceImpl
    implements BlockedPeriodRemoteDatasource {
  final DioClient _dioClient;

  BlockedPeriodRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<BlockedPeriodModel>> createBlockedPeriod(
    CreateBlockedPeriodParams params,
  ) async {
    try {
      AppLogger.networkInfo('Creating blocked period');
      final response = await _dioClient.post<BlockedPeriodModel>(
        ApiEndpoints.adminBlockedPeriods,
        data: _createBlockedPeriodParamsToMap(params),
        fromJson: (data) => BlockedPeriodModel.fromMap(data),
      );
      AppLogger.networkDebug('Blocked period created successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error creating blocked period', e);
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<BlockedPeriodModel>>
  getBlockedPeriodsCursor(GetBlockedPeriodsCursorParams params) async {
    try {
      AppLogger.networkInfo('Getting blocked periods with cursor pagination');
      final response = await _dioClient.getWithCursor<BlockedPeriodModel>(
        ApiEndpoints.adminBlockedPeriods,
        fromJson: (item) =>
            BlockedPeriodModel.fromMap(item as Map<String, dynamic>),
        queryParameters: _getBlockedPeriodsCursorParamsToMap(params),
      );
      AppLogger.networkDebug('Blocked periods retrieved successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error getting blocked periods', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<BlockedPeriodModel>> updateBlockedPeriod(
    UpdateBlockedPeriodParams params,
  ) async {
    try {
      AppLogger.networkInfo('Updating blocked period with ID: ${params.id}');
      final response = await _dioClient.put<BlockedPeriodModel>(
        '${ApiEndpoints.adminBlockedPeriods}/${params.id}',
        data: _updateBlockedPeriodParamsToMap(params),
        fromJson: (data) => BlockedPeriodModel.fromMap(data),
      );
      AppLogger.networkDebug('Blocked period updated successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error updating blocked period', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteBlockedPeriod(
    DeleteBlockedPeriodParams params,
  ) async {
    try {
      AppLogger.networkInfo('Deleting blocked period with ID: ${params.id}');
      final response = await _dioClient.delete(
        '${ApiEndpoints.adminBlockedPeriods}/${params.id}',
      );
      AppLogger.networkDebug('Blocked period deleted successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error deleting blocked period', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<BlockedPeriodStatisticModel>>
  getBlockedPeriodStatistics() async {
    try {
      AppLogger.networkInfo('Getting blocked period statistics');
      final response = await _dioClient.get<BlockedPeriodStatisticModel>(
        ApiEndpoints.adminBlockedPeriodStatistics,
        fromJson: (data) => BlockedPeriodStatisticModel.fromMap(data),
      );
      AppLogger.networkDebug(
        'Blocked period statistics retrieved successfully',
      );
      return response;
    } catch (e) {
      AppLogger.networkError('Error getting blocked period statistics', e);
      rethrow;
    }
  }

  // Helper methods to convert params to map
  Map<String, dynamic> _createBlockedPeriodParamsToMap(
    CreateBlockedPeriodParams params,
  ) {
    return {
      if (params.menuId != null) 'menu_id': params.menuId,
      'start_datetime': params.startDatetime.toIso8601String(),
      'end_datetime': params.endDatetime.toIso8601String(),
      'reason': params.reason,
      'all_menus': params.allMenus,
    };
  }

  Map<String, dynamic> _getBlockedPeriodsCursorParamsToMap(
    GetBlockedPeriodsCursorParams params,
  ) {
    final map = <String, dynamic>{};

    if (params.cursor != null) map['cursor'] = params.cursor;
    if (params.perPage != null) map['per_page'] = params.perPage;
    if (params.search != null) map['search'] = params.search;
    if (params.status != null) map['status'] = params.status;
    if (params.menuId != null) map['menu_id'] = params.menuId;
    if (params.allMenus != null) map['all_menus'] = params.allMenus;
    if (params.startDate != null)
      map['start_date'] = params.startDate!.toIso8601String();
    if (params.endDate != null)
      map['end_date'] = params.endDate!.toIso8601String();

    return map;
  }

  Map<String, dynamic> _updateBlockedPeriodParamsToMap(
    UpdateBlockedPeriodParams params,
  ) {
    final map = <String, dynamic>{};

    if (params.menuId != null) map['menu_id'] = params.menuId;
    if (params.startDatetime != null)
      map['start_datetime'] = params.startDatetime!.toIso8601String();
    if (params.endDatetime != null)
      map['end_datetime'] = params.endDatetime!.toIso8601String();
    if (params.reason != null) map['reason'] = params.reason;
    if (params.allMenus != null) map['all_menus'] = params.allMenus;

    return map;
  }
}
