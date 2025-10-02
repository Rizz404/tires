// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
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
  final ContactStatus? status;
  final String? adminReply;

  const UpdateContactParams({required this.id, this.status, this.adminReply});

  UpdateContactParams copyWith({
    int? id,
    ValueGetter<ContactStatus?>? status,
    ValueGetter<String?>? adminReply,
  }) {
    return UpdateContactParams(
      id: id ?? this.id,
      status: status != null ? status() : this.status,
      adminReply: adminReply != null ? adminReply() : this.adminReply,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'status': status?.name, 'adminReply': adminReply};
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, status, adminReply];

  factory UpdateContactParams.fromMap(Map<String, dynamic> map) {
    return UpdateContactParams(
      id: map['id']?.toInt() ?? 0,
      status: map['status'] != null
          ? ContactStatus.values.byName(map['status'])
          : null,
      adminReply: map['adminReply'],
    );
  }

  factory UpdateContactParams.fromJson(String source) =>
      UpdateContactParams.fromMap(json.decode(source));

  @override
  String toString() =>
      'UpdateContactParams(id: $id, status: $status, adminReply: $adminReply)';
}
