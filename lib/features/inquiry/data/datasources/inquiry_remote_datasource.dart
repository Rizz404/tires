import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/features/inquiry/data/models/inquiry_response_model.dart';

abstract class InquiryRemoteDatasource {
  Future<ApiResponse<InquiryResponseModel>> createInquiry({
    required String name,
    required String email,
    String? phone,
    required String subject,
    required String message,
  });
}

class InquiryRemoteDatasourceImpl implements InquiryRemoteDatasource {
  final DioClient _dioClient;

  InquiryRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiResponse<InquiryResponseModel>> createInquiry({
    required String name,
    required String email,
    String? phone,
    required String subject,
    required String message,
  }) async {
    try {
      final data = {
        "name": name,
        "email": email,
        if (phone != null) "phone": phone,
        "subject": subject,
        "message": message,
      };

      final response = await _dioClient.post<InquiryResponseModel>(
        ApiEndpoints.customerInquiry,
        data: data,
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
