import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/contact/domain/repositories/contact_repository.dart';

class DeleteContactUsecase
    implements Usecase<ActionSuccess, DeleteContactParams> {
  final ContactRepository _repository;

  DeleteContactUsecase(this._repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(DeleteContactParams params) {
    AppLogger.businessInfo(
      'Executing delete contact usecase for id: ${params.id}',
    );
    return _repository.deleteContact(params);
  }
}

class DeleteContactParams extends Equatable {
  final int id;

  DeleteContactParams(this.id);

  DeleteContactParams copyWith({int? id}) {
    return DeleteContactParams(id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }

  factory DeleteContactParams.fromMap(Map<String, dynamic> map) {
    return DeleteContactParams(map['id'] as int);
  }

  String toJson() => json.encode(toMap());

  factory DeleteContactParams.fromJson(String source) =>
      DeleteContactParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}
