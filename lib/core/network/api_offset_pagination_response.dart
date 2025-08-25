import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/pagination.dart';

class ApiOffsetPaginationResponse<T> extends ApiResponse<List<T>> {
  final Pagination pagination;

  ApiOffsetPaginationResponse({
    required super.status,
    required super.message,
    required super.data,
    required this.pagination,
  });

  factory ApiOffsetPaginationResponse.fromMap(
    Map<String, dynamic> map,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiOffsetPaginationResponse<T>(
      status: map['status'] as String,
      message: map['message'] as String,
      data: (map['data'] as List<dynamic>)
          .map((item) => fromJsonT(item))
          .toList(),
      pagination: Pagination.fromMap(map['pagination'] as Map<String, dynamic>),
    );
  }

  @override
  ApiOffsetPaginationResponse<T> copyWith({
    String? status,
    String? message,
    List<T>? data,
    Pagination? pagination,
  }) {
    return ApiOffsetPaginationResponse<T>(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  String toString() {
    return 'ApiOffsetPaginationResponse(status: $status, message: $message, data: $data, pagination: $pagination)';
  }

  @override
  List<Object?> get props => [status, message, data, pagination];
}
