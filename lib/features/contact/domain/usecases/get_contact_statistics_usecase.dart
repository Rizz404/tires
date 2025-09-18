import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/contact/domain/repositories/contact_repository.dart';
import 'package:tires/features/contact/domain/entities/contact_statistic.dart';

class GetContactStatisticsUsecase
    implements
        Usecase<
          ItemSuccessResponse<ContactStatistic>,
          GetContactStatisticsParams
        > {
  final ContactRepository _contactRepository;

  GetContactStatisticsUsecase(this._contactRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<ContactStatistic>>> call(
    GetContactStatisticsParams params,
  ) async {
    AppLogger.businessInfo('Executing get contact statistics usecase');
    return await _contactRepository.getContactStatistics();
  }
}

class GetContactStatisticsParams extends Equatable {
  @override
  List<Object> get props => [];
}
