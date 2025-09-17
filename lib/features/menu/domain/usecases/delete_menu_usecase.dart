import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class DeleteMenuUsecase implements Usecase<ActionSuccess, DeleteMenuParams> {
  final MenuRepository _repository;

  DeleteMenuUsecase(this._repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(DeleteMenuParams params) {
    AppLogger.businessInfo(
      'Executing delete menu usecase for id: ${params.id}',
    );
    return _repository.deleteMenu(params);
  }
}

class DeleteMenuParams extends Equatable {
  final int id;

  DeleteMenuParams(this.id);

  DeleteMenuParams copyWith({int? id}) {
    return DeleteMenuParams(id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }

  factory DeleteMenuParams.fromMap(Map<String, dynamic> map) {
    return DeleteMenuParams(map['id'] as int);
  }

  String toJson() => json.encode(toMap());

  factory DeleteMenuParams.fromJson(String source) =>
      DeleteMenuParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}
