// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/menu/domain/usecases/get_menu_cursor_usecase.dart';

abstract class MenuRemoteDatasource {
  Future<ApiCursorPaginationResponse<MenuModel>> getMenuCursor(
    GetMenuCursorParams params,
  );
}

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final DioClient _dioClient;

  MenuRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<MenuModel>> getMenuCursor(
    GetMenuCursorParams params,
  ) async {
    try {
      final response = await _dioClient.getWithCursor<MenuModel>(
        ApiEndpoints.publicMenus,
        fromJson: (item) => MenuModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
