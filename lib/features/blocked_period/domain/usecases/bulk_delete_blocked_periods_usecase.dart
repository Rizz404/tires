import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';

class BulkDeleteBlockedPeriodsUsecase
    implements Usecase<ActionSuccess, BulkDeleteBlockedPeriodsUsecaseParams> {
  final BlockedPeriodRepository _repository;

  BulkDeleteBlockedPeriodsUsecase(this._repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    BulkDeleteBlockedPeriodsUsecaseParams params,
  ) {
    AppLogger.businessInfo(
      'Executing delete blocked period usecase for id: ${params.id}',
    );
    return _repository.bulkDeleteBlockedPeriods(params);
  }
}

class BulkDeleteBlockedPeriodsUsecaseParams extends Equatable {
  final List<int> id;

  BulkDeleteBlockedPeriodsUsecaseParams(this.id);

  BulkDeleteBlockedPeriodsUsecaseParams copyWith({List<int>? id}) {
    return BulkDeleteBlockedPeriodsUsecaseParams(id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  factory BulkDeleteBlockedPeriodsUsecaseParams.fromMap(
    Map<String, dynamic> map,
  ) {
    return BulkDeleteBlockedPeriodsUsecaseParams(List<int>.from(map['id']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteBlockedPeriodsUsecaseParams.fromJson(String source) =>
      BulkDeleteBlockedPeriodsUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'BulkDeleteBlockedPeriodsUsecaseParams(id: $id)';
}
