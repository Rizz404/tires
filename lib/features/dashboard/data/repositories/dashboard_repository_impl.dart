import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';
import 'package:tires/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ItemSuccessResponse<Dashboard>>> getDashboard() async {
    try {
      AppLogger.businessInfo('Getting dashboard in repository');
      final result = await _remoteDataSource.getDashboard();
      return Right(
        ItemSuccessResponse<Dashboard>(
          data: result.data,
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
