import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';

class CreateBlockedPeriodUsecase
    implements
        Usecase<ItemSuccessResponse<BlockedPeriod>, CreateBlockedPeriodParams> {
  final BlockedPeriodRepository repository;

  CreateBlockedPeriodUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<BlockedPeriod>>> call(
    CreateBlockedPeriodParams params,
  ) {
    AppLogger.businessInfo('Executing create blocked period usecase');
    return repository.createBlockedPeriod(params);
  }
}
