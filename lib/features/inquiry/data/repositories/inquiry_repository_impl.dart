import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/network/validation_error_mapper.dart';
import 'package:tires/features/inquiry/data/datasources/inquiry_remote_datasource.dart';
import 'package:tires/features/inquiry/data/mapper/inquiry_response_mapper.dart';
import 'package:tires/features/inquiry/domain/entities/inquiry_response.dart';
import 'package:tires/features/inquiry/domain/repositories/inquiry_repository.dart';
import 'package:tires/features/inquiry/domain/usecases/create_inquiry_usecase.dart';

class InquiryRepositoryImpl implements InquiryRepository {
  final InquiryRemoteDatasource _inquiryRemoteDatasource;

  InquiryRepositoryImpl(this._inquiryRemoteDatasource);

  @override
  Future<Either<Failure, ItemSuccessResponse<InquiryResponse>>> createInquiry(
    CreateInquiryParams params,
  ) async {
    try {
      final result = await _inquiryRemoteDatasource.createInquiry(params);

      final contact = result.data.toEntity();
      return Right(ItemSuccessResponse(data: contact, message: result.message));
    } on ApiErrorResponse catch (e) {
      if (e.errors != null && e.errors!.isNotEmpty) {
        return Left(
          ValidationFailure(
            message: e.message,
            errors: e.errors!
                .map((validationError) => validationError.toEntity())
                .toList(),
          ),
        );
      }
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
