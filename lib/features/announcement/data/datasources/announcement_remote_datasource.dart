import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/announcement/data/models/announcement_model.dart';
import 'package:tires/features/announcement/data/models/announcement_statistic_model.dart';
import 'package:tires/features/announcement/domain/usecases/bulk_delete_announcements_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/delete_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/update_announcement_usecase.dart';

abstract class AnnouncementRemoteDatasource {
  Future<ApiResponse<AnnouncementModel>> createAnnouncement(
    CreateAnnouncementParams params,
  );
  Future<ApiCursorPaginationResponse<AnnouncementModel>> getAnnouncementsCursor(
    GetAnnouncementsCursorParams params,
  );
  Future<ApiResponse<AnnouncementModel>> updateAnnouncement(
    UpdateAnnouncementParams params,
  );
  Future<ApiResponse<dynamic>> deleteAnnouncement(
    DeleteAnnouncementParams params,
  );
  Future<ApiResponse<dynamic>> bulkDeleteAnnouncements(
    BulkDeleteAnnouncementsUsecaseParams params,
  );
  Future<ApiResponse<AnnouncementStatisticModel>> getAnnouncementStatistics();
}

class AnnouncementRemoteDatasourceImpl implements AnnouncementRemoteDatasource {
  final DioClient _dioClient;

  AnnouncementRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<AnnouncementModel>> createAnnouncement(
    CreateAnnouncementParams params,
  ) async {
    try {
      AppLogger.networkInfo('Creating announcement');
      final response = await _dioClient.post<AnnouncementModel>(
        ApiEndpoints.adminAnnouncements,
        data: params.toMap(),
        fromJson: (data) => AnnouncementModel.fromMap(data),
      );
      AppLogger.networkDebug('Announcement created successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error creating announcement', e);
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<AnnouncementModel>> getAnnouncementsCursor(
    GetAnnouncementsCursorParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching announcements cursor');
      final response = await _dioClient.getWithCursor<AnnouncementModel>(
        ApiEndpoints.adminAnnouncements,
        fromJson: (item) =>
            AnnouncementModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );
      AppLogger.networkDebug('Announcements cursor fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching announcements cursor', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<AnnouncementModel>> updateAnnouncement(
    UpdateAnnouncementParams params,
  ) async {
    try {
      AppLogger.networkInfo('Updating announcement with id: ${params.id}');
      final response = await _dioClient.patch<AnnouncementModel>(
        '${ApiEndpoints.adminAnnouncements}/${params.id}',
        data: params.toMap(),
        fromJson: (data) => AnnouncementModel.fromMap(data),
      );
      AppLogger.networkDebug('Announcement updated successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error updating announcement', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteAnnouncement(
    DeleteAnnouncementParams params,
  ) async {
    try {
      AppLogger.networkInfo('Deleting announcement with id: ${params.id}');
      final response = await _dioClient.delete<dynamic>(
        '${ApiEndpoints.adminAnnouncements}/${params.id}',
        data: params.toMap(),
      );
      AppLogger.networkDebug('Announcement deleted successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error deleting announcement', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> bulkDeleteAnnouncements(
    BulkDeleteAnnouncementsUsecaseParams params,
  ) async {
    try {
      AppLogger.networkInfo('Bulk deleting announcements');
      final response = await _dioClient.patch<dynamic>(
        ApiEndpoints.adminAnnouncementBulkDelete,
        data: params.toMap(),
      );
      AppLogger.networkDebug('Announcements bulk deleted successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error bulk deleting announcements', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<AnnouncementStatisticModel>>
  getAnnouncementStatistics() async {
    try {
      AppLogger.networkInfo('Fetching announcement statistics');
      final response = await _dioClient.get<AnnouncementStatisticModel>(
        ApiEndpoints.adminAnnouncementStatistics,
        fromJson: (data) => AnnouncementStatisticModel.fromMap(data),
      );
      AppLogger.networkDebug('Announcement statistics fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching announcement statistics', e);
      rethrow;
    }
  }
}
