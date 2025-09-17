// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/customer_management/data/models/customer_dashboard_model.dart';
import 'package:tires/features/customer_management/data/models/customer_model.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';

abstract class CustomerRemoteDatasource {
  Future<ApiCursorPaginationResponse<CustomerModel>> getCustomerCursor(
    GetCustomerCursorParams params,
  );
  Future<ApiResponse<CustomerDashboardModel>> getCurrentUserDashboard();
}

class CustomerRemoteDatasourceImpl implements CustomerRemoteDatasource {
  final DioClient _dioClient;

  CustomerRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<CustomerModel>> getCustomerCursor(
    GetCustomerCursorParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching customer cursor');
      final response = await _dioClient.getWithCursor<CustomerModel>(
        "/customers",
        fromJson: (item) => CustomerModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );

      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching customer cursor', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<CustomerDashboardModel>> getCurrentUserDashboard() async {
    try {
      AppLogger.networkInfo('Fetching current user dashboard');
      final response = await _dioClient.get<CustomerDashboardModel>(
        ApiEndpoints.customerDashboard,
        fromJson: (json) {
          return CustomerDashboardModel.fromMap(json as Map<String, dynamic>);
        },
      );

      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching current user dashboard', e);
      print('Error in getCurrentUserDashboard: $e');
      rethrow;
    }
  }
}
