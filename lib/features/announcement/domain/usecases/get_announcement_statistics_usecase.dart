import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/announcement/domain/entities/announcement_statistic.dart';

class GetAnnouncementStatisticsUsecase
    implements
        Usecase<
          ItemSuccessResponse<AnnouncementStatistic>,
          GetAnnouncementStatisticsParams
        > {
  final AnnouncementRepository _announcementRepository;

  GetAnnouncementStatisticsUsecase(this._announcementRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<AnnouncementStatistic>>> call(
    GetAnnouncementStatisticsParams params,
  ) async {
    return await _announcementRepository.getAnnouncementStatistics();
  }
}

class GetAnnouncementStatisticsParams extends Equatable {
  @override
  List<Object> get props => [];
}
