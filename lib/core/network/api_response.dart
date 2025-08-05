import 'dart:convert';

import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final String status;
  final String message;
  final T data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data,
    };
  }

  factory ApiResponse.fromMap(
    Map<String, dynamic> map,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      status: map['status'] as String,
      message: map['message'] as String,
      data: fromJsonT(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ApiResponse(status: $status, message: $message, data: $data)';

  // * copyWith, operator ==, dan hashCode bisa tetap sama (sesuaikan data menjadi T?)
  ApiResponse<T> copyWith({String? status, String? message, T? data}) {
    return ApiResponse<T>(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
