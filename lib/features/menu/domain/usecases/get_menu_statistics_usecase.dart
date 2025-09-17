import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';
import 'package:tires/features/menu/domain/entities/menu_statistic.dart';

class GetMenuStatisticsUsecase
    implements
        Usecase<ItemSuccessResponse<MenuStatistic>, GetMenuStatisticsParams> {
  final MenuRepository _menuRepository;

  GetMenuStatisticsUsecase(this._menuRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<MenuStatistic>>> call(
    GetMenuStatisticsParams params,
  ) async {
    AppLogger.businessInfo('Executing get menu statistics usecase');
    return await _menuRepository.getMenuStatistics();
  }
}

class GetMenuStatisticsParams extends Equatable {
  @override
  List<Object> get props => [];
}
