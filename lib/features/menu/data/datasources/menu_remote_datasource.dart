// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
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
      AppLogger.networkInfo('Creating menu');
      final response = await _dioClient.post<MenuModel>(
        ApiEndpoints.adminMenus,
        data: params.toMap(),
        fromJson: (data) => MenuModel.fromMap(data),
      );
      AppLogger.networkDebug('Menu created successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error creating menu', e);
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<MenuModel>> getMenusCursor(
    GetMenusCursorParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching menus cursor');
      final response = await _dioClient.getWithCursor<MenuModel>(
        ApiEndpoints.publicMenus,
        fromJson: (item) => MenuModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );
      AppLogger.networkDebug('Menus cursor fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching menus cursor', e);
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<MenuModel>> getAdminMenusCursor(
    GetAdminMenusCursorParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching admin menus cursor');
      final response = await _dioClient.getWithCursor<MenuModel>(
        ApiEndpoints.adminMenus,
        fromJson: (item) => MenuModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );
      AppLogger.networkDebug('Admin menus cursor fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching admin menus cursor', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<MenuModel>> updateMenu(UpdateMenuParams params) async {
    try {
      AppLogger.networkInfo('Updating menu with id: ${params.id}');
      final response = await _dioClient.patch<MenuModel>(
        '${ApiEndpoints.adminMenus}/${params.id}',
        data: params.toMap(),
        fromJson: (data) => MenuModel.fromMap(data),
      );
      AppLogger.networkDebug('Menu updated successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error updating menu', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteMenu(DeleteMenuParams params) async {
    try {
      AppLogger.networkInfo('Deleting menu with id: ${params.id}');
      final response = await _dioClient.delete<dynamic>(
        '${ApiEndpoints.adminMenus}/${params.id}',
        data: params.toMap(),
      );
      AppLogger.networkDebug('Menu deleted successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error deleting menu', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<MenuStatisticModel>> getMenuStatistics() async {
    try {
      AppLogger.networkInfo('Fetching menu statistics');
      final response = await _dioClient.get<MenuStatisticModel>(
        ApiEndpoints.adminMenuStatistics,
        fromJson: (data) => MenuStatisticModel.fromJson(data),
      );
      AppLogger.networkDebug('Menu statistics fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching menu statistics', e);
      rethrow;
    }
  }
}
