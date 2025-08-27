import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';

abstract class AvailabilityRepository {
  Future<Either<Failure, ItemSuccessResponse<AvailabilityCalendar>>>
  getAvailabilityCalendar({
    required String menuId,
    required String currentMonth,
    bool paginate = true,
  });
}
