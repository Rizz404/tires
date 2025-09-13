import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/availability/data/datasources/availability_remote_datasource.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';
import 'package:tires/features/availability/domain/usecases/get_availability_calendar_usecase.dart';

class AvailabilityRepositoryImpl implements AvailabilityRepository {
  final AvailabilityRemoteDatasource _availabilityRemoteDatasource;

  AvailabilityRepositoryImpl(this._availabilityRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<AvailabilityCalendar>>>
  getAvailabilityCalendar(GetAvailabilityCalendarParams params) async {
    return await _availabilityRemoteDatasource.getAvailabilityCalendar(params);
  }
}
