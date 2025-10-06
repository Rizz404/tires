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
      'Executing delete contact usecase for ids: ${params.ids}',
    );
    return _repository.bulkDeleteContacts(params);
  }
}

class BulkDeleteContactsUsecaseParams extends Equatable {
  final List<int> ids;

  BulkDeleteContactsUsecaseParams(this.ids);

  BulkDeleteContactsUsecaseParams copyWith({List<int>? ids}) {
    return BulkDeleteContactsUsecaseParams(ids ?? this.ids);
  }

  Map<String, dynamic> toMap() {
    return {'ids': ids};
  }

  factory BulkDeleteContactsUsecaseParams.fromMap(Map<String, dynamic> map) {
    return BulkDeleteContactsUsecaseParams(List<int>.from(map['ids']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteContactsUsecaseParams.fromJson(String source) =>
      BulkDeleteContactsUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ids];

  @override
  String toString() => 'BulkDeleteContactsUsecaseParams(ids: $ids)';
}
