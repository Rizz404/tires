// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/contact/domain/repositories/contact_repository.dart';

class UpdateContactUsecase
    implements Usecase<ItemSuccessResponse<Contact>, UpdateContactParams> {
  final ContactRepository repository;

  UpdateContactUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Contact>>> call(
    UpdateContactParams params,
  ) {
    AppLogger.businessInfo(
      'Executing update contact usecase for id: ${params.id}',
    );
    return repository.updateContact(params);
  }
}

class UpdateContactParams extends Equatable {
  final int id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? subject;
  final String? message;

  const UpdateContactParams({
    required this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.subject,
    this.message,
  });

  UpdateContactParams copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? subject,
    String? message,
  }) {
    return UpdateContactParams(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      subject: subject ?? this.subject,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'subject': subject,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, fullName, email, phoneNumber, subject, message];
  }

  factory UpdateContactParams.fromMap(Map<String, dynamic> map) {
    return UpdateContactParams(
      id: map['id'] as int,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phoneNumber'] != null
          ? map['phoneNumber'] as String
          : null,
      subject: map['subject'] != null ? map['subject'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  factory UpdateContactParams.fromJson(String source) =>
      UpdateContactParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
