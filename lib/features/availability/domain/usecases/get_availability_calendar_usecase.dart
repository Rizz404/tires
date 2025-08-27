import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';

class GetAvailabilityCalendarParams {
  final String menuId;
  final String currentMonth;
  final bool paginate;

  GetAvailabilityCalendarParams({
    required this.menuId,
    required this.currentMonth,
    this.paginate = true,
  });
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
    return await _availabilityRepository.getAvailabilityCalendar(
      menuId: params.menuId,
      currentMonth: params.currentMonth,
      paginate: params.paginate,
    );
  }
}
