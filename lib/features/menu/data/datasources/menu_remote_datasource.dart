// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';

abstract class MenuRemoteDatasource {
  Future<ApiCursorPaginationResponse<MenuModel>> getMenuCursor(
    GetMenuCursorPayload payload,
  );
}

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final DioClient _dioClient;

  MenuRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<MenuModel>> getMenuCursor(
    GetMenuCursorPayload payload,
  ) async {
    try {
      final response = await _dioClient.getWithCursor<MenuModel>(
        ApiEndpoints.publicMenus,
        fromJson: (item) => MenuModel.fromMap(item as Map<String, dynamic>),
        queryParameters: payload.toMap(),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class GetMenuCursorPayload extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  GetMenuCursorPayload({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  @override
  List<Object?> get props => [paginate, perPage, cursor];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate,
      'per_page': perPage,
      'cursor': cursor,
    };
  }

  factory GetMenuCursorPayload.fromMap(Map<String, dynamic> map) {
    return GetMenuCursorPayload(
      paginate: map['paginate'] as bool,
      perPage: map['per_page'] as int,
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetMenuCursorPayload.fromJson(String source) =>
      GetMenuCursorPayload.fromMap(json.decode(source) as Map<String, dynamic>);
}
