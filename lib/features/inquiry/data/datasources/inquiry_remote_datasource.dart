import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/inquiry/data/models/inquiry_response_model.dart';
import 'package:tires/features/inquiry/domain/usecases/create_inquiry_usecase.dart';

abstract class InquiryRemoteDatasource {
  Future<ApiResponse<InquiryResponseModel>> createInquiry(
    CreateInquiryParams params,
  );
}

class InquiryRemoteDatasourceImpl implements InquiryRemoteDatasource {
  final DioClient _dioClient;

  InquiryRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<InquiryResponseModel>> createInquiry(
    CreateInquiryParams params,
  ) async {
    try {
      final response = await _dioClient.post<InquiryResponseModel>(
        ApiEndpoints.customerInquiry,
        data: params.toMap(),
        fromJson: (json) {
          return InquiryResponseModel.fromMap(json as Map<String, dynamic>);
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
