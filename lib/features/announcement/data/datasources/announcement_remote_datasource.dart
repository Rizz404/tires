import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/announcement/data/models/announcement_model.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/delete_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/get_announcements_cursor_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/update_announcement_usecase.dart';

abstract class AnnouncementRemoteDatasource {
  Future<ApiResponse<AnnouncementModel>> createAnnouncement(
    CreateAnnouncementParams params,
  );
  Future<ApiCursorPaginationResponse<AnnouncementModel>> getAnnouncementsCursor(
    GetUserAnnouncementsCursorParams params,
  );
  Future<ApiResponse<AnnouncementModel>> updateAnnouncement(
    UpdateAnnouncementParams params,
  );
  Future<ApiResponse<dynamic>> deleteAnnouncement(
    DeleteAnnouncementParams params,
  );
}

class AnnouncementRemoteDatasourceImpl implements AnnouncementRemoteDatasource {
  final DioClient _dioClient;

  AnnouncementRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<AnnouncementModel>> createAnnouncement(
    CreateAnnouncementParams params,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.adminAnnouncements,
        data: params.toMap(),
      );
      return ApiResponse<AnnouncementModel>.fromJson(
        response.data,
        (data) => AnnouncementModel.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<AnnouncementModel>> getAnnouncementsCursor(
    GetUserAnnouncementsCursorParams params,
  ) async {
    try {
      final response = await _dioClient.getWithCursor<AnnouncementModel>(
        ApiEndpoints.adminAnnouncements,
        fromJson: (item) =>
            AnnouncementModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<AnnouncementModel>> updateAnnouncement(
    UpdateAnnouncementParams params,
  ) async {
    try {
      final response = await _dioClient.patch(
        '${ApiEndpoints.adminAnnouncements}/${params.id}',
        data: params.toMap(),
      );
      return ApiResponse<AnnouncementModel>.fromJson(
        response.data,
        (data) => AnnouncementModel.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<AnnouncementModel>> deleteAnnouncement(
    DeleteAnnouncementParams params,
  ) async {
    try {
      final response = await _dioClient.delete(
        '${ApiEndpoints.adminAnnouncements}/${params.id}',
        data: params.toMap(),
      );
      return ApiResponse<AnnouncementModel>.fromJson(
        response.data,
        (data) => AnnouncementModel.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}
