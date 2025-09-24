import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/availability/domain/entities/availability_date.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';

class GetReservationAvailabilityUsecase
    implements Usecase<ItemSuccessResponse<List<AvailabilityDate>>, NoParams> {
  final AvailabilityRepository _availabilityRepository;

  GetReservationAvailabilityUsecase(this._availabilityRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<List<AvailabilityDate>>>> call(
    NoParams params,
  ) async {
    return await _availabilityRepository.getReservationAvailability();
  }
}
