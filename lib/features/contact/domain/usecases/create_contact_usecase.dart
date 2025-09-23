import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/contact/domain/repositories/contact_repository.dart';

class CreateContactUsecase
    implements Usecase<ItemSuccessResponse<Contact>, CreateContactParams> {
  final ContactRepository repository;

  CreateContactUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Contact>>> call(
    CreateContactParams params,
  ) {
    AppLogger.businessInfo('Executing create contact usecase');
    return repository.createContact(params);
  }
}

class CreateContactParams extends Equatable {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String subject;
  final String message;

  const CreateContactParams({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.subject,
    required this.message,
  });

  CreateContactParams copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? subject,
    String? message,
  }) {
    return CreateContactParams(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      subject: subject ?? this.subject,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'subject': subject,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [fullName, email, phoneNumber, subject, message];
}
