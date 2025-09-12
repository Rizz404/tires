import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/bussiness_information/data/models/business_information_model.dart';

abstract class BusinessInformationRemoteDatasource {
  Future<ApiResponse<BusinessInformationModel>> getBusinessInformation();
  Future<ApiResponse<BusinessInformationModel>> updateBusinessInformation(
    Map<String, dynamic> params,
  );
}

class BusinessInformationRemoteDatasourceImpl
    implements BusinessInformationRemoteDatasource {
  final DioClient _dioClient;

  BusinessInformationRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<BusinessInformationModel>> getBusinessInformation() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.adminBusinessSettings);
      return ApiResponse<BusinessInformationModel>.fromJson(
        response.data,
        (data) => BusinessInformationModel.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<BusinessInformationModel>> updateBusinessInformation(
    Map<String, dynamic> params,
  ) async {
    try {
      final response = await _dioClient.patch(
        ApiEndpoints.adminBusinessSettings,
        data: params,
      );
      return ApiResponse<BusinessInformationModel>.fromJson(
        response.data,
        (data) => BusinessInformationModel.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}
