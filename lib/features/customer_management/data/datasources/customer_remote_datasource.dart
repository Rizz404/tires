// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/customer_management/data/models/customer_model.dart';

abstract class CustomerRemoteDatasource {
  Future<ApiCursorPaginationResponse<CustomerModel>> getCustomerCursor(
    GetCustomerCursorPayload payload,
  );
}

class CustomerRemoteDatasourceImpl implements CustomerRemoteDatasource {
  final DioClient _dioClient;

  CustomerRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<CustomerModel>> getCustomerCursor(
    GetCustomerCursorPayload payload,
  ) async {
    try {
      final response = await _dioClient.getWithCursor<CustomerModel>(
        "/customers",
        fromJson: (item) => CustomerModel.fromMap(item as Map<String, dynamic>),
        queryParameters: payload.toMap(),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class GetCustomerCursorPayload extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  GetCustomerCursorPayload({
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

  factory GetCustomerCursorPayload.fromMap(Map<String, dynamic> map) {
    return GetCustomerCursorPayload(
      paginate: map['paginate'] as bool,
      perPage: map['per_page'] as int,
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetCustomerCursorPayload.fromJson(String source) =>
      GetCustomerCursorPayload.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
