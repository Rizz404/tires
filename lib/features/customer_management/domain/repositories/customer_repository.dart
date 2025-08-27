import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';

abstract class CustomerRepository {
  Future<Either<Failure, CursorPaginatedSuccess<Customer>>> getCustomerCursor(
    GetCustomerCursorParams params,
  );
}
