import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final Logger logger;
  final JsonEncoder _encoder = const JsonEncoder.withIndent('  ');

  LoggerInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
      '🚀 REQUEST[${options.method}] => PATH: ${options.uri}\n'
      'HEADERS: ${options.headers}\n'
      'DATA: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}',
    );
    if (response.data != null) {
      try {
        final prettyJson = _encoder.convert(response.data);
        debugPrint('DATA:\n$prettyJson');
      } catch (e) {
        debugPrint('DATA:\n${response.data}');
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}\n'
      'MESSAGE: ${err.message}',
      error: err,
      stackTrace: err.stackTrace,
    );
    if (err.response?.data != null) {
      try {
        final prettyJson = _encoder.convert(err.response!.data);
        debugPrint('RESPONSE ERROR DATA:\n$prettyJson');
      } catch (e) {
        debugPrint('RESPONSE ERROR DATA:\n${err.response!.data}');
      }
    }
    handler.next(err);
  }
}
