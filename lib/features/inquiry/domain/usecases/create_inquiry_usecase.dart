import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/inquiry/domain/entities/inquiry_response.dart';
import 'package:tires/features/inquiry/domain/repositories/inquiry_repository.dart';

class CreateInquiryUsecase
    implements
        Usecase<ItemSuccessResponse<InquiryResponse>, CreateInquiryParams> {
  final InquiryRepository _inquiryRepository;

  CreateInquiryUsecase(this._inquiryRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<InquiryResponse>>> call(
    CreateInquiryParams params,
  ) async {
    return await _inquiryRepository.createInquiry(params);
  }
}

class CreateInquiryParams extends Equatable {
  final String name;
  final String email;
  final String? phone;
  final String subject;
  final String message;

  const CreateInquiryParams({
    required this.name,
    required this.email,
    this.phone,
    required this.subject,
    required this.message,
  });

  @override
  List<Object?> get props => [name, email, phone, subject, message];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      if (phone != null) 'phone': phone,
      'subject': subject,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());
}
