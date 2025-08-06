import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';

abstract class MenuRemoteDatasource {
  Future<List<MenuModel>> getMenus();
}

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final DioClient _dioClient;

  MenuRemoteDatasourceImpl(this._dioClient);

  @override
  Future<List<MenuModel>> getMenus() async {
    try {
      final response = await _dioClient.getPlain(
        "https://tire.fts.biz.id/api/v1/menus",
      );

      final List<dynamic> jsonList = response as List;
      return jsonList.map((json) => MenuModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
