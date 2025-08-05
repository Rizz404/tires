import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/cursor.dart';

class ApiCursorPaginationResponse<T> extends ApiResponse<List<T>> {
  final Cursor cursor;

  ApiCursorPaginationResponse({
    required super.status,
    required super.message,
    required super.data,
    required this.cursor,
  });

  factory ApiCursorPaginationResponse.fromMap(
    Map<String, dynamic> map,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiCursorPaginationResponse<T>(
      status: map['status'] as String,
      message: map['message'] as String,
      data: (map['data'] as List<dynamic>)
          .map((item) => fromJsonT(item))
          .toList(),
      cursor: Cursor.fromMap(map['cursor'] as Map<String, dynamic>),
    );
  }

  @override
  ApiCursorPaginationResponse<T> copyWith({
    String? status,
    String? message,
    List<T>? data,
    Cursor? cursor,
  }) {
    return ApiCursorPaginationResponse<T>(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
      cursor: cursor ?? this.cursor,
    );
  }

  @override
  String toString() {
    return 'ApiCursorPaginationResponse(status: $status, message: $message, data: $data, cursor: $cursor)';
  }

  @override
  List<Object?> get props => [status, message, data, cursor];
}
