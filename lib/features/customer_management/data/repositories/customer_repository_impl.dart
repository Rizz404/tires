import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/features/customer_management/data/datasources/customer_remote_datasource.dart';
import 'package:tires/features/customer_management/data/mapper/customer_mapper.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';
import 'package:tires/features/customer_management/domain/usecases/get_customer_cursor_usecase.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDatasource _customerRemoteDatasource;

  CustomerRepositoryImpl(this._customerRemoteDatasource);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Customer>>> getCustomerCursor(
    GetCustomerCursorParams params,
  ) async {
    try {
      final result = await _customerRemoteDatasource.getCustomerCursor(params);

      return Right(
        CursorPaginatedSuccess<Customer>(
          data: result.data.map((customer) => customer.toEntity()).toList(),
          cursor: result.cursor?.toEntity(),
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
