import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';

class GetAvailabilityCalendarParams extends Equatable {
  final String menuId;
  final String currentMonth;
  final bool paginate;

  const GetAvailabilityCalendarParams({
    required this.menuId,
    required this.currentMonth,
    this.paginate = true,
  });

  @override
  List<Object> get props => [menuId, currentMonth, paginate];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'menu_id': menuId,
      'current_month': currentMonth,
      'paginate': paginate.toString(),
    };
  }

  String toJson() => json.encode(toMap());
}

class GetAvailabilityCalendarUsecase
    implements
        Usecase<
          ItemSuccessResponse<AvailabilityCalendar>,
          GetAvailabilityCalendarParams
        > {
  final AvailabilityRepository _availabilityRepository;

  GetAvailabilityCalendarUsecase(this._availabilityRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailabilityCalendar>>> call(
    GetAvailabilityCalendarParams params,
  ) async {
    AppLogger.businessInfo('Executing get availability calendar usecase');
    return await _availabilityRepository.getAvailabilityCalendar(params);
  }
}
