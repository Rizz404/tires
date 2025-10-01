import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/contact/domain/repositories/contact_repository.dart';

class BulkDeleteContactsUsecase
    implements Usecase<ActionSuccess, BulkDeleteContactsUsecaseParams> {
  final ContactRepository _repository;

  BulkDeleteContactsUsecase(this._repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    BulkDeleteContactsUsecaseParams params,
  ) {
    AppLogger.businessInfo(
      'Executing delete contact usecase for id: ${params.id}',
    );
    return _repository.bulkDeleteContacts(params);
  }
}

class BulkDeleteContactsUsecaseParams extends Equatable {
  final List<int> id;

  BulkDeleteContactsUsecaseParams(this.id);

  BulkDeleteContactsUsecaseParams copyWith({List<int>? id}) {
    return BulkDeleteContactsUsecaseParams(id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  factory BulkDeleteContactsUsecaseParams.fromMap(Map<String, dynamic> map) {
    return BulkDeleteContactsUsecaseParams(List<int>.from(map['id']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteContactsUsecaseParams.fromJson(String source) =>
      BulkDeleteContactsUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'BulkDeleteContactsUsecaseParams(id: $id)';
}
