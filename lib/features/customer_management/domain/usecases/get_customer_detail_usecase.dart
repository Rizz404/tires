// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/customer_management/domain/entities/customer_detail.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';

class GetCustomerDetailUsecase
    implements
        Usecase<ItemSuccessResponse<CustomerDetail>, GetCustomerDetailParams> {
  final CustomerRepository _customerRepository;

  GetCustomerDetailUsecase(this._customerRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<CustomerDetail>>> call(
    GetCustomerDetailParams params,
  ) async {
    AppLogger.businessInfo('Executing get customer cursor usecase');
    return await _customerRepository.getCustomerDetail(params);
  }
}

class GetCustomerDetailParams extends Equatable {
  final String id;

  const GetCustomerDetailParams({required this.id});

  GetCustomerDetailParams copyWith({String? id}) {
    return GetCustomerDetailParams(id: id ?? this.id);
  }

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }

  String toJson() => json.encode(toMap());

  factory GetCustomerDetailParams.fromMap(Map<String, dynamic> map) {
    return GetCustomerDetailParams(id: map['id'] as String);
  }

  factory GetCustomerDetailParams.fromJson(String source) =>
      GetCustomerDetailParams.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;
}
