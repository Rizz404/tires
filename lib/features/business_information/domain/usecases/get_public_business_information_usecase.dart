import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/business_information/domain/repositories/business_information_repository.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';

class GetPublicBusinessInformationUsecase
    implements Usecase<ItemSuccessResponse<BusinessInformation>, NoParams> {
  final BusinessInformationRepository _repository;

  GetPublicBusinessInformationUsecase(this._repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>> call(
    NoParams params,
  ) async {
    AppLogger.businessInfo('Executing get public business information usecase');
    return await _repository.getPublicBusinessInformation();
  }
}
