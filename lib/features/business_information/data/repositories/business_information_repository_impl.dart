import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/business_information/data/datasources/business_information_remote_datasource.dart';
import 'package:tires/features/business_information/data/mapper/business_information_mapper.dart';
import 'package:tires/features/business_information/domain/repositories/business_information_repository.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';
import 'package:tires/features/business_information/domain/usecases/update_business_information_usecase.dart';

class BusinessInformationRepositoryImpl
    implements BusinessInformationRepository {
  final BusinessInformationRemoteDatasource
  _businessInformationRemoteDatasource;

  BusinessInformationRepositoryImpl(this._businessInformationRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>>
  getBusinessInformation() async {
    try {
      AppLogger.businessInfo('Getting business information in repository');
      final result = await _businessInformationRemoteDatasource
          .getBusinessInformation();

      return Right(
        ItemSuccessResponse<BusinessInformation>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>>
  getPublicBusinessInformation() async {
    try {
      AppLogger.businessInfo(
        'Getting public business information in repository',
      );
      final result = await _businessInformationRemoteDatasource
          .getPublicBusinessInformation();

      return Right(
        ItemSuccessResponse<BusinessInformation>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<BusinessInformation>>>
  updateBusinessInformation(UpdateBusinessInformationParams params) async {
    try {
      AppLogger.businessInfo('Updating business information in repository');
      final result = await _businessInformationRemoteDatasource
          .updateBusinessInformation(params);

      return Right(
        ItemSuccessResponse<BusinessInformation>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
