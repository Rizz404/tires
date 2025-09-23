import 'package:dio/dio.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/business_information/data/models/business_information_model.dart';
import 'package:tires/features/business_information/domain/usecases/update_business_information_usecase.dart';

abstract class BusinessInformationRemoteDatasource {
  Future<ApiResponse<BusinessInformationModel>> getBusinessInformation();
  Future<ApiResponse<BusinessInformationModel>> getPublicBusinessInformation();
  Future<ApiResponse<BusinessInformationModel>> updateBusinessInformation(
    UpdateBusinessInformationParams params,
  );
}

class BusinessInformationRemoteDatasourceImpl
    implements BusinessInformationRemoteDatasource {
  final DioClient _dioClient;

  BusinessInformationRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<BusinessInformationModel>> getBusinessInformation() async {
    try {
      AppLogger.networkInfo('Fetching business information');
      final response = await _dioClient.get<BusinessInformationModel>(
        ApiEndpoints.adminBusinessSettings,
        fromJson: (data) => BusinessInformationModel.fromMap(data),
      );
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching business information', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<BusinessInformationModel>>
  getPublicBusinessInformation() async {
    try {
      AppLogger.networkInfo('Fetching public business information');
      final response = await _dioClient.get<BusinessInformationModel>(
        ApiEndpoints.publicBusinessSettings,
        fromJson: (data) => BusinessInformationModel.fromMap(data),
      );
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching public business information', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<BusinessInformationModel>> updateBusinessInformation(
    UpdateBusinessInformationParams params,
  ) async {
    try {
      AppLogger.networkInfo('Updating business information');
      final formData = FormData();

      // Add non-file fields with proper encoding for multipart
      final mapData = params.toMap();

      String _normalizeTime(dynamic v) {
        if (v == null) return '';
        final s = v.toString();
        final match = RegExp(r'TimeOfDay\((\d{1,2}):(\d{2})\)').firstMatch(s);
        if (match != null) {
          final h = match.group(1)!.padLeft(2, '0');
          final m = match.group(2)!.padLeft(2, '0');
          return '$h:$m';
        }
        // Already "HH:mm" or other format
        return s;
      }

      void addField(String key, dynamic value) {
        if (value == null) return;
        if (value is bool) {
          formData.fields.add(MapEntry(key, value ? '1' : '0'));
        } else {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      }

      for (final entry in mapData.entries) {
        final key = entry.key;
        final value = entry.value;

        if (key == 'business_hours' && value is Map) {
          // Flatten nested map into Laravel-style bracketed keys
          value.forEach((dayKey, dayVal) {
            if (dayVal is Map) {
              final closed = dayVal['closed'];
              final openTime = dayVal['open_time'];
              final closeTime = dayVal['close_time'];
              addField('business_hours[$dayKey][closed]', closed);
              if (closed == false || closed == '0' || closed == 0) {
                if (openTime != null) {
                  addField(
                    'business_hours[$dayKey][open_time]',
                    _normalizeTime(openTime),
                  );
                }
                if (closeTime != null) {
                  addField(
                    'business_hours[$dayKey][close_time]',
                    _normalizeTime(closeTime),
                  );
                }
              }
            } else {
              // If dayVal is not a map, just stringify
              addField('business_hours[$dayKey]', dayVal);
            }
          });
        } else {
          addField(key, value);
        }
      }

      // Debug: log fields being sent (without files)
      try {
        for (final f in formData.fields) {
          AppLogger.networkInfo('Form field => ${f.key}=${f.value}');
        }
      } catch (_) {}

      // Add file if exists
      if (params.topImage != null) {
        // Handle Windows and POSIX paths safely
        final filePath = params.topImage!.path;
        final fileName = filePath.split('\\').last.split('/').last;
        formData.files.add(
          MapEntry(
            'top_image',
            await MultipartFile.fromFile(filePath, filename: fileName),
          ),
        );
      }

      final response = await _dioClient.patch<BusinessInformationModel>(
        '${ApiEndpoints.adminBusinessSettings}/update',
        data: formData,
        fromJson: (data) => BusinessInformationModel.fromMap(data),
      );
      return response;
    } catch (e) {
      AppLogger.networkError('Error updating business information', e);
      rethrow;
    }
  }
}
