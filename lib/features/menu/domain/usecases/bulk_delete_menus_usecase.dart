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
      'Executing delete menu usecase for ids: ${params.ids}',
    );
    return _repository.bulkDeleteMenus(params);
  }
}

class BulkDeleteMenusUsecaseParams extends Equatable {
  final List<int> ids;

  BulkDeleteMenusUsecaseParams(this.ids);

  BulkDeleteMenusUsecaseParams copyWith({List<int>? ids}) {
    return BulkDeleteMenusUsecaseParams(ids ?? this.ids);
  }

  Map<String, dynamic> toMap() {
    return {'ids': ids};
  }

  factory BulkDeleteMenusUsecaseParams.fromMap(Map<String, dynamic> map) {
    return BulkDeleteMenusUsecaseParams(List<int>.from(map['ids']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteMenusUsecaseParams.fromJson(String source) =>
      BulkDeleteMenusUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ids];

  @override
  String toString() => 'BulkDeleteMenusUsecaseParams(ids: $ids)';
}
