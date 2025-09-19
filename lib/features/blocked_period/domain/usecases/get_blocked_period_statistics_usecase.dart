import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_statistic.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';

class GetBlockedPeriodStatisticsUsecase
    implements Usecase<ItemSuccessResponse<BlockedPeriodStatistic>, NoParams> {
  final BlockedPeriodRepository repository;

  GetBlockedPeriodStatisticsUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<BlockedPeriodStatistic>>> call(
    NoParams params,
  ) {
    AppLogger.businessInfo('Executing get blocked period statistics usecase');
    return repository.getBlockedPeriodStatistics();
  }
}
