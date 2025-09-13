// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';

class GetCustomerCursorUsecase
    implements
        Usecase<CursorPaginatedSuccess<Customer>, GetCustomerCursorParams> {
  final CustomerRepository _customerRepository;

  GetCustomerCursorUsecase(this._customerRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Customer>>> call(
    GetCustomerCursorParams params,
  ) async {
    return await _customerRepository.getCustomerCursor(params);
  }
}

class GetCustomerCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  const GetCustomerCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  @override
  List<Object?> get props => [paginate, perPage, cursor];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate.toString(),
      'per_page': perPage.toString(),
      if (cursor != null) 'cursor': cursor,
    };
  }

  String toJson() => json.encode(toMap());
}
