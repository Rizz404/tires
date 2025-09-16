// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/menu/data/models/menu_statistic_model.dart';
import 'package:tires/features/menu/domain/usecases/create_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/delete_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_admin_menus_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/get_menus_cursor_usecase.dart';
import 'package:tires/features/menu/domain/usecases/update_menu_usecase.dart';

abstract class MenuRemoteDatasource {
  Future<ApiResponse<MenuModel>> createMenu(CreateMenuParams params);
  Future<ApiCursorPaginationResponse<MenuModel>> getMenusCursor(
    GetMenusCursorParams params,
  );
  Future<ApiCursorPaginationResponse<MenuModel>> getAdminMenusCursor(
    GetAdminMenusCursorParams params,
  );
  Future<ApiResponse<MenuModel>> updateMenu(UpdateMenuParams params);
  Future<ApiResponse<dynamic>> deleteMenu(DeleteMenuParams params);
  Future<ApiResponse<MenuStatisticModel>> getMenuStatistics();
}

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final DioClient _dioClient;

  MenuRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<MenuModel>> createMenu(CreateMenuParams params) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.adminMenus,
        data: params.toMap(),
      );
      return ApiResponse<MenuModel>.fromJson(
        response.data,
        (data) => MenuModel.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<MenuModel>> getMenusCursor(
    GetMenusCursorParams params,
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

  @override
  Future<ApiCursorPaginationResponse<MenuModel>> getAdminMenusCursor(
    GetAdminMenusCursorParams params,
  ) async {
    try {
      final response = await _dioClient.getWithCursor(
        ApiEndpoints.adminMenus,
        fromJson: (item) => MenuModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<MenuModel>> updateMenu(UpdateMenuParams params) async {
    try {
      final response = await _dioClient.patch(
        '${ApiEndpoints.adminMenus}/${params.id}',
        data: params.toMap(),
      );
      return ApiResponse<MenuModel>.fromJson(
        response.data,
        (data) => MenuModel.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteMenu(DeleteMenuParams params) async {
    try {
      final response = await _dioClient.delete(
        '${ApiEndpoints.adminMenus}/${params.id}',
        data: params.toMap(),
      );
      return ApiResponse<dynamic>.fromJson(response.data, (data) => data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<MenuStatisticModel>> getMenuStatistics() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.adminMenuStatistics);
      return ApiResponse<MenuStatisticModel>.fromJson(
        response.data,
        (data) => MenuStatisticModel.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}
