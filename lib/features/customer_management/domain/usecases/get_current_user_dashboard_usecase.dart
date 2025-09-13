import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/customer_management/domain/entities/customer_dashboard.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';

class GetCurrentUserDashboardUsecase
    implements Usecase<ItemSuccessResponse<CustomerDashboard>, NoParams> {
  final CustomerRepository _customerRepository;

  GetCurrentUserDashboardUsecase(this._customerRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<CustomerDashboard>>> call(
    NoParams params,
  ) async {
    return await _customerRepository.getCurrentUserDashboard();
  }
}
