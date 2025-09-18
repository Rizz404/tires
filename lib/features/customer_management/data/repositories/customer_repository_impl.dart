import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/customer_management/data/datasources/customer_remote_datasource.dart';
import 'package:tires/features/customer_management/data/mapper/customer_dashboard_mapper.dart';
import 'package:tires/features/customer_management/data/mapper/customer_statistic_mapper.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/customer_management/domain/entities/customer_dashboard.dart';
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDatasource _customerRemoteDatasource;

  CustomerRepositoryImpl(this._customerRemoteDatasource);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<User>>> getCustomerCursor(
    GetCustomerCursorParams params,
  ) async {
    try {
      AppLogger.businessInfo('Getting customer cursor in repository');
      final result = await _customerRemoteDatasource.getCustomerCursor(params);

      return Right(
        CursorPaginatedSuccess<User>(
          data: result.data.map((user) => user.toEntity()).toList(),
          cursor: result.cursor?.toEntity(),
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  @override
  Future<Either<Failure, ItemSuccessResponse<CustomerDashboard>>>
  getCurrentUserDashboard() async {
    try {
      AppLogger.businessInfo('Getting current user dashboard in repository');
      final result = await _customerRemoteDatasource.getCurrentUserDashboard();

      final dashboard = result.data.toEntity();
      return Right(
        ItemSuccessResponse(data: dashboard, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<CustomerStatistic>>>
  getCustomerStatistics() async {
    try {
      AppLogger.businessInfo('Getting customer statistics in repository');
      final result = await _customerRemoteDatasource.getCustomerStatistics();

      final statistics = result.data.toEntity();
      return Right(
        ItemSuccessResponse(data: statistics, message: result.message),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get customer statistics', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in get customer statistics', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
