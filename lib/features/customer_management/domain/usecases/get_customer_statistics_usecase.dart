import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';

class GetCustomerStatisticsUsecase
    implements Usecase<ItemSuccessResponse<CustomerStatistic>, NoParams> {
  final CustomerRepository _customerRepository;

  GetCustomerStatisticsUsecase(this._customerRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<CustomerStatistic>>> call(
    NoParams params,
  ) async {
    AppLogger.businessInfo('Executing get customer statistics usecase');
    return await _customerRepository.getCustomerStatistics();
  }
}
