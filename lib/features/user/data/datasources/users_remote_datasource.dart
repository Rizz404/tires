import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/features/user/domain/usecases/get_users_cursor_usecase.dart';

abstract class UsersRemoteDatasource {
  Future<ApiCursorPaginationResponse<UserModel>> getUsersCursor(
    GetUsersCursorParams params,
  );
}

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {
  final DioClient _dioClient;

  UsersRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<UserModel>> getUsersCursor(
    GetUsersCursorParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching users cursor');
      final response = await _dioClient.getWithCursor<UserModel>(
        ApiEndpoints.adminUsers,
        fromJson: (item) => UserModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );
      AppLogger.networkDebug('Users cursor fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching users cursor', e);
      rethrow;
    }
  }
}
