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
      final response = await _dioClient.patch<BusinessInformationModel>(
        '${ApiEndpoints.adminBusinessSettings}/update',
        data: params.toMap(),
        fromJson: (data) => BusinessInformationModel.fromMap(data),
      );
      return response;
    } catch (e) {
      AppLogger.networkError('Error updating business information', e);
      rethrow;
    }
  }
}
