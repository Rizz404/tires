import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';

class BulkDeleteCustomersUsecase
    implements Usecase<ActionSuccess, BulkDeleteCustomersUsecaseParams> {
  final CustomerRepository _repository;

  BulkDeleteCustomersUsecase(this._repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    BulkDeleteCustomersUsecaseParams params,
  ) {
    AppLogger.businessInfo(
      'Executing delete customer usecase for ids: ${params.ids}',
    );
    return _repository.bulkDeleteCustomers(params);
  }
}

class BulkDeleteCustomersUsecaseParams extends Equatable {
  final List<int> ids;

  BulkDeleteCustomersUsecaseParams(this.ids);

  BulkDeleteCustomersUsecaseParams copyWith({List<int>? ids}) {
    return BulkDeleteCustomersUsecaseParams(ids ?? this.ids);
  }

  Map<String, dynamic> toMap() {
    return {'ids': ids};
  }

  factory BulkDeleteCustomersUsecaseParams.fromMap(Map<String, dynamic> map) {
    return BulkDeleteCustomersUsecaseParams(List<int>.from(map['ids']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteCustomersUsecaseParams.fromJson(String source) =>
      BulkDeleteCustomersUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ids];

  @override
  String toString() => 'BulkDeleteCustomersUsecaseParams(ids: $ids)';
}
