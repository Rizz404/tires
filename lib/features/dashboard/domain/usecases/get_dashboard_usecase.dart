import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';
import 'package:tires/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardUsecase
    implements Usecase<ItemSuccessResponse<Dashboard>, NoParams> {
  final DashboardRepository _dashboardRepository;

  GetDashboardUsecase(this._dashboardRepository);
  @override
  Future<Either<Failure, ItemSuccessResponse<Dashboard>>> call(
    NoParams params,
  ) async {
    return await _dashboardRepository.getDashboard();
  }
}
