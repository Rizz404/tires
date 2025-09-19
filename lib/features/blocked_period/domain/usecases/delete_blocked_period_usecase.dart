import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';

class DeleteBlockedPeriodUsecase
    implements Usecase<ActionSuccess, DeleteBlockedPeriodParams> {
  final BlockedPeriodRepository repository;

  DeleteBlockedPeriodUsecase(this.repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    DeleteBlockedPeriodParams params,
  ) {
    AppLogger.businessInfo('Executing delete blocked period usecase');
    return repository.deleteBlockedPeriod(params);
  }
}
