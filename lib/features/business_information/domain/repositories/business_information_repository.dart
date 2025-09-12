import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';
import 'package:tires/features/business_information/domain/usecases/update_business_information_usecase.dart';

abstract class BusinessInformationRepository {
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>>
  getBusinessInformation();
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>>
  updateBusinessInformation(UpdateBusinessInformationParams params);
}
