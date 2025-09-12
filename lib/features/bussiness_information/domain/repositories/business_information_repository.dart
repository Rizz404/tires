import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/bussiness_information/domain/entities/business_information.dart';

abstract class BusinessInformationRepository {
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>>
  getBusinessInformation();
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>>
  updateBusinessInformation(Map<String, dynamic> params);
}
