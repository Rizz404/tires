import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/inquiry/domain/entities/inquiry_response.dart';
import 'package:tires/features/inquiry/domain/usecases/create_inquiry_usecase.dart';

abstract class InquiryRepository {
  Future<Either<Failure, ItemSuccessResponse<InquiryResponse>>> createInquiry(
    CreateInquiryParams params,
  );
}
