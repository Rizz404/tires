import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/constants/api_constants.dart';
import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/network/api_offset_pagination_response.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/locale_interceptor.dart';

class DioClient {
  final Dio _dio;
  LocaleInterceptor _localeInterceptor;

  DioClient(this._dio) : _localeInterceptor = LocaleInterceptor() {
    _dio
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = const Duration(
        milliseconds: ApiConstants.defaultConnectTimeout,
      )
      ..options.receiveTimeout = const Duration(
        milliseconds: ApiConstants.defaultReceiveTimeout,
      )
      ..options.responseType = ResponseType.json
      ..interceptors.add(_localeInterceptor)
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            const String? token = null;
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onError: (error, handler) {
            return handler.next(error);
          },
        ),
      );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
  }

  // * Buat update bahasa
  void updateLocale(Locale locale) {
    _localeInterceptor.updateLocale(locale);
  }

  // * GET dengan single ApiResponse
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return ApiResponse.fromMap(
        response.data as Map<String, dynamic>,
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // * Get plain
  Future<dynamic> getPlain(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // * GET dengan offset pagination
  Future<ApiOffsetPaginationResponse<T>> getWithOffset<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return ApiOffsetPaginationResponse.fromMap(
        response.data as Map<String, dynamic>,
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // * GET dengan cursor pagination
  Future<ApiCursorPaginationResponse<T>> getWithCursor<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return ApiCursorPaginationResponse.fromMap(
        response.data as Map<String, dynamic>,
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // * POST method
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return ApiResponse.fromMap(
        response.data as Map<String, dynamic>,
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // * PUT method
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return ApiResponse.fromMap(
        response.data as Map<String, dynamic>,
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // * PATCH method
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return ApiResponse.fromMap(
        response.data as Map<String, dynamic>,
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // * DELETE method
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return ApiResponse.fromMap(
        response.data as Map<String, dynamic>,
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // * Error handling
  ApiErrorResponse _handleError(DioException error) {
    if (error.response != null && error.response!.data != null) {
      try {
        return ApiErrorResponse.fromMap(
          error.response!.data as Map<String, dynamic>,
        );
      } catch (e) {
        return ApiErrorResponse(
          message: error.response!.statusMessage ?? 'Unknown error occurred',
          code: error.response!.statusCode,
        );
      }
    } else {
      return ApiErrorResponse(
        message: error.message ?? 'Network error occurred',
        code: error.response?.statusCode,
      );
    }
  }
}
