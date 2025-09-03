import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/customer_management/domain/entities/customer_dashboard.dart';
import 'package:tires/features/user/domain/repositories/current_user_repository.dart';

class GetCurrentUserDashboardUsecase
    implements Usecase<ItemSuccessResponse<CustomerDashboard>, NoParams> {
  final CurrentUserRepository _userRepository;

  GetCurrentUserDashboardUsecase(this._userRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<CustomerDashboard>>> call(
    NoParams params,
  ) async {
    return await _userRepository.getCurrentUserDashboard();
  }
}
