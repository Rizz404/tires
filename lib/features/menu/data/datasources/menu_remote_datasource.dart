import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';

abstract class MenuRemoteDatasource {
  Future<ApiCursorPaginationResponse<MenuModel>> getMenuCursor();
}

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final DioClient _dioClient;

  MenuRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<MenuModel>> getMenuCursor() async {
    try {
      final response = await _dioClient.getWithCursor<MenuModel>(
        "/menus",
        fromJson: (item) => MenuModel.fromMap(item as Map<String, dynamic>),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
