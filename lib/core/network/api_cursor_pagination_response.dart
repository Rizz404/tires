import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/cursor.dart';

class ApiCursorPaginationResponse<T> extends ApiResponse<List<T>> {
  // Todo: Nanti benerin harusnya gak nullable
  final Cursor? cursor;

  ApiCursorPaginationResponse({
    required super.success,
    required super.message,
    required super.data,
    required this.cursor,
  });

  factory ApiCursorPaginationResponse.fromMap(
    Map<String, dynamic> map,
    T Function(dynamic json) fromJsonT,
  ) {
    final cursorData = map['cursor'];

    return ApiCursorPaginationResponse<T>(
      success: map['success'] as bool,
      message: map['message'] as String,
      data: (map['data'] as List<dynamic>)
          .map((item) => fromJsonT(item))
          .toList(),
      cursor: cursorData != null
          ? Cursor.fromMap(cursorData as Map<String, dynamic>)
          : null,
    );
  }

  @override
  ApiCursorPaginationResponse<T> copyWith({
    bool? success,
    String? message,
    List<T>? data,
    Cursor? cursor,
  }) {
    return ApiCursorPaginationResponse<T>(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      cursor: cursor ?? this.cursor,
    );
  }

  @override
  String toString() {
    return 'ApiCursorPaginationResponse(success: $success, message: $message, data: $data, cursor: $cursor)';
  }

  @override
  List<Object?> get props => [success, message, data, cursor];
}
