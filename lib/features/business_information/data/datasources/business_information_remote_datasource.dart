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
      final response = await _dioClient.get(ApiEndpoints.adminBusinessSettings);
      print('=== DATASOURCE DEBUG ===');
      print('Response data: ${response.data}');
      print('Response data type: ${response.data.runtimeType}');
      print('Response data["data"]: ${response.data["data"]}');
      print('Response data["data"] type: ${response.data["data"].runtimeType}');
      print('=== END DATASOURCE DEBUG ===');

      // Check if response.data already contains the business information directly
      if (response.data['data'] == null) {
        // response.data is already the business information data
        print('=== PARSING DIRECT DATA ===');
        print('Data to parse: ${response.data}');
        print('=== END PARSING ===');

        final businessInfo = BusinessInformationModel.fromMap(response.data);
        return ApiResponse<BusinessInformationModel>(
          status: 'success',
          message: 'Business settings retrieved successfully',
          data: businessInfo,
        );
      } else {
        // response.data contains wrapped structure
        return ApiResponse<BusinessInformationModel>.fromJson(response.data, (
          data,
        ) {
          print('=== PARSING WRAPPED DATA ===');
          print('Data to parse: $data');
          print('Data type: ${data.runtimeType}');
          print('=== END PARSING ===');
          return BusinessInformationModel.fromMap(data);
        });
      }
    } catch (e) {
      AppLogger.networkError('Error fetching business information', e);
      print('=== DATASOURCE ERROR ===');
      print('Error: $e');
      print('Error type: ${e.runtimeType}');
      print('=== END ERROR ===');
      rethrow;
    }
  }

  @override
  Future<ApiResponse<BusinessInformationModel>>
  getPublicBusinessInformation() async {
    try {
      AppLogger.networkInfo('Fetching public business information');
      final response = await _dioClient.get(
        ApiEndpoints.publicBusinessSettings,
      );
      print('=== PUBLIC DATASOURCE DEBUG ===');
      print('Response data: ${response.data}');
      print('Response data type: ${response.data.runtimeType}');
      print('Response data["data"]: ${response.data["data"]}');
      print('Response data["data"] type: ${response.data["data"].runtimeType}');
      print('=== END PUBLIC DATASOURCE DEBUG ===');

      // Check if response.data already contains the business information directly
      if (response.data['data'] == null) {
        // response.data is already the business information data
        print('=== PARSING DIRECT PUBLIC DATA ===');
        print('Data to parse: ${response.data}');
        print('=== END PARSING ===');

        final businessInfo = BusinessInformationModel.fromMap(response.data);
        return ApiResponse<BusinessInformationModel>(
          status: 'success',
          message: 'Public business settings retrieved successfully',
          data: businessInfo,
        );
      } else {
        // response.data contains wrapped structure
        return ApiResponse<BusinessInformationModel>.fromJson(response.data, (
          data,
        ) {
          print('=== PARSING WRAPPED PUBLIC DATA ===');
          print('Data to parse: $data');
          print('Data type: ${data.runtimeType}');
          print('=== END PARSING ===');
          return BusinessInformationModel.fromMap(data);
        });
      }
    } catch (e) {
      AppLogger.networkError('Error fetching public business information', e);
      print('=== PUBLIC DATASOURCE ERROR ===');
      print('Error: $e');
      print('Error type: ${e.runtimeType}');
      print('=== END ERROR ===');
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

      // Add non-file fields
      final mapData = params.toMap();
      mapData.forEach((key, value) {
        if (value != null) {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      // Add file if exists
      if (params.topImage != null) {
        final fileName = params.topImage!.path.split('/').last;
        formData.files.add(
          MapEntry(
            'top_image',
            await MultipartFile.fromFile(
              params.topImage!.path,
              filename: fileName,
            ),
          ),
        );
      }

      final response = await _dioClient.patch(
        ApiEndpoints.adminBusinessSettings,
        data: formData,
      );
      return ApiResponse<BusinessInformationModel>.fromJson(
        response.data,
        (data) => BusinessInformationModel.fromMap(data),
      );
    } catch (e) {
      AppLogger.networkError('Error updating business information', e);
      rethrow;
    }
  }
}
