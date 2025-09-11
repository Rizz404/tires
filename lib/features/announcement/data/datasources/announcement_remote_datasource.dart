import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/announcement/data/models/announcement_model.dart';

abstract class AnnouncementRemoteDatasource {
  Future<ApiCursorPaginationResponse<AnnouncementModel>>
  getAnnouncementsCursor({
    required bool paginate,
    required int perPage,
    String? cursor,
  });
}

class AnnouncementRemoteDatasourceImpl implements AnnouncementRemoteDatasource {
  final DioClient _dioClient;

  AnnouncementRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<AnnouncementModel>>
  getAnnouncementsCursor({
    required bool paginate,
    required int perPage,
    String? cursor,
  }) async {
    try {
      final queryParameters = {
        'paginate': paginate.toString(),
        'per_page': perPage.toString(),
        if (cursor != null) 'cursor': cursor,
      };

      final response = await _dioClient.getWithCursor<AnnouncementModel>(
        ApiEndpoints.adminAnnouncements,
        fromJson: (item) =>
            AnnouncementModel.fromMap(item as Map<String, dynamic>),
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
