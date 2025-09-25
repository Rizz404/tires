import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';
import 'package:tires/features/availability/domain/entities/availability_date.dart';
import 'package:tires/features/availability/domain/usecases/get_availability_calendar_usecase.dart';
import 'package:tires/features/availability/domain/usecases/get_reservation_availability_usecase.dart';

abstract class AvailabilityRepository {
  Future<Either<Failure, ItemSuccessResponse<AvailabilityCalendar>>>
  getAvailabilityCalendar(GetAvailabilityCalendarParams params);
  Future<Either<Failure, ItemSuccessResponse<List<AvailabilityDate>>>>
  getReservationAvailability(GetReservationAvailabilityParams params);
}
