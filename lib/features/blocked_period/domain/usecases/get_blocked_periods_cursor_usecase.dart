import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';

class GetBlockedPeriodsCursorUsecase
    implements
        Usecase<
          CursorPaginatedSuccess<BlockedPeriod>,
          GetBlockedPeriodsCursorParams
        > {
  final BlockedPeriodRepository repository;

  GetBlockedPeriodsCursorUsecase(this.repository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<BlockedPeriod>>> call(
    GetBlockedPeriodsCursorParams params,
  ) {
    AppLogger.businessInfo('Executing get blocked periods cursor usecase');
    return repository.getBlockedPeriodsCursor(params);
  }
}
