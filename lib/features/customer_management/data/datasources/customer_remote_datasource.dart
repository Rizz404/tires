import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/customer_management/data/models/customer_model.dart';
import 'package:tires/features/customer_management/data/models/customer_dashboard_model.dart';
import 'package:tires/features/customer_management/data/models/customer_detail_model.dart'
    as detail;
import 'package:tires/features/customer_management/data/models/customer_statistic_model.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customers_cursor_usecase.dart';

abstract class CustomerRemoteDatasource {
  Future<ApiCursorPaginationResponse<CustomerModel>> getCustomersCursor(
    GetCustomerCursorParams params,
  );
  Future<ApiResponse<CustomerDashboardModel>> getCurrentUserDashboard();
  Future<ApiResponse<CustomerStatisticModel>> getCustomerStatistics();
  Future<ApiResponse<detail.CustomerDetailModel>> getCustomerDetail(int id);
}

class CustomerRemoteDatasourceImpl implements CustomerRemoteDatasource {
  final DioClient _dioClient;

  CustomerRemoteDatasourceImpl(this._dioClient);

  @override
  Future<ApiCursorPaginationResponse<CustomerModel>> getCustomersCursor(
    GetCustomerCursorParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching customer cursor');
      final response = await _dioClient.getWithCursor<CustomerModel>(
        ApiEndpoints.adminCustomers,
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
      rethrow;
    }
  }

  @override
  Future<ApiResponse<CustomerStatisticModel>> getCustomerStatistics() async {
    try {
      AppLogger.networkInfo('Fetching customer statistics');
      final response = await _dioClient.get<CustomerStatisticModel>(
        ApiEndpoints.adminCustomerStatistics,
        fromJson: (data) => CustomerStatisticModel.fromMap(data),
      );
      AppLogger.networkDebug('Customer statistics fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching customer statistics', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<detail.CustomerDetailModel>> getCustomerDetail(
    int id,
  ) async {
    try {
      AppLogger.networkInfo('Fetching customer detail for id: $id');
      final response = await _dioClient.get<detail.CustomerDetailModel>(
        '${ApiEndpoints.adminCustomers}/$id',
        fromJson: (data) => detail.CustomerDetailModel.fromMap(data),
      );
      AppLogger.networkDebug('Customer detail fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching customer detail', e);
      rethrow;
    }
  }
}
