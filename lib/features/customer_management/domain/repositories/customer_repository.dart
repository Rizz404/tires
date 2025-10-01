import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart'
    as customer;
import 'package:tires/features/customer_management/domain/entities/customer_dashboard.dart';
import 'package:tires/features/customer_management/domain/entities/customer_detail.dart'
    as customer_for_detail;
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';
import 'package:tires/features/customer_management/domain/usecases/bulk_delete_customers_usecase.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_detail_usecase.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customers_cursor_usecase.dart';

abstract class CustomerRepository {
  Future<Either<Failure, CursorPaginatedSuccess<customer.Customer>>>
  getCustomersCursor(GetCustomerCursorParams params);
  Future<
    Either<Failure, ItemSuccessResponse<customer_for_detail.CustomerDetail>>
  >
  getCustomerDetail(GetCustomerDetailParams params);
  Future<Either<Failure, ItemSuccessResponse<CustomerDashboard>>>
  getCurrentUserDashboard();
  Future<Either<Failure, ItemSuccessResponse<CustomerStatistic>>>
  getCustomerStatistics();
  Future<Either<Failure, ActionSuccess>> bulkDeleteCustomers(
    BulkDeleteCustomersUsecaseParams params,
  );
}
