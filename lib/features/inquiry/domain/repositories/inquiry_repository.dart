import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/inquiry/domain/entities/contact.dart';

abstract class InquiryRepository {
  Future<Either<Failure, ItemSuccessResponse<Contact>>> createInquiry({
    required String name,
    required String email,
    String? phone,
    required String subject,
    required String message,
  });
}
