import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';

class UpdateBlockedPeriodUsecase
    implements
        Usecase<ItemSuccessResponse<BlockedPeriod>, UpdateBlockedPeriodParams> {
  final BlockedPeriodRepository repository;

  UpdateBlockedPeriodUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<BlockedPeriod>>> call(
    UpdateBlockedPeriodParams params,
  ) {
    AppLogger.businessInfo('Executing update blocked period usecase');
    return repository.updateBlockedPeriod(params);
  }
}
