import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/calendar/data/datasources/calendar_remote_datasource.dart';
import 'package:tires/features/calendar/data/mapper/calendar_mapper.dart';
import 'package:tires/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';
import 'package:tires/features/calendar/domain/usecases/get_calendar_data_usecase.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteDatasource _calendarRemoteDatasource;

  CalendarRepositoryImpl(this._calendarRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<CalendarData>>> getCalendarData(
    GetCalendarDataParams params,
  ) async {
    try {
      AppLogger.businessInfo('Fetching calendar data in repository');
      final result = await _calendarRemoteDatasource.getCalendarData(params);
      AppLogger.businessDebug(
        'Calendar data fetched successfully in repository',
      );
      return Right(
        ItemSuccessResponse<CalendarData>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get calendar data', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in get calendar data', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
