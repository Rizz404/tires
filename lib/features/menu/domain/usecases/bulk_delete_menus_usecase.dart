import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class BulkDeleteMenusUsecase
    implements Usecase<ActionSuccess, BulkDeleteMenusUsecaseParams> {
  final MenuRepository _repository;

  BulkDeleteMenusUsecase(this._repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    BulkDeleteMenusUsecaseParams params,
  ) {
    AppLogger.businessInfo(
      'Executing delete menu usecase for id: ${params.id}',
    );
    return _repository.bulkDeleteMenus(params);
  }
}

class BulkDeleteMenusUsecaseParams extends Equatable {
  final List<int> id;

  BulkDeleteMenusUsecaseParams(this.id);

  BulkDeleteMenusUsecaseParams copyWith({List<int>? id}) {
    return BulkDeleteMenusUsecaseParams(id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  factory BulkDeleteMenusUsecaseParams.fromMap(Map<String, dynamic> map) {
    return BulkDeleteMenusUsecaseParams(List<int>.from(map['id']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteMenusUsecaseParams.fromJson(String source) =>
      BulkDeleteMenusUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'BulkDeleteMenusUsecaseParams(id: $id)';
}
