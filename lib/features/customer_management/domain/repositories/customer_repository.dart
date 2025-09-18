import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/customer_management/domain/entities/customer_dashboard.dart';
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';

abstract class CustomerRepository {
  Future<Either<Failure, CursorPaginatedSuccess<User>>> getCustomerCursor(
    GetCustomerCursorParams params,
  );
  Future<Either<Failure, ItemSuccessResponse<CustomerDashboard>>>
  getCurrentUserDashboard();
  Future<Either<Failure, ItemSuccessResponse<CustomerStatistic>>>
  getCustomerStatistics();
}
