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
      'Executing delete customer usecase for id: ${params.id}',
    );
    return _repository.bulkDeleteCustomers(params);
  }
}

class BulkDeleteCustomersUsecaseParams extends Equatable {
  final List<int> id;

  BulkDeleteCustomersUsecaseParams(this.id);

  BulkDeleteCustomersUsecaseParams copyWith({List<int>? id}) {
    return BulkDeleteCustomersUsecaseParams(id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  factory BulkDeleteCustomersUsecaseParams.fromMap(Map<String, dynamic> map) {
    return BulkDeleteCustomersUsecaseParams(List<int>.from(map['id']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteCustomersUsecaseParams.fromJson(String source) =>
      BulkDeleteCustomersUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'BulkDeleteCustomersUsecaseParams(id: $id)';
}
