import 'dart:convert';
import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final String message;
  final T data;

  const ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  ApiResponse<T> copyWith({bool? success, String? message, T? data}) {
    return ApiResponse<T>(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory ApiResponse.fromMap(
    Map<String, dynamic> map,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: map['success'] as bool,
      message: map['message'] as String,
      data: fromJsonT != null ? fromJsonT(map['data']) : map['data'] as T,
    );
  }

  factory ApiResponse.fromJson(
    String source,
    T Function(dynamic json)? fromJsonT,
  ) => ApiResponse.fromMap(json.decode(source), fromJsonT);

  @override
  List<Object?> get props => [success, message, data];
}
