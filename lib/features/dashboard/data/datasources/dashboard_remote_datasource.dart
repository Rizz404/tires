import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/dashboard/data/models/dashboard_model.dart';

abstract class DashboardRemoteDataSource {
  Future<ApiResponse<DashboardModel>> getDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient _dioClient;

  DashboardRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ApiResponse<DashboardModel>> getDashboard() async {
    try {
      AppLogger.networkInfo('Fetching dashboard');
      final response = await _dioClient.get<DashboardModel>(
        ApiEndpoints.adminDashboard,
        fromJson: (data) {
          return DashboardModel.fromMap(data);
        },
      );
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching dashboard', e);
      rethrow;
    }
  }
}
