import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';
import 'package:tires/features/calendar/domain/usecases/get_calendar_data_usecase.dart';

abstract class CalendarRepository {
  Future<Either<Failure, ItemSuccessResponse<CalendarData>>> getCalendarData(
    GetCalendarDataParams params,
  );
}
